az login --allow-no-subscriptions
az config set extension.use_dynamic_install=yes_without_prompt
rem https://dev.azure.com/AD-NAV/ADL.BC.DEV/_packaging?_a=package&feed=Adacta-BC-Loc%40Release&package=adacta-bc-loc&protocolType=UPack&version=15.0.12
az artifacts universal download --organization "https://dev.azure.com/AD-NAV/" --feed "Adacta-BC-Loc" --name "adacta-bc-loc" --version "15.0.12" --path .
az logout  