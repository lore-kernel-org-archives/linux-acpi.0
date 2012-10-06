From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/49] ACPICA: GPE Support: Update debug info for GPE tracing.
Date: Sat,  6 Oct 2012 16:09:27 -0400
Message-ID: <e1154ebd4d0215937528016c41e2f13d30a28082.1349554105.git.len.brown@intel.com>
References: <1349554210-29978-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1349554210-29978-1-git-send-email-lenb@kernel.org>
In-Reply-To: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
References: <a950c135e5b2be6ef7518d54d98a7901db1b377a.1349554105.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bob Moore <robert.moore@intel.com>, Feng Tang <feng.tang@intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

Add additional debug info to assist with GPE debugging.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/evgpe.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index afbd5cb..3db3c56 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -379,6 +379,18 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
 			 */
 			if (!(gpe_register_info->enable_for_run |
 			      gpe_register_info->enable_for_wake)) {
+				ACPI_DEBUG_PRINT((ACPI_DB_INTERRUPTS,
+						  "Ignore disabled registers for GPE%02X-GPE%02X: "
+						  "RunEnable=%02X, WakeEnable=%02X\n",
+						  gpe_register_info->
+						  base_gpe_number,
+						  gpe_register_info->
+						  base_gpe_number +
+						  (ACPI_GPE_REGISTER_WIDTH - 1),
+						  gpe_register_info->
+						  enable_for_run,
+						  gpe_register_info->
+						  enable_for_wake));
 				continue;
 			}
 
@@ -401,9 +413,14 @@ u32 acpi_ev_gpe_detect(struct acpi_gpe_xrupt_info * gpe_xrupt_list)
 			}
 
 			ACPI_DEBUG_PRINT((ACPI_DB_INTERRUPTS,
-					  "Read GPE Register at GPE%02X: Status=%02X, Enable=%02X\n",
+					  "Read registers for GPE%02X-GPE%02X: Status=%02X, Enable=%02X, "
+					  "RunEnable=%02X, WakeEnable=%02X\n",
 					  gpe_register_info->base_gpe_number,
-					  status_reg, enable_reg));
+					  gpe_register_info->base_gpe_number +
+					  (ACPI_GPE_REGISTER_WIDTH - 1),
+					  status_reg, enable_reg,
+					  gpe_register_info->enable_for_run,
+					  gpe_register_info->enable_for_wake));
 
 			/* Check if there is anything active at all in this register */
 
-- 
1.8.0.rc0.18.gf84667d
