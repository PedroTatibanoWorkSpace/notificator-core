CREATE TABLE clients (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20) NOT NULL,
    document VARCHAR(20),
    notes VARCHAR(255),
    metadata JSONB,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now(),
    deleted_at TIMESTAMP NULL
);

CREATE INDEX idx_clients_tenant_id ON clients(tenant_id);

CREATE UNIQUE INDEX ux_clients_tenant_email ON clients(tenant_id, email) WHERE email IS NOT NULL AND deleted_at IS NULL;
CREATE UNIQUE INDEX ux_clients_tenant_phone ON clients(tenant_id, phone) WHERE phone IS NOT NULL AND deleted_at IS NULL;
CREATE UNIQUE INDEX ux_clients_tenant_document ON clients(tenant_id, document) WHERE document IS NOT NULL AND deleted_at IS NULL;
