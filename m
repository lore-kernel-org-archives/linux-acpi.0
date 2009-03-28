From: Len Brown <lenb@kernel.org>
Subject: [PATCH 46/98] ACPICA: Remove obsolete acpi_os_validate_address
 interface
Date: Sat, 28 Mar 2009 00:31:21 -0400
Message-ID: <f9ca058430333c9a24c5ca926aa445125f88df18.1238214619.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:34767 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753675AbZC1Ecv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:51 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700E2T8MOCZRV@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:49 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This interface is no longer necessary. Requests should be validated
on a per-field basis, not on the entire operation region.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acobject.h |    1 -
 drivers/acpi/acpica/dsopcode.c |   24 ------------------------
 drivers/acpi/acpica/exfldio.c  |    6 ------
 include/acpi/acpiosxf.h        |    4 ----
 4 files changed, 0 insertions(+), 35 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index eb6f038..544dcf8 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -97,7 +97,6 @@
 #define AOPOBJ_OBJECT_INITIALIZED   0x08
 #define AOPOBJ_SETUP_COMPLETE       0x10
 #define AOPOBJ_SINGLE_DATUM         0x20
-#define AOPOBJ_INVALID              0x40	/* Used if host OS won't allow an op_region address */
 
 /******************************************************************************
  *
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 602ddaa..b4c87b5 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -397,30 +397,6 @@ acpi_status acpi_ds_get_region_arguments(union acpi_operand_object *obj_desc)
 	status = acpi_ds_execute_arguments(node, acpi_ns_get_parent_node(node),
 					   extra_desc->extra.aml_length,
 					   extra_desc->extra.aml_start);
-	if (ACPI_FAILURE(status)) {
-		return_ACPI_STATUS(status);
-	}
-
-	/* Validate the region address/length via the host OS */
-
-	status = acpi_os_validate_address(obj_desc->region.space_id,
-					  obj_desc->region.address,
-					  (acpi_size) obj_desc->region.length,
-					  acpi_ut_get_node_name(node));
-
-	if (ACPI_FAILURE(status)) {
-		/*
-		 * Invalid address/length. We will emit an error message and mark
-		 * the region as invalid, so that it will cause an additional error if
-		 * it is ever used. Then return AE_OK.
-		 */
-		ACPI_EXCEPTION((AE_INFO, status,
-				"During address validation of OpRegion [%4.4s]",
-				node->name.ascii));
-		obj_desc->common.flags |= AOPOBJ_INVALID;
-		status = AE_OK;
-	}
-
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index 1053e7c..99cee61 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -113,12 +113,6 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 		}
 	}
 
-	/* Exit if Address/Length have been disallowed by the host OS */
-
-	if (rgn_desc->common.flags & AOPOBJ_INVALID) {
-		return_ACPI_STATUS(AE_AML_ILLEGAL_ADDRESS);
-	}
-
 	/*
 	 * Exit now for SMBus address space, it has a non-linear address space
 	 * and the request cannot be directly validated
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index a62720a..178adfb 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -241,10 +241,6 @@ acpi_os_derive_pci_id(acpi_handle rhandle,
 acpi_status acpi_os_validate_interface(char *interface);
 acpi_status acpi_osi_invalidate(char* interface);
 
-acpi_status
-acpi_os_validate_address(u8 space_id, acpi_physical_address address,
-			 acpi_size length, char *name);
-
 u64 acpi_os_get_timer(void);
 
 acpi_status acpi_os_signal(u32 function, void *info);
-- 
1.6.0.6

