#
Set-Location ${PSScriptRoot}
#$env:TZ = '/etc/localtime'
.\traefik.exe --configfile .\traefik.toml
#.\traefik.exe  --api.dashboard=true  --api.insecure=true
#.\traefik.exe --configfile .\traefik.toml --api.dashboard=true  --api.debug=true  --api.insecure=true `
#  --traefik.http.routers.dashboard.rule='(PathPrefix(`/api`) || PathPrefix(`/dashboard`))'  `
#  --traefik.http.routers.dashboard.service=api@internal

#--traefik.http.routers.dashboard.rule='Host(`192.168.168.231`) && (PathPrefix(`/api`) || PathPrefix(`/dashboard`))' `
#  --traefik.enable=true `
#--traefik.http.routers.traefik.service=api@internal `
#--traefik.http.middlewares.traefik-auth.basicauth.users=admin:$$apr1$$8EVjn/nj$$GiLUZqcbueTFeD23SuB6x0 `
#--traefik.http.routers.traefik.middlewares=traefik-auth
