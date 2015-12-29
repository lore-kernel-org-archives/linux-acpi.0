From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 38/42] ACPICA: Events: Enhance acpi_ev_execute_reg_method() to ensure no _REG evaluations can happen during OS early boot stages
Date: Tue, 29 Dec 2015 14:03:08 +0800
Message-ID: <ff7df012fbc0628131b14aa7368dc428ca6dbdbe.1451367389.git.lv.zheng@intel.com>
References: <cover.1451367388.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1451367388.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

ACPICA commit 31178590dde82368fdb0f6b0e466b6c0add96c57

We can ensure no early _REG evaluations by ensuring the following rules in
acpi_ev_execute_reg_method():
1. If an address space handler is installed during early stage,
   _REG(CONNECT) evaluations are blocked. This is achieved using
   acpi_gbl_reg_methods_enabled which is renamed from
   acpi_gbl_reg_methods_executed.
2. If _REG(CONNECT) has never been evalauted for the region object,
   _REG(DISCONNECT) evaluations are blocked. This is achieved by a new
   region object flag: AOPOBJ_REG_CONNECTED.
Note that, after applying this patch, we can ensure _REG(DISCONNECT) is
always paired to _REG(CONNECT). Lv Zheng

Link: https://github.com/acpica/acpica/commit/31178590
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    2 +-
 drivers/acpi/acpica/acobject.h |    7 ++++---
 drivers/acpi/acpica/evregion.c |   25 ++++++++++++++++++++++---
 drivers/acpi/acpica/evxfregn.c |   33 ---------------------------------
 drivers/acpi/acpica/excreate.c |    3 ++-
 drivers/acpi/acpica/utinit.c   |    1 -
 drivers/acpi/acpica/utxfinit.c |    1 +
 7 files changed, 30 insertions(+), 42 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index ef0abf4..73462ca 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -165,7 +165,7 @@ ACPI_GLOBAL(u8, acpi_gbl_next_owner_id_offset);
 
 /* Initialization sequencing */
 
-ACPI_GLOBAL(u8, acpi_gbl_reg_methods_executed);
+ACPI_INIT_GLOBAL(u8, acpi_gbl_reg_methods_enabled, FALSE);
 
 /* Misc */
 
diff --git a/drivers/acpi/acpica/acobject.h b/drivers/acpi/acpica/acobject.h
index 0bd02c4..2b154cf 100644
--- a/drivers/acpi/acpica/acobject.h
+++ b/drivers/acpi/acpica/acobject.h
@@ -93,9 +93,10 @@
 #define AOPOBJ_AML_CONSTANT         0x01	/* Integer is an AML constant */
 #define AOPOBJ_STATIC_POINTER       0x02	/* Data is part of an ACPI table, don't delete */
 #define AOPOBJ_DATA_VALID           0x04	/* Object is initialized and data is valid */
-#define AOPOBJ_OBJECT_INITIALIZED   0x08	/* Region is initialized, _REG was run */
-#define AOPOBJ_SETUP_COMPLETE       0x10	/* Region setup is complete */
-#define AOPOBJ_INVALID              0x20	/* Host OS won't allow a Region address */
+#define AOPOBJ_OBJECT_INITIALIZED   0x08	/* Region is initialized */
+#define AOPOBJ_REG_CONNECTED        0x10	/* _REG was run */
+#define AOPOBJ_SETUP_COMPLETE       0x20	/* Region setup is complete */
+#define AOPOBJ_INVALID              0x40	/* Host OS won't allow a Region address */
 
 /******************************************************************************
  *
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 432b810..cf6e878 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -104,8 +104,6 @@ acpi_status acpi_ev_initialize_op_regions(void)
 		}
 	}
 
-	acpi_gbl_reg_methods_executed = TRUE;
-
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
 }
@@ -601,7 +599,18 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
 		return_ACPI_STATUS(AE_NOT_EXIST);
 	}
 
-	if (region_obj2->extra.method_REG == NULL) {
+	if (region_obj2->extra.method_REG == NULL ||
+	    region_obj->region.handler == NULL ||
+	    !acpi_gbl_reg_methods_enabled) {
+		return_ACPI_STATUS(AE_OK);
+	}
+
+	/* _REG(DISCONNECT) should be paired with _REG(CONNECT) */
+
+	if ((function == ACPI_REG_CONNECT &&
+	     region_obj->common.flags & AOPOBJ_REG_CONNECTED) ||
+	    (function == ACPI_REG_DISCONNECT &&
+	     !(region_obj->common.flags & AOPOBJ_REG_CONNECTED))) {
 		return_ACPI_STATUS(AE_OK);
 	}
 
@@ -650,6 +659,16 @@ acpi_ev_execute_reg_method(union acpi_operand_object *region_obj, u32 function)
 	status = acpi_ns_evaluate(info);
 	acpi_ut_remove_reference(args[1]);
 
+	if (ACPI_FAILURE(status)) {
+		goto cleanup2;
+	}
+
+	if (function == ACPI_REG_CONNECT) {
+		region_obj->common.flags |= AOPOBJ_REG_CONNECTED;
+	} else {
+		region_obj->common.flags &= ~AOPOBJ_REG_CONNECTED;
+	}
+
 cleanup2:
 	acpi_ut_remove_reference(args[0]);
 
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index 3c90508..29f9f39 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -112,39 +112,6 @@ acpi_install_address_space_handler(acpi_handle device,
 		goto unlock_and_exit;
 	}
 
-	/*
-	 * For the default space_IDs, (the IDs for which there are default region handlers
-	 * installed) Only execute the _REG methods if the global initialization _REG
-	 * methods have already been run (via acpi_initialize_objects). In other words,
-	 * we will defer the execution of the _REG methods for these space_IDs until
-	 * execution of acpi_initialize_objects. This is done because we need the handlers
-	 * for the default spaces (mem/io/pci/table) to be installed before we can run
-	 * any control methods (or _REG methods). There is known BIOS code that depends
-	 * on this.
-	 *
-	 * For all other space_IDs, we can safely execute the _REG methods immediately.
-	 * This means that for IDs like embedded_controller, this function should be called
-	 * only after acpi_enable_subsystem has been called.
-	 */
-	switch (space_id) {
-	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
-	case ACPI_ADR_SPACE_SYSTEM_IO:
-	case ACPI_ADR_SPACE_PCI_CONFIG:
-	case ACPI_ADR_SPACE_DATA_TABLE:
-
-		if (!acpi_gbl_reg_methods_executed) {
-
-			/* We will defer execution of the _REG methods for this space */
-
-			goto unlock_and_exit;
-		}
-		break;
-
-	default:
-
-		break;
-	}
-
 	/* Run all _REG methods for this address space */
 
 	status = acpi_ev_execute_reg_methods(node, space_id);
diff --git a/drivers/acpi/acpica/excreate.c b/drivers/acpi/acpica/excreate.c
index 6a1396e..46be5a2 100644
--- a/drivers/acpi/acpica/excreate.c
+++ b/drivers/acpi/acpica/excreate.c
@@ -345,7 +345,8 @@ acpi_ex_create_region(u8 * aml_start,
 	obj_desc->region.node = node;
 	obj_desc->region.handler = NULL;
 	obj_desc->common.flags &=
-	    ~(AOPOBJ_SETUP_COMPLETE | AOPOBJ_OBJECT_INITIALIZED);
+	    ~(AOPOBJ_SETUP_COMPLETE | AOPOBJ_REG_CONNECTED |
+	      AOPOBJ_OBJECT_INITIALIZED);
 
 	/* Install the new region object in the parent Node */
 
diff --git a/drivers/acpi/acpica/utinit.c b/drivers/acpi/acpica/utinit.c
index ccd0745..fd82a12 100644
--- a/drivers/acpi/acpica/utinit.c
+++ b/drivers/acpi/acpica/utinit.c
@@ -206,7 +206,6 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_next_owner_id_offset = 0;
 	acpi_gbl_debugger_configuration = DEBUGGER_THREADING;
 	acpi_gbl_osi_mutex = NULL;
-	acpi_gbl_reg_methods_executed = FALSE;
 	acpi_gbl_max_loop_iterations = 0xFFFF;
 
 	/* Hardware oriented */
diff --git a/drivers/acpi/acpica/utxfinit.c b/drivers/acpi/acpica/utxfinit.c
index 7d8eb60..1c7ed49 100644
--- a/drivers/acpi/acpica/utxfinit.c
+++ b/drivers/acpi/acpica/utxfinit.c
@@ -267,6 +267,7 @@ acpi_status __init acpi_initialize_objects(u32 flags)
 	 * initialized, even if they contain executable AML (see the call to
 	 * acpi_ns_initialize_objects below).
 	 */
+	acpi_gbl_reg_methods_enabled = TRUE;
 	if (!(flags & ACPI_NO_ADDRESS_SPACE_INIT)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_EXEC,
 				  "[Init] Executing _REG OpRegion methods\n"));
-- 
1.7.10
