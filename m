From: Len Brown <len.brown@intel.com>
Subject: [PATCH 7/7] Revert "ACPI: ibm-acpi: make non-generic bay support optional"
Date: Thu, 11 Jan 2007 04:11:48 -0500
Message-ID: <1168506716760-git-send-email-len.brown@intel.com>
References: <11685067081383-git-send-email-len.brown@intel.com> <11685067091916-git-send-email-len.brown@intel.com> <11685067101245-git-send-email-len.brown@intel.com> <11685067113037-git-send-email-len.brown@intel.com> <11685067121393-git-send-email-len.brown@intel.com> <11685067141577-git-send-email-len.brown@intel.com> <11685067152996-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:45388 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030252AbXAKJL5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Jan 2007 04:11:57 -0500
In-Reply-To: <11685067152996-git-send-email-len.brown@intel.com>
Message-Id: <d2fadbbbf0e42b842731da71864f222e7f119461.1168506584.git.len.brown@intel.com>
In-Reply-To: <3948ec9406f9a60a43d63f23f6f5284db6529b9c.1168506584.git.len.brown@intel.com>
References: <3948ec9406f9a60a43d63f23f6f5284db6529b9c.1168506584.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

This reverts commit 2df910b4c3edcce9a0c12394db6f5f4a6e69c712.

ACPI_BAY has not been merged into mainline yet, so the changes to ibm-acpi
related Kconfig entries that depend on ACPI_BAY were permanently disabling
ibm-acpi bay support.  This is a serious regression for ThinkPad users.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig    |   11 -----------
 drivers/acpi/ibm_acpi.c |   13 +------------
 2 files changed, 1 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1639998..f4f000a 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -225,17 +225,6 @@ config ACPI_IBM_DOCK
 
 	  If you are not sure, say N here.
 
-config ACPI_IBM_BAY
-	bool "Legacy Removable Bay Support"
-	depends on ACPI_IBM
-	depends on ACPI_BAY=n
-	default n
-	---help---
-	  Allows the ibm_acpi driver to handle removable bays.
-	  This support is obsoleted by CONFIG_ACPI_BAY.
-
-	  If you are not sure, say N here.
-
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
 	depends on X86
diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index b72d13d..c6144ca 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -157,7 +157,6 @@ IBM_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
 	   "\\_SB.PCI.ISA.SLCE",	/* 570 */
     );				/* A21e,G4x,R30,R31,R32,R40,R40e,R50e */
 #endif
-#ifdef CONFIG_ACPI_IBM_BAY
 IBM_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
 	   "\\_SB.PCI0.IDE0.IDES.IDSM",	/* 600e/x, 770e, 770x */
 	   "\\_SB.PCI0.SATA.SCND.MSTR",	/* T60, X60, Z60 */ 
@@ -175,7 +174,6 @@ IBM_HANDLE(bay2, root, "\\_SB.PCI0.IDE0.PRIM.SLAV",	/* A3x, R32 */
 IBM_HANDLE(bay2_ej, bay2, "_EJ3",	/* 600e/x, 770e, A3x */
 	   "_EJ0",		/* 770x */
     );				/* all others */
-#endif
 
 /* don't list other alternatives as we install a notify handler on the 570 */
 IBM_HANDLE(pci, root, "\\_SB.PCI");	/* 570 */
@@ -1042,7 +1040,6 @@ static int light_write(char *buf)
 	return 0;
 }
 
-#if defined(CONFIG_ACPI_IBM_DOCK) || defined(CONFIG_ACPI_IBM_BAY)
 static int _sta(acpi_handle handle)
 {
 	int status;
@@ -1052,7 +1049,7 @@ static int _sta(acpi_handle handle)
 
 	return status;
 }
-#endif
+
 #ifdef CONFIG_ACPI_IBM_DOCK
 #define dock_docked() (_sta(dock_handle) & 1)
 
@@ -1118,7 +1115,6 @@ static void dock_notify(struct ibm_struct *ibm, u32 event)
 }
 #endif
 
-#ifdef CONFIG_ACPI_IBM_BAY
 static int bay_status_supported;
 static int bay_status2_supported;
 static int bay_eject_supported;
@@ -1194,7 +1190,6 @@ static void bay_notify(struct ibm_struct *ibm, u32 event)
 {
 	acpi_bus_generate_event(ibm->device, event, 0);
 }
-#endif
 
 static int cmos_read(char *p)
 {
@@ -2354,7 +2349,6 @@ static struct ibm_struct ibms[] = {
 	 .type = ACPI_SYSTEM_NOTIFY,
 	 },
 #endif
-#ifdef CONFIG_ACPI_IBM_BAY
 	{
 	 .name = "bay",
 	 .init = bay_init,
@@ -2364,7 +2358,6 @@ static struct ibm_struct ibms[] = {
 	 .handle = &bay_handle,
 	 .type = ACPI_SYSTEM_NOTIFY,
 	 },
-#endif
 	{
 	 .name = "cmos",
 	 .read = cmos_read,
@@ -2650,9 +2643,7 @@ IBM_PARAM(light);
 #ifdef CONFIG_ACPI_IBM_DOCK
 IBM_PARAM(dock);
 #endif
-#ifdef CONFIG_ACPI_IBM_BAY
 IBM_PARAM(bay);
-#endif
 IBM_PARAM(cmos);
 IBM_PARAM(led);
 IBM_PARAM(beep);
@@ -2735,14 +2726,12 @@ static int __init acpi_ibm_init(void)
 	IBM_HANDLE_INIT(dock);
 #endif
 	IBM_HANDLE_INIT(pci);
-#ifdef CONFIG_ACPI_IBM_BAY
 	IBM_HANDLE_INIT(bay);
 	if (bay_handle)
 		IBM_HANDLE_INIT(bay_ej);
 	IBM_HANDLE_INIT(bay2);
 	if (bay2_handle)
 		IBM_HANDLE_INIT(bay2_ej);
-#endif
 	IBM_HANDLE_INIT(beep);
 	IBM_HANDLE_INIT(ecrd);
 	IBM_HANDLE_INIT(ecwr);
-- 
1.4.4.4.ge05d
