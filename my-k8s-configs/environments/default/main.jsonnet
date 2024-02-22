// Import the Kubernetes library
local k = import '../../lib/k.libsonnet';

// Define reusable components
local namespace(name) = k.core.v1.namespace.new(name);
local serviceAccount(name) = k.core.v1.serviceAccount.new(name); // Adjusted
local secret(name, data) = k.core.v1.secret.new(name, data); // Adjusted

{
  // Define resources
  namespaces: [
    namespace('dev'),
    namespace('test'),
    namespace('prod'),
  ],

  serviceAccounts: [
    serviceAccount('dev-service-account'),
    serviceAccount('test-service-account'),
  ],

  secrets: [
    secret('dev-secret', { key: 'dmFsdWU=' }), // 'value' base64 encoded
    secret('test-secret', { key: 'YW5vdGhlclZhbHVl' }), // 'anotherValue' base64 encoded
  ],
}
