{
  additional_namespaces: [
    {
      apiVersion: "v1",
      kind: "Namespace",
      metadata: { name: "development" },
    },
    {
      apiVersion: "v1",
      kind: "Namespace",
      metadata: { name: "staging" },
    },
  ],
  service_accounts: [
    {
      apiVersion: "v1",
      kind: "ServiceAccount",
      metadata: {
        name: "dev-service-account",
        namespace: "development",
      },
    },
    {
      apiVersion: "v1",
      kind: "ServiceAccount",
      metadata: {
        name: "stage-service-account",
        namespace: "staging",
      },
    },
  ],
  secrets: [
    {
      apiVersion: "v1",
      kind: "Secret",
      metadata: {
        name: "dev-secret",
        namespace: "development",
      },
      data: {
        password: "c2VjcmV0",  // "secret" в base64
      },
    },
    {
      apiVersion: "v1",
      kind: "Secret",
      metadata: {
        name: "stage-secret",
        namespace: "staging",
      },
      data: {
        password: "c2VjcmV0c3RhZ2U=",  // "secretstage" в base64
      },
    },
  ],
}
