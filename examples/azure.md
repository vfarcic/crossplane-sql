# Azure PostgreSQL Example

FIXME: Rewrite to follow the same pattern as `google.md`.

```sh
az keyvault secret set \
    --vault-name $RESOURCE_GROUP \
    --name db-root-password \
    --value "{\"password\": \"IWillNeverTell\" }"
```