From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 06/14] ACPI 2.0 / AML: Rename acpi_gbl_reg_methods_enabled to acpi_gbl_namespace_initialized
Date: Sat,  6 Feb 2016 11:53:07 +0800
Message-ID: <2a1feccf2cbf2a08b1f02d37223983c7f0cda2b3.1454730659.git.lv.zheng@intel.com>
References: <cover.1454730659.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1454730659.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 4be3b82cf45d324366ea8567102d5108c5ef47cb

The global variable actually means the availability of the namespace, and
control methods evaluations should happen after namespace readiness. Thus
this patch renames the global variable to reflect this logic. Lv Zheng.

Link: https://github.com/acpica/acpica/commit/4be3b82c
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    2 +-
 drivers/acpi/acpica/evregion.c |    2 +-
 drivers/acpi/acpica/utxfinit.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

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
 
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 6a0c2ee..139f65f 100644
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
