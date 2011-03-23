From: Len Brown <lenb@kernel.org>
Subject: [PATCH 24/42] ACPICA: Add mechanism to defer _REG methods for some
 installed handlers
Date: Wed, 23 Mar 2011 02:42:37 -0400
Message-ID: <ef09c4f578147464524041cbe3205bb25f900598.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33781 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab1CWIHl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 04:07:41 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII00IQB3WFAQB4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 03:07:34 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

The memory/io/pci/dataTable regions must always be available. For
any user installed handlers for these spaces, defer execution
of _REG methods until acpi_enable_subsystem. This prevents any
chicken/egg problems and ensures that no methods are executed
until all of these regions are ready and available.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/acglobal.h |    4 ++++
 drivers/acpi/acpica/evregion.c |    2 ++
 drivers/acpi/acpica/evxfregn.c |   36 +++++++++++++++++++++++++++++++++---
 drivers/acpi/acpica/utglobal.c |    1 +
 4 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 82a1bd2..d69750b 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -273,6 +273,10 @@ ACPI_EXTERN u32 acpi_gbl_owner_id_mask[ACPI_NUM_OWNERID_MASKS];
 ACPI_EXTERN u8 acpi_gbl_last_owner_id_index;
 ACPI_EXTERN u8 acpi_gbl_next_owner_id_offset;
 
+/* Initialization sequencing */
+
+ACPI_EXTERN u8 acpi_gbl_reg_methods_executed;
+
 /* Misc */
 
 ACPI_EXTERN u32 acpi_gbl_original_mode;
diff --git a/drivers/acpi/acpica/evregion.c b/drivers/acpi/acpica/evregion.c
index 785a5ee..bea7223 100644
--- a/drivers/acpi/acpica/evregion.c
+++ b/drivers/acpi/acpica/evregion.c
@@ -231,6 +231,8 @@ acpi_status acpi_ev_initialize_op_regions(void)
 		}
 	}
 
+	acpi_gbl_reg_methods_executed = TRUE;
+
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
 	return_ACPI_STATUS(status);
 }
diff --git a/drivers/acpi/acpica/evxfregn.c b/drivers/acpi/acpica/evxfregn.c
index eb73867..c85c8c4 100644
--- a/drivers/acpi/acpica/evxfregn.c
+++ b/drivers/acpi/acpica/evxfregn.c
@@ -110,9 +110,39 @@ acpi_install_address_space_handler(acpi_handle device,
 		goto unlock_and_exit;
 	}
 
-	/* Run all _REG methods for this address space */
+	/*
+	 * For the default space_iDs, (the IDs for which there are default region handlers
+	 * installed) Only execute the _REG methods if the global initialization _REG
+	 * methods have already been run (via acpi_initialize_objects). In other words,
+	 * we will defer the execution of the _REG methods for these space_iDs until
+	 * execution of acpi_initialize_objects. This is done because we need the handlers
+	 * for the default spaces (mem/io/pci/table) to be installed before we can run
+	 * any control methods (or _REG methods). There is known BIOS code that depends
+	 * on this.
+	 *
+	 * For all other space_iDs, we can safely execute the _REG methods immediately.
+	 * This means that for IDs like embedded_controller, this function should be called
+	 * only after acpi_enable_subsystem has been called.
+	 */
+	switch (space_id) {
+	case ACPI_ADR_SPACE_SYSTEM_MEMORY:
+	case ACPI_ADR_SPACE_SYSTEM_IO:
+	case ACPI_ADR_SPACE_PCI_CONFIG:
+	case ACPI_ADR_SPACE_DATA_TABLE:
+
+		if (acpi_gbl_reg_methods_executed) {
+
+			/* Run all _REG methods for this address space */
+
+			status = acpi_ev_execute_reg_methods(node, space_id);
+		}
+		break;
+
+	default:
 
-	status = acpi_ev_execute_reg_methods(node, space_id);
+		status = acpi_ev_execute_reg_methods(node, space_id);
+		break;
+	}
 
       unlock_and_exit:
 	(void)acpi_ut_release_mutex(ACPI_MTX_NAMESPACE);
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index fc90978..833a38a 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -323,6 +323,7 @@ acpi_status acpi_ut_init_globals(void)
 	acpi_gbl_db_output_flags = ACPI_DB_CONSOLE_OUTPUT;
 	acpi_gbl_osi_data = 0;
 	acpi_gbl_osi_mutex = NULL;
+	acpi_gbl_reg_methods_executed = FALSE;
 
 	/* Hardware oriented */
 
-- 
1.7.4.1.343.ga91df

