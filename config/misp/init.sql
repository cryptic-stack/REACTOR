-- Initialize MISP database with additional configurations
-- This script runs after the main MISP database initialization

USE misp;

-- Create additional indexes for better performance
CREATE INDEX IF NOT EXISTS idx_events_timestamp ON events(timestamp);
CREATE INDEX IF NOT EXISTS idx_attributes_event_id ON attributes(event_id);
CREATE INDEX IF NOT EXISTS idx_attributes_type ON attributes(type);
CREATE INDEX IF NOT EXISTS idx_attributes_category ON attributes(category);

-- Insert default organization if not exists
INSERT IGNORE INTO organisations (id, name, date_created, date_modified, description, type, nationality, sector, created_by, uuid, contacts, local, restricted_to_domain) 
VALUES (1, 'REACTOR', NOW(), NOW(), 'Default REACTOR organization', 'CSIRT', 'Not Specified', 'IT', 1, UUID(), '', 1, '');

-- Insert default admin user role
INSERT IGNORE INTO roles (id, name, created, modified, perm_add, perm_modify, perm_modify_org, perm_publish, perm_delegate, perm_sync, perm_admin, perm_audit, perm_full, default_role, perm_sharing_group, perm_template, perm_tagger, perm_tag_editor, perm_site_admin, perm_regexp_access, perm_warninglist, perm_view_feed_correlations, memory_limit, max_execution_time, restricted_to_site_admin, enforce_rate_limit, rate_limit_count, perm_publish_zmq, perm_publish_kafka, perm_decaying, permission, permission_description) 
VALUES (1, 'Admin', NOW(), NOW(), 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, '', 0, 0, 0, 0, 1, 1, 1, 0, '');

-- Insert default user role
INSERT IGNORE INTO roles (id, name, created, modified, perm_add, perm_modify, perm_modify_org, perm_publish, perm_delegate, perm_sync, perm_admin, perm_audit, perm_full, default_role, perm_sharing_group, perm_template, perm_tagger, perm_tag_editor, perm_site_admin, perm_regexp_access, perm_warninglist, perm_view_feed_correlations, memory_limit, max_execution_time, restricted_to_site_admin, enforce_rate_limit, rate_limit_count, perm_publish_zmq, perm_publish_kafka, perm_decaying, permission, permission_description) 
VALUES (3, 'User', NOW(), NOW(), 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, '', 0, 0, 0, 0, 0, 0, 1, 0, '');