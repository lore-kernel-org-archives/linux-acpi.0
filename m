From: "David E. Box" <david.e.box@linux.intel.com>
Subject: [PATCH] ACPI: Fix bug when acpi reset register is implemented in system memory
Date: Wed,  4 Jun 2014 08:55:59 -0700
Message-ID: <1401897359-28873-1-git-send-email-david.e.box@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: Randy Wright <rwright@hp.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: Randy Wright <rwright@hp.com>

Use acpi_os_map_generic_address to pre-map the reset register if it is memory
mapped, thereby preventing https://bugzilla.kernel.org/show_bug.cgi?id=77131

Signed-off-by: Randy Wright <rwright@hp.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/acpi/osl.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 6776c59..5325844 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1798,6 +1798,19 @@ acpi_status __init acpi_os_initialize(void)
 	acpi_os_map_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
 	acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe0_block);
 	acpi_os_map_generic_address(&acpi_gbl_FADT.xgpe1_block);
+	if (acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER) {
+		/*
+		 * Use acpi_os_map_generic_address to pre-map the reset
+		 * register if it's in system memory, thereby preventing
+		 * https://bugzilla.kernel.org/show_bug.cgi?id=77131
+		 */
+		int rv;
+		struct acpi_generic_address *reset_reg
+			= &acpi_gbl_FADT.reset_register;
+		rv = acpi_os_map_generic_address(reset_reg);
+		pr_info(PREFIX
+			"%s: map reset_reg status %d\n", __func__, rv);
+	}
 
 	return AE_OK;
 }
@@ -1826,6 +1839,8 @@ acpi_status acpi_os_terminate(void)
 	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xgpe0_block);
 	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1b_event_block);
 	acpi_os_unmap_generic_address(&acpi_gbl_FADT.xpm1a_event_block);
+	if (acpi_gbl_FADT.flags & ACPI_FADT_RESET_REGISTER)
+		acpi_os_unmap_generic_address(&acpi_gbl_FADT.reset_register);
 
 	destroy_workqueue(kacpid_wq);
 	destroy_workqueue(kacpi_notify_wq);
-- 
1.7.10.4
