{ config, pkgs, ... }:

{
  home.file = {
    "networkmanager-dmenu/config.ini".text = ''
      [dmenu]
      dmenu_command = rofi
      active_chars = ==
      highlight = True
      highlight_fg =
      highlight_bg =
      highlight_bold = True
      compact = False
      pinentry =
      wifi_icons = 󰤯󰤟󰤢󰤥󰤨
      format = {name:<{max_len_name}s}  {sec:<{max_len_sec}s} {icon:>4}
      list_saved = False
      prompt = Networks

      [dmenu_passphrase]
      obscure = False
      obscure_color = #222222

      [pinentry]
      description = Get network password
      prompt = Password:

      [editor]
      terminal = foot
      gui_if_available = True
      gui = nm-connection-editor

      [nmdm]
      rescan_delay = 5
    '';

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
          helper = ${pkgs.git-credential-manager}/bin/git-credential-manager
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

    ".config/powershell/Microsoft.PowerShell_profile.ps1".text = ''
      Register-PSRepository -Default
      Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
      install-module posh-git,az,microsoft.graph

      function debug-me() { Set-PSBreakpoint -Variable StackTrace -Mode Write }
      function copy-me( $name ) { New-Variable -Name $name -Value $lw.clone() -Scope Global }
      New-Alias -Name ctj -Value ConvertTo-Json
      New-Alias -Name cfj -Value ConvertFrom-Json
      New-Alias -Name d -Value podman
      New-Alias -Name k -Value kubectl
      New-Alias -Name f -Value flux
      New-Alias -Name i -Value istioctl

      function New-BashStyleAlias([string]$name, [string]$command) {
        $sb = [scriptblock]::Create($command)
        New-Item "Function:\global:$name" -Value $sb | Out-Null
      }

      # podman
      New-BashStyleAlias dr  'podman rm @args'
      New-BashStyleAlias dri 'podman rmi @args'
      function dsa($name) { podman start $name; podman attach $name }
      function dgi() { podman images }
      function dga() { podman ps -a }
      function dra() { podman rm $(podman ps -qa) }
      function dxi($image) { podman run --rm -it $image bash }
      function dxe($image) { podman run --rm -d --entrypoint '/bin/bash' $image -c 'sleep 1000000' }

      # kubernetes
      New-BashStyleAlias kk   'kubectl config @args'
      New-BashStyleAlias kkg  'kubectl config get-contexts @args'
      New-BashStyleAlias kks  'kubectl config set-context @args'
      New-BashStyleAlias kku  'kubectl config use-context @args'
      New-BashStyleAlias kd   'kubectl describe @args'
      New-BashStyleAlias kdbg 'kubectl debug @args'
      New-BashStyleAlias ka   'kubectl apply -f @args'
      New-BashStyleAlias kr   'kubectl delete @args'
      New-BashStyleAlias kra  'kubectl delete --all @args'
      New-BashStyleAlias kl   'kubectl logs @args'
      New-BashStyleAlias kf   'kubectl port-forward @args'
      New-BashStyleAlias ke   'kubectl edit @args'
      New-BashStyleAlias kc   'kubectl create @args'
      New-BashStyleAlias ks   'kubectl scale @args'
      New-BashStyleAlias kx   'kubectl exec @args'
      New-BashStyleAlias kxi  'kubectl exec -it @args'
      New-BashStyleAlias kt   'kubectl top @args'
      New-BashStyleAlias kta  'kubectl top @args --all-namespaces'
      New-BashStyleAlias kg   'kubectl get @args'
      New-BashStyleAlias kgo  'kubectl get -o yaml @args'
      New-BashStyleAlias kgj  'kubectl get -o json @args'
      New-BashStyleAlias kga  'kubectl get --all-namespaces @args'
      New-BashStyleAlias kgaj 'kubectl get --all-namespaces -o json @args'
      New-BashStyleAlias kapi 'kubectl api-resources @args'
      function kns {
        Param(
          [Parameter(Mandatory = $true)]
          [ArgumentCompleter( { @( (kubectl get namespaces -o jsonpath='{.items[*].metadata.name}').Split() -like $args[2] + '*') } )]
          [string]$namespace
        )
        kubectl config set-context (kubectl config current-context) --namespace $namespace
      }

      function kdn {
        Param(
          [Parameter(Mandatory = $true)]
          [ArgumentCompleter( { @( (kubectl get node -oname).Split() -like $args[2] + '*') } )]
          [string]$node,
          [string]$image = "busybox"
        )
        kubectl debug -it $node --image=$image
      }

      function helm-me ($helmRelease) {
        $namespace = kubectl config view --minify -o jsonpath='{..namespace}'
        $resources = helm get manifest $helmRelease | k apply -f - --dry-run=client
        $resources.foreach{
          $res = $_.Split() | Select -First 1
          kubectl label $res app.kubernetes.io/managed-by=Helm
          kubectl annotate $res meta.helm.sh/release-name=$helmRelease
          kubectl annotate $res meta.helm.sh/release-namespace=$namespace
        }
      }

      function get-k8s-api-deprecation {
        (kubectl get --raw /metrics | sls '^apiserver_requested_deprecated_apis')
      }

      function istio-debug-me {
        param(
          [Parameter(Mandatory=$false)]
          [ArgumentCompleter( { @( "admin","alternate_protocols_cache","aws","assert","backtrace","cache_filter","client","config","connection","conn_handler","decompression","dns","dubbo","envoy_bug","ext_authz","rocketmq","file","filter","forward_proxy","grpc","happy_eyeballs","hc","health_checker","http","http2","hystrix","init","io","jwt","kafka","key_value_store","lua","main","matcher","misc","mongo","quic","quic_stream","pool","rbac","redis","router","runtime","stats","secret","tap","testing","thrift","tracing","upstream","udp","wasm" -like $args[2] + '*') } )]
          [string]$logger
        )
        if ( [string]::IsNullOrEmpty($logger) ) {
          $log = "level"
        } else {
          $log = $logger
        }
        $job = istio-gateway-pf-me
        Invoke-RestMethod "http://localhost:15000/logging?$log=debug" -Method:Post
        $job | Remove-Job -Force
      }

      function istio-gateway-me ([switch]$internal) {
        $selector = "istio=ingressgateway"
        if ($internal) { $selector = "istio=ingressgateway-internal" }
        kubectl get pods --namespace istio-system --selector $selector -oname | Get-Random
      }

      function istio-gateway-pf-me {
        Start-Job -ScriptBlock {
          kubectl port-forward $args[0] --namespace istio-system 15000
        } -ArgumentList $( istio-gateway-me )
      }

      function istio-gateway-config-me {
        $job = istio-gateway-pf-me
        $json = Invoke-WebRequest -UseBasicParsing http://localhost:15000/config_dump
        $json.content | Set-Clipboard
        $job | Remove-Job -Force
      }

      function istio-gateway-log-me {
        kubectl logs $( istio-gateway-me ) -n istio-system -f --since=1s istio-proxy
      }

      function secret-me ( $secretName ) {
        $secret = kubectl get secret -o json $secretName | ConvertFrom-Json
        $secret.data.PSObject.Properties.foreach{
            @{ $PSItem.Name = [System.Text.Encoding]::UTF8.GetString( [System.Convert]::FromBase64String( $PSItem.Value ) ) }
        }
      }

      function suspend-me ( $targetName, $targetType ) {
        $targetJson = kubectl get $targetType $targetName -o json | ConvertFrom-Json
        $tempFile = New-TemporaryFile
        "spec:
          template:
            spec:
              containers:
              - name: $($targetJson.spec.template.spec.containers[0].name)
                command: ['sh','-c','sleep 10000s']" > $tempFile.FullName

        kubectl patch $targetType $targetName -p ( Get-Content -Raw $tempFile.FullName )
        Remove-Item $tempFile
      }

      # azure
      function timestamp-me {
        [CmdletBinding()]
        Param(
          [Parameter(Mandatory=$true)]
          [string]$resourceId,
          [Parameter(Mandatory=$false)]
          [string]$apiVersion = "2022-09-01"
        )

        $arr = $resourceId -split '/'
        $subscriptionId = $arr[2]
        $resourceType = "{0}/{1}" -f $arr[6], $arr[7]
        $resourceName = $arr[-1]

        $Uri = "https://management.azure.com/subscriptions/{0}/resources?`$filter=name eq '{1}' and resourceType eq '{2}'&`$expand=createdTime&api-version={3}"
        $response = Invoke-AzRest -Uri ( $uri -f $subscriptionId, $resourceName, $resourceType, $apiVersion )
        $result = $response.Content | ConvertFrom-Json

        if( -not $result.value.createdTime ) { Throw "No 'CreatedTime' property" }
        $result.value.createdTime
      }

      # miscellaneous
      Set-Location "~/_git"
      Import-Module posh-git
      $GitPromptSettings.DefaultPromptSuffix.Text = ""
      $GitPromptSettings.DefaultPromptBeforeSuffix.Text = ' [$(get-date -Format "hh:mm:ss dd-MM-yyyy")]`n'
      $GitPromptSettings.DefaultPromptPath.Text = '$( ( Get-PromptPath ) -replace "C:\\_git","#" )'
      $GitPromptSettings.DefaultPromptAbbreviateGitDirectory = $true
      $PSDefaultParameterValues["Out-Default:OutVariable"] = "lw"
      Set-PSReadLineOption -PredictionViewStyle ListView -PredictionSource History
      Set-PSReadLineKeyHandler -Chord Ctrl+LeftArrow  -Function BackwardWord
      Set-PSReadLineKeyHandler -Chord Ctrl+RightArrow -Function NextWord
      Set-PSReadLineKeyHandler -Chord Alt+LeftArrow  -Function BackwardWord
      Set-PSReadLineKeyHandler -Chord Alt+RightArrow -Function NextWord
      New-BashStyleAlias gtp 'git commit -am typo; git push'
      New-BashStyleAlias gtc 'git commit -am @args'
      New-BashStyleAlias gpf 'git pull --ff-only @args'
      New-BashStyleAlias gfa 'git fetch --all --prune @args'
      New-BashStyleAlias gba 'git branch -a @args'
      New-BashStyleAlias gb 'git branch @args'
      function delete-gharuns ([string]$workflow) {
        gh run list -w $workflow --json url -q '.[].url' --limit 250 | % {
            gh run delete $($_.split('/') | Select-Object -Last 1)
          }
      }

      function workhour-me ([int]$offset, $hours = 8) {
        $now = Get-Date
        $month = $now.Month + $offset
        ( 1..[DateTime]::DaysInMonth( $now.Year, $month) ).where{
          ( Get-Date -Day $_ -Month $month ).DayOfWeek -in 1..5
        }.count * $hours
      }

      function base64-file-me ($b64, $filename = "b64.temp", $print = $true, $encode = $false) {
        if ($encode) {
          $fileBytes = [System.IO.File]::ReadAllBytes("$pwd/$filename")
          [Convert]::ToBase64String($fileBytes)
        } else {
          $bytes = [Convert]::FromBase64String($b64)
          if ($print) {
            [System.Text.Encoding]::UTF8.GetString($bytes)
          } else {
            [IO.File]::WriteAllBytes("$pwd/$filename", $bytes)
          }
        }
      }

      # Clear-Host

    '';
  };



  systemd.user.tmpfiles.rules = [
    "d %h/_git 0755 - - -"
    "d %h/downloads 0755 - - -"
    "d %h/dl 0755 - - -"
    "d %h/.config/git 0755 - - -"
    "d %h/.config/powershell 0755 - - -"
    "d %h/.config/lock 0755 - - -"
    "d %h/.config/onedrive 0755 - - -"
  ];
}
