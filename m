From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 2/2] ACPI: ibm-acpi: make ibm-acpi bay support optional
Date: Thu, 22 Feb 2007 21:11:17 -0200
Message-ID: <1172185877980-git-send-email-hmh@hmh.eng.br>
References: 20070222205520.GA11505@khazad-dum.debian.net <11721858774109-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:56388 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752041AbXBVXLg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Feb 2007 18:11:36 -0500
In-Reply-To: <11721858774109-git-send-email-hmh@hmh.eng.br>
In-Reply-To: <20070222205520.GA11505@khazad-dum.debian.net>
References: <20070222205520.GA11505@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Make ibm-acpi bay support optional at kernel compile time.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/acpi/Kconfig    |   11 +++++++++++
 drivers/acpi/ibm_acpi.c |   12 ++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index e942ffe..ee3dcd1 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -242,6 +242,17 @@ config ACPI_IBM_DOCK
 
 	  If you are not sure, say N here.
 
+config ACPI_IBM_BAY
+	bool "Legacy Removable Bay Support"
+	depends on ACPI_IBM
+	default y
+	---help---
+	  Allows the ibm_acpi driver to handle removable bays.  It will allow
+	  disabling the device in the bay, and also generate notifications when
+	  the bay lever is ejected or inserted.
+
+	  If you are not sure, say Y here.
+
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
 	depends on X86
diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 7c1b418..e7309a6 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -157,6 +157,7 @@ IBM_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
 	   "\\_SB.PCI.ISA.SLCE",	/* 570 */
     );				/* A21e,G4x,R30,R31,R32,R40,R40e,R50e */
 #endif
+#ifdef CONFIG_ACPI_IBM_BAY
 IBM_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
 	   "\\_SB.PCI0.IDE0.IDES.IDSM",	/* 600e/x, 770e, 770x */
 	   "\\_SB.PCI0.SATA.SCND.MSTR",	/* T60, X60, Z60 */ 
@@ -174,6 +175,7 @@ IBM_HANDLE(bay2, root, "\\_SB.PCI0.IDE0.PRIM.SLAV",	/* A3x, R32 */
 IBM_HANDLE(bay2_ej, bay2, "_EJ3",	/* 600e/x, 770e, A3x */
 	   "_EJ0",		/* 770x */
     );				/* all others */
+#endif /* CONFIG_ACPI_IBM_BAY */
 
 /* don't list other alternatives as we install a notify handler on the 570 */
 IBM_HANDLE(pci, root, "\\_SB.PCI");	/* 570 */
@@ -1044,6 +1046,7 @@ static int light_write(char *buf)
 	return 0;
 }
 
+#if defined(CONFIG_ACPI_IBM_DOCK) || defined(CONFIG_ACPI_IBM_BAY)
 static int _sta(acpi_handle handle)
 {
 	int status;
@@ -1053,6 +1056,7 @@ static int _sta(acpi_handle handle)
 
 	return status;
 }
+#endif
 
 #ifdef CONFIG_ACPI_IBM_DOCK
 #define dock_docked() (_sta(dock_handle) & 1)
@@ -1119,6 +1123,7 @@ static void dock_notify(struct ibm_struct *ibm, u32 event)
 }
 #endif
 
+#ifdef CONFIG_ACPI_IBM_BAY
 static int bay_status_supported;
 static int bay_status2_supported;
 static int bay_eject_supported;
@@ -1194,6 +1199,7 @@ static void bay_notify(struct ibm_struct *ibm, u32 event)
 {
 	acpi_bus_generate_event(ibm->device, event, 0);
 }
+#endif /* CONFIG_ACPI_IBM_BAY */
 
 static int cmos_read(char *p)
 {
@@ -2361,6 +2367,7 @@ static struct ibm_struct ibms[] = {
 	 .type = ACPI_SYSTEM_NOTIFY,
 	 },
 #endif
+#ifdef CONFIG_ACPI_IBM_BAY
 	{
 	 .name = "bay",
 	 .init = bay_init,
@@ -2370,6 +2377,7 @@ static struct ibm_struct ibms[] = {
 	 .handle = &bay_handle,
 	 .type = ACPI_SYSTEM_NOTIFY,
 	 },
+#endif /* CONFIG_ACPI_IBM_BAY */
 	{
 	 .name = "cmos",
 	 .read = cmos_read,
@@ -2655,7 +2663,9 @@ IBM_PARAM(light);
 #ifdef CONFIG_ACPI_IBM_DOCK
 IBM_PARAM(dock);
 #endif
+#ifdef CONFIG_ACPI_IBM_BAY
 IBM_PARAM(bay);
+#endif /* CONFIG_ACPI_IBM_BAY */
 IBM_PARAM(cmos);
 IBM_PARAM(led);
 IBM_PARAM(beep);
@@ -2731,12 +2741,14 @@ static int __init acpi_ibm_init(void)
 	IBM_HANDLE_INIT(dock);
 #endif
 	IBM_HANDLE_INIT(pci);
+#ifdef CONFIG_ACPI_IBM_BAY
 	IBM_HANDLE_INIT(bay);
 	if (bay_handle)
 		IBM_HANDLE_INIT(bay_ej);
 	IBM_HANDLE_INIT(bay2);
 	if (bay2_handle)
 		IBM_HANDLE_INIT(bay2_ej);
+#endif /* CONFIG_ACPI_IBM_BAY */
 	IBM_HANDLE_INIT(beep);
 	IBM_HANDLE_INIT(ecrd);
 	IBM_HANDLE_INIT(ecwr);
-- 
1.4.4.4

