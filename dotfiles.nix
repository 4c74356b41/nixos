{ config, pkgs, ... }:

{
  home.file = {
    ".config/onedrive/config".text = ''
      sync_dir = "/home/sway/dl"
      skip_dir = "tb"
      skip_dir = "Pictures"
      skip_dir = "Desktop"
      skip_dir = "Attachments"
      skip_dir = "ArrowBackup"
    '';
    
    ".config/lock/config".text = ''
      show-keyboard-layout
      ignore-empty-password
      indicator-idle-visible
  
      color=A3A3A3
      inside-color=000000
      ring-color=0000ff
    '';

    ".config/git/config".text = ''
      [user]
          email = core@4c74356b41.com
          name = Gleb Boushev
      [core]
          eol = lf
          autocrlf = input
          excludesfile = ~/.config/git/ignore
      [pull]
          ff = only
      [core]
      
      [push]
          autoSetupRemote = true
      
      [credential]
          helper = cache
    '';

    ".config/git/ignore".text = ''
      .claude
      
      # OS Generated Files
      .DS_Store
      .DS_Store?
      ._*
      .Spotlight-V100
      .Trashes
      ehthumbs.db
      Thumbs.db
      desktop.ini
      
      # OS Swap/Backup
      *~
      *.swp
      *.swo
      *~
      
      # IDE/Editor
      .vscode/settings.json
      .vscode/tasks.json
      .vscode/launch.json
      .vscode/**/*.code-snippets
      .idea/
      *.code-workspace
      .project
      .settings/
      .classpath
      
      # Logs/Debug
      *.log
      npm-debug.log*
      yarn-debug.log*
      yarn-error.log*
      lerna-debug.log*
      .pnpm-debug.log*
      
      # Dependencies
      node_modules/
      .pnp
      .pnp.js
      .yarn/
      .env
      .env.local
      .env.development.local
      .env.test.local
      .env.production.local
      Dockerfile.*.env
      
      # Azure DevOps / Bicep
      *.bicepparam*
      azresourcegroup.json
      aztfplan.json
      core.bicepparam.json
      
      # Terraform
      *.tfstate
      *.tfstate.*
      .terraform/
      crash.log
      override.tf
      override.tf.json
      *_override.tf
      *_override.tf.json
      .terraformrc
      terraform.rc
      .terraform.lock.hcl
      .crash.log
      crash.log
      .terraform.tfstate*
      *.terraform.tfstate.backup
      
      # Python
      __pycache__/
      *.py[cod]
      *$py.class
      *.so
      .Python
      build/
      develop-eggs/
      dist/
      downloads/
      eggs/
      .eggs/
      lib/
      lib64/
      parts/
      sdist/
      var/
      wheels/
      *.egg-info/
      .installed.cfg
      *.egg
      MANIFEST
      pip-log.txt
      pip-delete-this-directory.txt
      
      # Python Virtual Env
      venv/
      env/
      ENV/
      env.bak/
      venv.bak/
      .venv/
      
      # Jupyter
      .ipynb_checkpoints/
      .ipynb_checkpoints
      *.ipynb_checkpoints
      
      # Pytest
      .pytest_cache/
      .coverage
      htmlcov/
      .cache
      nosetests.xml
      coverage.xml
      *.cover
      *.pytest_cache/
      hypothesis/
      
      # Kubernetes/Helm
      *.kubeconfig
      .kube/
      .kubeconfig
      values-local.yaml
      Chart.lock
      /charts
      
      # Docker
      Dockerfile*
      docker-compose.override.yml
      docker-compose.*.yml
      
      # PowerShell
      *.ps1~ 
      pwsh_history
      PSReadLine/
      
      # CI/CD
      !.github/workflows/
      !.azure-pipelines/
      
      # Binaries/Artifacts
      *.exe
      *.exe~
      *.dll
      *.dylib
      *.so
      *.dylib*
      
      # Temp/Backup
      *.bak
      *.backup
      *.tmp
      *.temp
      *.swp
      *.swo
      *~
      
      # Testing
      coverage/
      .nyc_output
      test-results/
      test-output/
      
      # Azure CLI
      .azcopy/
      az-session.json
      
      # Ansible
      .ansible.cfg
      .ansible-lint
      .ansible-lint-cache
      
      # Bicep
      bicep.*.json
      
      # ARM Templates
      azuredeploy.parameters.json
      
      # Miscellaneous
      *.DS_Store
      .DS_Store
      ._*
      .Spotlight-V100
      .Trashes
      ehthumbs.db
      Thumbs.db
      desktop.ini
      
      # system
      .bash_history
      .bash_logout
      .bash_profile
      .bashrc
      .config/Thunar/
      .config/VSCodium/
      .config/copyq/
      .config/dconf/
      .config/lxqt/
      .config/od/
      .config/pavucontrol.ini
      .config/pulse/
      .config/systemd/
      .config/toolbox/
      .config/user-dirs.locale
      .config/xarchiver/
      .config/xfce4/
      .dotfiles/
      .git-credentials
      .local/
      .mozilla/
      .pki/
      .sudo_as_admin_successful
      .var/
      .vscode-oss/
      
      # personal
      _git/
      od/
    '';
  };

  systemd.user.tmpfiles.rules = [
    "d %h/_git 0755 - - -"
    "d %h/downloads 0755 - - -"
    "d %h/dl 0755 - - -"
    "d %h/.config/git 0755 - - -"
    "d %h/.config/lock 0755 - - -"
    "d %h/.config/onedrive 0755 - - -"
  ];
}
