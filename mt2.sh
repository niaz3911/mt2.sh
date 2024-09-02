// For format details, see https://aka.ms/devcontainer.json. For config options, see the
// README at: https://github.com/devcontainers/templates/tree/main/src/kubernetes-helm
{
	"name": "Kubernetes-in-Codespaces",
	"dockerFile": "Dockerfile",
	//"name": "Kubernetes - Local Configuration",
	// Or use a Dockerfile or Docker Compose file. More info: https://containers.dev/guide/dockerfile
	//"image": "mcr.microsoft.com/devcontainers/base:bullseye",

	// do not change these if you want Docker in Docker support
	"runArgs": ["--init", "--privileged", "--network=host"],
	"mounts": [ "source=/var/run/docker.sock,target=/var/run/docker-host.sock,type=bind" ],
	"overrideCommand": false,

	// some base images require a specific user name
	"remoteUser": "vscode",

	// Install extensions
	"customizations": {
		"vscode": {	
			// Set container specific settings
			"settings": {
				"terminal.integrated.defaultProfile.linux": "zsh"
			},			
			"extensions": [
				"ms-azuretools.vscode-docker",
				"ms-kubernetes-tools.vscode-kubernetes-tools",
				"davidanson.vscode-markdownlint",
				"gruntfuggly.todo-tree",
				"mutantdino.resourcemonitor",
				"humao.rest-client",
				"ms-vscode.makefile-tools"
			]
		}
	},

	// Use 'forwardPorts' to make a list of ports inside the container available locally.
	"forwardPorts": [
		80,
		4317,
		4318,
		30100,
		30105
	],

	// add labels
	"portsAttributes": {
		"80": { "label": "Demo App" },
		"30100": { "label": "ArgoCD" },
		"30105": { "label": "Backstage" },
		"4317": {"label": "OTEL Collector gRPC"},
		"4318": {"label": "OTEL Collector HTTP"}
	},

	"hostRequirements": {
		"cpus": 2
	},

	// Use 'postCreateCommand' to run commands after the container is created.
	"postCreateCommand": "chmod +x .devcontainer/post-create.sh && .devcontainer/post-create.sh",

	// Use 'postStartCommand' to run commands after the container starts.
    "postStartCommand": "chmod +x .devcontainer/post-start.sh && .devcontainer/post-start.sh",

	// Add recommended secrets
	"secrets": {
		"DT_ENV": {
			"description": "Please use one of the following words: live, sprint or dev. If unsure, use live"
		},
		"DT_ENV_NAME": {
			"description": "`abc12345` from `https://abc12345.live.apps.dynatrace.com`"
		},
		"DT_RW_API_TOKEN": {
			"description": "A Dynatrace access token with these permissions: `apiTokens.read` and `apiTokens.write`"
		},
		"DT_OAUTH_CLIENT_ID": {
			"description": "Create an oAuth client to send business events (see documentation link for instructions)",
			"documentationUrl": "https://www.dynatrace.com/support/help/platform-modules/business-analytics/ba-api-ingest"
		},
		"DT_OAUTH_CLIENT_SECRET": {
			"description": "This value will be provided when you create the oAuth client (see above)",
			"documentationUrl": "https://www.dynatrace.com/support/help/platform-modules/business-analytics/ba-api-ingest"
		},
		"DT_OAUTH_ACCOUNT_URN": {
			"description": "This value will be provided when you create the oAuth client (see above)",
			"documentationUrl": "https://www.dynatrace.com/support/help/platform-modules/business-analytics/ba-api-ingest"
		}
	}


}
