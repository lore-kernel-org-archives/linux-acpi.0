From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH] ACPI: ibm-acpi: make ibm-acpi bay support optional
Date: Wed, 21 Feb 2007 14:04:07 -0200
Message-ID: <20070221160407.GA20282@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:34670 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161323AbXBUQEV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Feb 2007 11:04:21 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, lenb@kernel.org, ibm-acpi-devel@lists.sourceforge.net

Make ibm-acpi bay support optional at kernel compile time.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---

This is very useful for people trying out the new ACPI generic bay driver.
It does NOT conflict with ACPI_BAY on purpose.  That is for later, when we
are sure ACPI_BAY will be able to handle, e.g., battery module insert and
removal, which it doesn't currently.

Len, you can pull this from:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
branch for-upstream/acpi-test

Please merge for acpi-test.  This one is safe to make it to mainline at any
time you want, unlike the previous version that had to be reverted.  It
should go in together with, or before ACPI_BAY gets merged, though.

 drivers/acpi/Kconfig    |   11 +++++++++++
 drivers/acpi/ibm_acpi.c |   12 ++++++++++++
 2 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f4f000a..4ab9fa1 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -225,6 +225,17 @@ config ACPI_IBM_DOCK
 
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
index c6144ca..ba48743 100644
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
@@ -1040,6 +1042,7 @@ static int light_write(char *buf)
 	return 0;
 }
 
+#if defined(CONFIG_ACPI_IBM_DOCK) || defined(CONFIG_ACPI_IBM_BAY)
 static int _sta(acpi_handle handle)
 {
 	int status;
@@ -1049,6 +1052,7 @@ static int _sta(acpi_handle handle)
 
 	return status;
 }
+#endif
 
 #ifdef CONFIG_ACPI_IBM_DOCK
 #define dock_docked() (_sta(dock_handle) & 1)
@@ -1115,6 +1119,7 @@ static void dock_notify(struct ibm_struct *ibm, u32 event)
 }
 #endif
 
+#ifdef CONFIG_ACPI_IBM_BAY
 static int bay_status_supported;
 static int bay_status2_supported;
 static int bay_eject_supported;
@@ -1190,6 +1195,7 @@ static void bay_notify(struct ibm_struct *ibm, u32 event)
 {
 	acpi_bus_generate_event(ibm->device, event, 0);
 }
+#endif /* CONFIG_ACPI_IBM_BAY */
 
 static int cmos_read(char *p)
 {
@@ -2349,6 +2355,7 @@ static struct ibm_struct ibms[] = {
 	 .type = ACPI_SYSTEM_NOTIFY,
 	 },
 #endif
+#ifdef CONFIG_ACPI_IBM_BAY
 	{
 	 .name = "bay",
 	 .init = bay_init,
@@ -2358,6 +2365,7 @@ static struct ibm_struct ibms[] = {
 	 .handle = &bay_handle,
 	 .type = ACPI_SYSTEM_NOTIFY,
 	 },
+#endif /* CONFIG_ACPI_IBM_BAY */
 	{
 	 .name = "cmos",
 	 .read = cmos_read,
@@ -2643,7 +2651,9 @@ IBM_PARAM(light);
 #ifdef CONFIG_ACPI_IBM_DOCK
 IBM_PARAM(dock);
 #endif
+#ifdef CONFIG_ACPI_IBM_BAY
 IBM_PARAM(bay);
+#endif /* CONFIG_ACPI_IBM_BAY */
 IBM_PARAM(cmos);
 IBM_PARAM(led);
 IBM_PARAM(beep);
@@ -2726,12 +2736,14 @@ static int __init acpi_ibm_init(void)
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

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
