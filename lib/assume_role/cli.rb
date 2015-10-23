# vim: sw=2
module AssumeRole
  class CLI < Thor
    default_command :assume_role

    class_option :profile, type: :string, desc: "profile"

    desc "assume_role", "assume_role"
    def assume_role
      set_credentials

      cred = Aws.config[:credentials].credentials

      env = {}
      env["AWS_ACCESS_KEY_ID"] = cred.access_key_id
      env["AWS_SECRET_ACCESS_KEY"] = cred.secret_access_key
      env["AWS_SESSION_TOKEN"] = cred.session_token

      env.each do |k, v|
        puts "#{k}=#{v}"
      end
    end

    private
    def set_credentials
      profile_name = options[:profile]
      profile_name ||= ENV['AWS_PROFILE']

      # with assume_role
      if profile_name
        aws_config = AWSConfig.profiles[profile_name].entries
        if aws_config["role_arn"]
          role_opt = {}
          role_opt[:role_arn] = aws_config["role_arn"]
          role_opt[:role_session_name] = aws_config["role_session_name"]
          role_opt[:role_session_name] ||= 'session-name'
          if aws_config["source_profile"]
            role_opt[:client] = Aws::STS::Client.new(credentials: Aws::SharedCredentials.new(profile_name: aws_config["source_profile"]))
          end
          credentials = Aws::AssumeRoleCredentials.new(role_opt)
          Aws.config[:credentials] = credentials
        end
      end
    end

  end
end
