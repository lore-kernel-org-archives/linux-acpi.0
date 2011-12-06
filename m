From: Holger Macht <holger@homac.de>
Subject: [PATCH 1/7] scsi: Export scsi_bus_type
Date: Tue, 6 Dec 2011 17:37:31 +0100
Message-ID: <20111206163731.GB3629@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-scsi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-scsi@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>
List-Id: linux-acpi@vger.kernel.org

From: Matthew Garrett <mjg@redhat.com>

We need scsi_bus_type in order to be able to bind ata devices against
acpi devices. Export it from the scsi core.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Acked-by: Holger Macht <holger@homac.de>
---
 drivers/scsi/scsi_priv.h |    1 -
 include/scsi/scsi.h      |    2 ++
 2 files changed, 2 insertions(+), 1 deletion(-)

Index: linux/drivers/scsi/scsi_priv.h
===================================================================
--- linux.orig/drivers/scsi/scsi_priv.h
+++ linux/drivers/scsi/scsi_priv.h
@@ -134,7 +134,6 @@ extern int scsi_sysfs_target_initialize(
 extern struct scsi_transport_template blank_transport_template;
 extern void __scsi_remove_device(struct scsi_device *);
 
-extern struct bus_type scsi_bus_type;
 extern const struct attribute_group *scsi_sysfs_shost_attr_groups[];
 
 /* scsi_netlink.c */
Index: linux/include/scsi/scsi.h
===================================================================
--- linux.orig/include/scsi/scsi.h
+++ linux/include/scsi/scsi.h
@@ -187,6 +187,8 @@ struct scsi_cmnd;
 
 #define SCSI_MAX_VARLEN_CDB_SIZE 260
 
+extern struct bus_type scsi_bus_type;
+
 /* defined in T10 SCSI Primary Commands-2 (SPC2) */
 struct scsi_varlen_cdb_hdr {
 	__u8 opcode;        /* opcode always == VARIABLE_LENGTH_CMD */
