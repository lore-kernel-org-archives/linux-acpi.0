From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 1/2] ACPICA: revert acpi_os_validate_address() removal
Date: Tue, 28 Jul 2009 10:44:02 +0800
Message-ID: <1248749042.3166.65.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:50339 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751919AbZG1Cmg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Jul 2009 22:42:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, "Moore, Robert" <robert.moore@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

>From 18c15c0fc4affa89db70fee2127cfd76d92cb2d1 Mon Sep 17 00:00:00 2001
From: Lin Ming <ming.m.lin@intel.com>
Date: Tue, 28 Jul 2009 10:31:36 +0800
Subject: [PATCH] ACPICA: revert acpi_os_validate_address() removal

Commit f9ca058430333c9a24c5ca926aa445125f88df18
"ACPICA: Remove obsolete acpi_os_validate_address interface"
caused a regression, as it disabled our mechanism
for preventing conflicts between ACPI and native hardware drivers.

http://bugzilla.kernel.org/show_bug.cgi?id=13620

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/acpica/acobject.h |    1 +
 drivers/acpi/acpica/dsopcode.c |   24 ++++++++++++++++++++++++
 drivers/acpi/acpica/exfldio.c  |    6 ++++++
 include/acpi/acpiosxf.h        |    4 ++++
 4 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 544dcf8..eb6f038 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -97,6 +97,7 @@
 #define AOPOBJ_OBJECT_INITIALIZED   0x08
 #define AOPOBJ_SETUP_COMPLETE       0x10
 #define AOPOBJ_SINGLE_DATUM         0x20
+#define AOPOBJ_INVALID              0x40	/* Used if host OS won't allow an op_region address */
 
 /******************************************************************************
  *
diff --git a/drivers/acpi/acpica/dsopcode.c b/drivers/acpi/acpica/dsopcode.c
index 584d766..b79978f 100644
--- a/drivers/acpi/acpica/dsopcode.c
+++ b/drivers/acpi/acpica/dsopcode.c
@@ -397,6 +397,30 @@ acpi_status acpi_ds_get_region_arguments(union acpi_operand_object *obj_desc)
 	status = acpi_ds_execute_arguments(node, acpi_ns_get_parent_node(node),
 					   extra_desc->extra.aml_length,
 					   extra_desc->extra.aml_start);
+	if (ACPI_FAILURE(status)) {
+		return_ACPI_STATUS(status);
+	}
+
+	/* Validate the region address/length via the host OS */
+
+	status = acpi_os_validate_address(obj_desc->region.space_id,
+					  obj_desc->region.address,
+					  (acpi_size) obj_desc->region.length,
+					  acpi_ut_get_node_name(node));
+
+	if (ACPI_FAILURE(status)) {
+		/*
+		 * Invalid address/length. We will emit an error message and mark
+		 * the region as invalid, so that it will cause an additional error if
+		 * it is ever used. Then return AE_OK.
+		 */
+		ACPI_EXCEPTION((AE_INFO, status,
+				"During address validation of OpRegion [%4.4s]",
+				node->name.ascii));
+		obj_desc->common.flags |= AOPOBJ_INVALID;
+		status = AE_OK;
+	}
+
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index cb2eb55..d7b3b41 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -113,6 +113,12 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 		}
 	}
 
+	/* Exit if Address/Length have been disallowed by the host OS */
+
+	if (rgn_desc->common.flags & AOPOBJ_INVALID) {
+		return_ACPI_STATUS(AE_AML_ILLEGAL_ADDRESS);
+	}
+
 	/*
 	 * Exit now for SMBus or IPMI address space, it has a non-linear address space
 	 * and the request cannot be directly validated
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 3e79859..ab0b85c 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -242,6 +242,10 @@ acpi_os_derive_pci_id(acpi_handle rhandle,
 acpi_status acpi_os_validate_interface(char *interface);
 acpi_status acpi_osi_invalidate(char* interface);
 
+acpi_status
+acpi_os_validate_address(u8 space_id, acpi_physical_address address,
+			 acpi_size length, char *name);
+
 u64 acpi_os_get_timer(void);
 
 acpi_status acpi_os_signal(u32 function, void *info);


