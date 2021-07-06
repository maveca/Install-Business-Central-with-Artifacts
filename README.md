# How to use this scripts

Look at Configurations folder and pick the Configuration you want to use.
They represent each type pf container like: Sandbox, Insider...
Configurations should be pre-configured for each project separately.

Open `Manifest.json` file and update File property for chosen configuration file.

## Installing new Business Central Container

Open `New-Container.ps1` script and execute it by hitting F5. This will read Manifest.json with designated configuration file. Then it will execute BCContainerHelper module with
those parameters.

## Using database

Under `Database` folder you will find two scripts `Backup-Database.ps1` for backing up
and `Restore-Database.ps1` for restoring the database. With this ability you can easily
change the underlying service and keeping the same database.

## Useful links

Please read also:
- [Github - script for New-NavContainer](https://github.com/microsoft/navcontainerhelper/blob/master/ContainerHandling/New-NavContainer.ps1)
- [Freddys blog - Troubleshooting Business Central on Docker](https://freddysblog.com/2020/10/12/troubleshooting-business-central-on-docker/)
