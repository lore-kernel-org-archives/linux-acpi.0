From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH] ACPICA: Revert "ACPICA: Remove obsolete
 acpi_os_validate_address interface"
Date: Wed, 01 Jul 2009 10:29:51 +0800
Message-ID: <1246415391.24831.30.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16849 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752342AbZGAC2U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Jun 2009 22:28:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, "Moore, Robert" <robert.moore@intel.com>, Zhao Yakui <yakui.zhao@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>

    Revert "ACPICA: Remove obsolete acpi_os_validate_address interface"
    
    This reverts commit f9ca058430333c9a24c5ca926aa445125f88df18.
    
    The quick fix of bug 13620 would be to revert the change.
    http://bugzilla.kernel.org/show_bug.cgi?id=13620
    
    Also, see the commit df92e695998e1bc6e426a840eb86d6d1ee87e2a5
    "ACPI: track opregion names to avoid driver resource conflicts."
    
    But there are problems we need to address:
    
    1. We need to enhance the mechanism of avoiding driver resource conflicts
       to base a "resource" on Field definitions instead of Operation Region definitions.
    
    2. For dynamic region, we need an interface to call when an operation region (field) is deleted,
       in order to delete it from the resource list.
    
    3. If the same region is created and added to resource list over and over again,
       this is have the potential to be a memory leak by growing the list every time
    
    CC: Thomas Renninger <trenn@suse.de>
    Signed-off-by: Lin Ming <ming.m.lin@intel.com>
    Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
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
index d4075b8..6687be1 100644
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
 	 * Exit now for SMBus address space, it has a non-linear address space
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


