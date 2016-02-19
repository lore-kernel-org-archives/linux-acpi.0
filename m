From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 11/15] ACPICA: Namespace: Rename acpi_gbl_reg_methods_enabled to acpi_gbl_namespace_initialized
Date: Fri, 19 Feb 2016 14:17:22 +0800
Message-ID: <a795e0cc8500aa4df3064360afd8730ed5fdf996.1455857584.git.lv.zheng@intel.com>
References: <cover.1455857575.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1455857575.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 4be3b82cf45d324366ea8567102d5108c5ef47cb
ACPICA commit 19f84c249267fab0bfb138bd14d12510fb4faf24

The global variable actually means the availability of the namespace, and
control methods evaluations should happen after namespace readiness. Thus
this patch renames the global variable to reflect this logic. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/4be3b82c
Link: https://github.com/acpica/acpica/commit/19f84c24
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    2 +-
 drivers/acpi/acpica/evregion.c |    2 +-
 drivers/acpi/acpica/nsinit.c   |    2 +-
 drivers/acpi/acpica/utxfinit.c |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 55c8197..51b073b 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -165,7 +165,7 @@ ACPI_GLOBAL(u8, acpi_gbl_next_owner_id_offset);
 
 /* Initialization sequencing */
 
-ACPI_INIT_GLOBAL(u8, acpi_gbl_reg_methods_enabled, FALSE);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_namespace_initialized, FALSE);
 
 /* Misc */
 
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 47092b4..63924d1 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -600,7 +600,7 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
 
 	if (region_obj2->extra.method_REG == NULL ||
 	    region_obj->region.handler == NULL ||
-	    !acpi_gbl_reg_methods_enabled) {
+	    !acpi_gbl_namespace_initialized) {
 		return_ACPI_STATUS(AE_OK);
 	}
 
diff --git a/drivers/acpi/acpica/nsinit.c b/drivers/acpi/acpica/nsinit.c
index 3281dd8..f029a3d 100644
--- a/drivers/acpi/acpica/nsinit.c
+++ b/drivers/acpi/acpica/nsinit.c
@@ -136,7 +136,7 @@ acpi_status acpi_ns_initialize_objects(void)
 
 acpi_status acpi_ns_initialize_devices(u32 flags)
 {
-	acpi_status status;
+	acpi_status status = AE_OK;
 	struct acpi_device_walk_info info;
 
 	ACPI_FUNCTION_TRACE(ns_initialize_devices);
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 66d6f19..d70649d 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -301,7 +301,7 @@ acpi_status __init acpi_initialize_objects(u32 flags)
 		}
 	}
 
-	acpi_gbl_reg_methods_enabled = TRUE;
+	acpi_gbl_namespace_initialized = TRUE;
 
 	/*
 	 * Initialize all device/region objects in the namespace. This runs
-- 
1.7.10
