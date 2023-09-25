#!/bin/bash
resourceGroupName="rg-tfstate-kada"
storageAccountName="satfstatekada"
location="westeurope"

az group create --location $location --name $resourceGroupName
az storage account create --name $storageAccountName --resource-group $resourceGroupName --location $location --sku Standard_LRS
az storage container create --name tfstate --account-name $storageAccountName
az storage account blob-service-properties update --account-name $storageAccountName --enable-change-feed --enable-versioning true