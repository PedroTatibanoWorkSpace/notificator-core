CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL REFERENCES tenants(id) ON DELETE CASCADE,
    charge_id UUID NOT NULL REFERENCES charges(id) ON DELETE CASCADE,
    paid_at TIMESTAMP NOT NULL,
    amount NUMERIC(12,2) NOT NULL,
    payment_method VARCHAR(50),
    payment_reference VARCHAR(255),
    status VARCHAR(20) NOT NULL,
    metadata JSONB,
    created_at TIMESTAMP DEFAULT now(),
    updated_at TIMESTAMP DEFAULT now()
);

CREATE INDEX idx_payments_tenant_id ON payments(tenant_id);
CREATE INDEX idx_payments_charge_id ON payments(charge_id);
CREATE INDEX idx_payments_status ON payments(status);
CREATE INDEX idx_payments_paid_at ON payments(paid_at);
