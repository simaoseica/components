# TODO: Maybe add all our scripts into a single script for each stage of the build (pre, post build)
[ -f ${SRCROOT}/local_env_variables.sh ] && source ${SRCROOT}/local_env_variables.sh 

${SRCROOT}/scripts/Referiew/CreateImagesDocumentation.rb \
  --github_branch_path https://gitlab.fftech.info/mobile/ios/sof/sfa/raw/dev \
  --project_path /${SRCROOT} \
  --template_path scripts/Referiew/lib/images.html.erb \
  --snapshots_folder ShopfloorTests/Snapshots/Images/Expected_64;