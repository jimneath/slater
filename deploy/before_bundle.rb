notify_deploy_roles = %w(solo app_master)
if notify_deploy_roles.include?(current_role)
   sudo “echo ‘sudo works’ >> /var/log/sudo.log”
end
