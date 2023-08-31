# List all secrets in the Key Vault and save their names to a file
az keyvault secret list --vault-name <vault_name> --query "[].name" --output tsv > secret_names.txt

# Loop through the saved secret names and retrieve their values
while read secret_name; do
    secret_value=$(az keyvault secret show --vault-name <vault_name> --name $secret_name --query "value" --output tsv)
    echo "Secret: $secret_name - Value: $secret_value"
    # You can choose to store or process the secret values as needed
done < secret_names.txt
Replace <subscription_id_or_name> with the appropriate subscription ID or name, and <vault_name> with the name of your Azure Key Vault.

Remember that handling secrets requires strict security practices, and downloading all secrets might expose sensitive information. Always follow best practices for managing secrets and access controls in Azure.





