{ config, pkgs, ... }:
{
  programs = {
    foot = {
      settings.main.shell = "${pkgs.powershell}/bin/pwsh";
      enable = true;
    };
    keepassxc = {
      enable = true;
      settings = {
        Browser = {
          Enabled = true;
          UpdateBinaryPath = false;

          UseCustomBrowser = true;
          CustomBrowserType = 1;
          CustomBrowserLocation = "${config.home.homeDirectory}/.config/google-chrome/NativeMessagingHosts";
        };
        GUI = {
          AdvancedSettings = true;
          ApplicationTheme = "dark";
          CompactMode = true;
          HidePasswords = true;
        };
        Security = {
          AutoLockAfterMinimized = true;
          AutoLockTimeout = 15;
          EnableCopyOnDoubleClick = true;
        };
        FdoSecrets = {
          enabled = true;
        };
      };
    };
    vscode = {
      enable = true;
      profiles.default = {
        userSettings = {
          # --- UI & Layout ---
          "breadcrumbs.enabled" = false;
          "chat.viewSessions.orientation" = "stacked";
          "editor.minimap.enabled" = false;
          "workbench.sideBar.location" = "right";
          "workbench.tree.indent" = 16;

          # --- Editor Behavior & Formatting ---
          "diffEditor.ignoreTrimWhitespace" = true;
          "editor.accessibilitySupport" = "off";
          "editor.formatOnSave" = true;
          "editor.guides.bracketPairs" = "active";
          "editor.inlineSuggest.enabled" = true;
          "editor.renderControlCharacters" = true;
          "editor.renderWhitespace" = "all";
          "editor.unicodeHighlight.invisibleCharacters" = true;
          "editor.unicodeHighlight.nonBasicASCII" = false;

          # --- File & Save Standards ---
          "files.eol" = "\n";
          "files.insertFinalNewline" = true;
          "files.trimFinalNewlines" = true;
          "files.trimTrailingWhitespace" = true;

          # --- Explorer & Search Noise Reduction ---
          "explorer.confirmDelete" = false;
          "explorer.confirmDragAndDrop" = false;
          "explorer.confirmPasteNative" = false;
          "files.exclude" = {
            # OS Noise
            "**/.DS_Store" = true;
            "**/Thumbs.db" = true;
            "**/desktop.ini" = true;
            # Python & Jupyter
            "**/__pycache__" = true;
            "**/.pytest_cache" = true;
            "**/.ipynb_checkpoints" = true;
            "**/*.egg-info" = true;
            "**/*.pyc" = true;
          };

          "search.exclude" = {
            # Environments & Dependencies
            "**/.direnv" = true;
            "**/.venv" = true;
            "**/venv" = true;
            "**/env" = true;
            "**/node_modules" = true;
            # Terraform
            "**/.terraform" = true;
            "**/*.tfstate" = true;
            "**/*.tfstate.backup" = true;
            "**/.terraform.lock.hcl" = true;
            # Build & Cache Directories
            "**/.cache" = true;
            "**/build" = true;
            "**/dist" = true;
            "**/coverage" = true;
            "**/htmlcov" = true;
            # Logs & Binaries
            "**/*.log" = true;
            "**/*.exe" = true;
            "**/*.dll" = true;
            "**/*.so" = true;
          };

          # --- Terminal ---
          "terminal.integrated.defaultProfile.linux" = "pwsh";
          "terminal.integrated.scrollback" = 10000;

          # --- Git ---
          "git.openRepositoryInParentFolders" = "never";

          # --- Language Specifics ---
          "[json]" = {
            "editor.autoIndent" = "advanced";
            "editor.insertSpaces" = true;
            "editor.tabSize" = 2;
          };
          "[jsonc]" = {
            "editor.autoIndent" = "advanced";
            "editor.insertSpaces" = true;
            "editor.tabSize" = 2;
          };
          "[nix]" = {
            "editor.defaultFormatter" = "jnoortheen.nix-ide";
            "editor.formatOnType" = true;
          };
          "[python]" = {
            "editor.formatOnType" = true;
          };
          "[yaml]" = {
            "editor.autoIndent" = "advanced";
            "editor.insertSpaces" = true;
            "editor.tabSize" = 2;
          };

          # --- Nix IDE System Paths ---
          "nix.enableLanguageServer" = true;
          "nix.formatterPath" = "nix3-fmt";
          "nix.serverPath" = "${pkgs.nixd}/bin/nixd";

          # --- PowerShell ---
          "powershell.powerShellAdditionalExePaths" = {
            "local" = "${pkgs.powershell}/bin/pwsh";
          };
          "powershell.codeFormatting.autoCorrectAliases" = true;
          "powershell.codeFormatting.pipelineIndentationStyle" = "IncreaseIndentationForFirstPipeline";
          "powershell.codeFormatting.useCorrectCasing" = true;
          "powershell.promptToUpdatePowerShell" = false;

          # --- Vim ---
          "vim.startInInsertMode" = true;
          "vim.useCtrlKeys" = false;

          # --- AI, Chat & Extensions ---
          "azureTerraform.survey" = {
            "surveyPromptDate" = "never";
            "surveyPromptIgnoredCount" = 0;
          };
          "chat.hookFilesLocations" = {
            ".claude/settings.json" = true;
            ".claude/settings.local.json" = true;
            ".github/hooks" = true;
            "~/.agents/hooks" = true;
            "~/.claude/settings.json" = true;
            "~/.copilot/hooks" = true;
          };
          "chat.mcp.serverSampling" = {
            "Azure MCP Server Provider: Azure MCP" = {
              "allowedDuringChat" = true;
            };
          };
          "extensions.ignoreRecommendations" = true;
          "github.copilot.nextEditSuggestions.enabled" = true;
        };

        extensions = with pkgs.vscode-extensions; [
          hashicorp.terraform
          ms-python.debugpy
          ms-python.python
          ms-python.vscode-pylance
          ms-python.vscode-python-envs
          ms-vscode.powershell
          ms-kubernetes-tools.vscode-kubernetes-tools
          vscodevim.vim
          jnoortheen.nix-ide
        ];
      };
    };
  };
}
