From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 18/21] ACPI: ibm-acpi: make non-generic bay
	support optional
Date: Sat, 25 Nov 2006 18:47:57 -0200
Message-ID: <20061125204757.6604.69140.stgit@thorin.khazad-dum.debian.net>
References: <20061125204155.6604.35338.stgit@thorin.khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20061125204155.6604.35338.stgit-H32KNTuDSMjdPi8JTuvWk31TOOPCyuNQ5NbjCUgZEJk@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>

This patch makes it possible to disable ibm-acpi non-generic bay support,
as generic bay support already works well for a number of ThinkPads.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---

 drivers/acpi/Kconfig    |   11 +++++++++++
 drivers/acpi/ibm_acpi.c |   13 ++++++++++++-
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 51745de..440ce9b 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -232,6 +232,17 @@ config ACPI_IBM_DOCK
 
 	  If you are not sure, say N here.
 
+config ACPI_IBM_BAY
+	bool "Legacy Removable Bay Support"
+	depends on ACPI_IBM
+	depends on ACPI_BAY=n
+	default n
+	---help---
+	  Allows the ibm_acpi driver to handle removable bays.
+	  This support is obsoleted by CONFIG_ACPI_BAY.
+
+	  If you are not sure, say N here.
+
 config ACPI_TOSHIBA
 	tristate "Toshiba Laptop Extras"
 	depends on X86
diff --git a/drivers/acpi/ibm_acpi.c b/drivers/acpi/ibm_acpi.c
index 0151263..3a4dce1 100644
--- a/drivers/acpi/ibm_acpi.c
+++ b/drivers/acpi/ibm_acpi.c
@@ -172,6 +172,7 @@ IBM_HANDLE(dock, root, "\\_SB.GDCK",	/*
 	   "\\_SB.PCI.ISA.SLCE",	/* 570 */
     );				/* A21e,G4x,R30,R31,R32,R40,R40e,R50e */
 #endif
+#ifdef CONFIG_ACPI_IBM_BAY
 IBM_HANDLE(bay, root, "\\_SB.PCI.IDE.SECN.MAST",	/* 570 */
 	   "\\_SB.PCI0.IDE0.IDES.IDSM",	/* 600e/x, 770e, 770x */
 	   "\\_SB.PCI0.SATA.SCND.MSTR",	/* T60, X60, Z60 */ 
@@ -189,6 +190,7 @@ IBM_HANDLE(bay2, root, "\\_SB.PCI0.IDE0.
 IBM_HANDLE(bay2_ej, bay2, "_EJ3",	/* 600e/x, 770e, A3x */
 	   "_EJ0",		/* 770x */
     );				/* all others */
+#endif
 
 /* don't list other alternatives as we install a notify handler on the 570 */
 IBM_HANDLE(pci, root, "\\_SB.PCI");	/* 570 */
@@ -1051,6 +1053,7 @@ static int light_write(char *buf)
 	return 0;
 }
 
+#if defined(CONFIG_ACPI_IBM_DOCK) || defined(CONFIG_ACPI_IBM_BAY)
 static int _sta(acpi_handle handle)
 {
 	int status;
@@ -1060,7 +1063,7 @@ static int _sta(acpi_handle handle)
 
 	return status;
 }
-
+#endif
 #ifdef CONFIG_ACPI_IBM_DOCK
 #define dock_docked() (_sta(dock_handle) & 1)
 
@@ -1126,6 +1129,7 @@ static void dock_notify(struct ibm_struc
 }
 #endif
 
+#ifdef CONFIG_ACPI_IBM_BAY
 static int bay_status_supported;
 static int bay_status2_supported;
 static int bay_eject_supported;
@@ -1201,6 +1205,7 @@ static void bay_notify(struct ibm_struct
 {
 	acpi_bus_generate_event(ibm->device, event, 0);
 }
+#endif
 
 static int cmos_read(char *p)
 {
@@ -2330,6 +2335,7 @@ static struct ibm_struct ibms[] = {
 	 .type = ACPI_SYSTEM_NOTIFY,
 	 },
 #endif
+#ifdef CONFIG_ACPI_IBM_BAY
 	{
 	 .name = "bay",
 	 .init = bay_init,
@@ -2339,6 +2345,7 @@ static struct ibm_struct ibms[] = {
 	 .handle = &bay_handle,
 	 .type = ACPI_SYSTEM_NOTIFY,
 	 },
+#endif
 	{
 	 .name = "cmos",
 	 .read = cmos_read,
@@ -2623,7 +2630,9 @@ IBM_PARAM(light);
 #ifdef CONFIG_ACPI_IBM_DOCK
 IBM_PARAM(dock);
 #endif
+#ifdef CONFIG_ACPI_IBM_BAY
 IBM_PARAM(bay);
+#endif
 IBM_PARAM(cmos);
 IBM_PARAM(led);
 IBM_PARAM(beep);
@@ -2716,12 +2725,14 @@ static int __init acpi_ibm_init(void)
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
+#endif
 	IBM_HANDLE_INIT(beep);
 	IBM_HANDLE_INIT(ecrd);
 	IBM_HANDLE_INIT(ecwr);

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
