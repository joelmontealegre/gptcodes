using System;
using Azure.Identity;
using Azure.Security.KeyVault.Secrets;

class Program
{
    static void Main(string[] args)
    {
        string keyVaultName = "spherevault";
        string secretName = "test1";


        var credential = new DefaultAzureCredential();
        var client = new SecretClient(new Uri($"https://{keyVaultName}.vault.azure.net"), credential);

        ListSecrets(client);
    }

    static void ListSecrets(SecretClient client)
    {
        foreach (SecretProperties secretProperties in client.GetPropertiesOfSecrets())
        {
            KeyVaultSecret secret = client.GetSecretAsync(secretProperties.Name).Result;

            Console.WriteLine($"Secret Name: {secretProperties.Name}");
            Console.WriteLine($"Secret Value: {secret.Value}");
            Console.WriteLine();

        }
    }
}
