From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 2/5] ACPI: thinkpad-acpi: cleanup Kconfig
	for thinkpad-acpi
Date: Thu, 29 Mar 2007 01:58:41 -0300
Message-ID: <1175144324171-git-send-email-hmh@hmh.eng.br>
References: <11751443243976-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11751443243976-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Since ibm-acpi was renamed to thinkpad-acpi, rename and update its Kconfig
entries and Kconfig-related symbols accordingly.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/Kconfig         |   37 ++++++++++++++++++++-----------------
 drivers/misc/Makefile        |    2 +-
 drivers/misc/thinkpad_acpi.c |   26 +++++++++++++-------------
 drivers/misc/thinkpad_acpi.h |    8 ++++----
 4 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 5d2bcbf..2cd96a3 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -122,40 +122,43 @@ config SONY_LAPTOP
 
 	  Read <file:Documentation/sony-laptop.txt> for more information.
 
-config ACPI_IBM
-	tristate "IBM ThinkPad Laptop Extras"
+config THINKPAD_ACPI
+	tristate "ThinkPad ACPI Laptop Extras"
 	depends on X86 && ACPI
 	select BACKLIGHT_CLASS_DEVICE
 	---help---
-	  This is a Linux ACPI driver for the IBM ThinkPad laptops. It adds
+	  This is a driver for the IBM and Lenovo ThinkPad laptops. It adds
 	  support for Fn-Fx key combinations, Bluetooth control, video
 	  output switching, ThinkLight control, UltraBay eject and more.
-	  For more information about this driver see <file:Documentation/ibm-acpi.txt>
-	  and <http://ibm-acpi.sf.net/> .
+	  For more information about this driver see 
+	  <file:Documentation/thinkpad-acpi.txt> and <http://ibm-acpi.sf.net/> .
 
-	  If you have an IBM ThinkPad laptop, say Y or M here.
+	  This driver was formely known as ibm-acpi.
 
-config ACPI_IBM_DOCK
+	  If you have an IBM or Lenovo ThinkPad laptop, say Y or M here.
+
+config THINKPAD_ACPI_DOCK
 	bool "Legacy Docking Station Support"
-	depends on ACPI_IBM
+	depends on THINKPAD_ACPI
 	depends on ACPI_DOCK=n
 	default n
 	---help---
-	  Allows the ibm_acpi driver to handle docking station events.
-	  This support is obsoleted by CONFIG_HOTPLUG_PCI_ACPI.  It will
-	  allow locking and removing the laptop from the docking station,
-	  but will not properly connect PCI devices.
+	  Allows the thinkpad_acpi driver to handle docking station events.
+	  This support was made obsolete by the generic ACPI docking station
+	  support (CONFIG_ACPI_DOCK).  It will allow locking and removing the
+	  laptop from the docking station, but will not properly connect PCI
+	  devices.
 
 	  If you are not sure, say N here.
 
-config ACPI_IBM_BAY
+config THINKPAD_ACPI_BAY
 	bool "Legacy Removable Bay Support"
-	depends on ACPI_IBM
+	depends on THINKPAD_ACPI
 	default y
 	---help---
-	  Allows the ibm_acpi driver to handle removable bays.  It will allow
-	  disabling the device in the bay, and also generate notifications when
-	  the bay lever is ejected or inserted.
+	  Allows the thinkpad_acpi driver to handle removable bays.  It will
+	  eletrically disable the device in the bay, and also generate
+	  notifications when the bay lever is ejected or inserted.
 
 	  If you are not sure, say Y here.
 
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index ebf4ff2..e325164 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -12,4 +12,4 @@ obj-$(CONFIG_TIFM_CORE)       	+= tifm_core.o
 obj-$(CONFIG_TIFM_7XX1)       	+= tifm_7xx1.o
 obj-$(CONFIG_SGI_IOC4)		+= ioc4.o
 obj-$(CONFIG_SONY_LAPTOP)	+= sony-laptop.o
-obj-$(CONFIG_ACPI_IBM)		+= thinkpad_acpi.o
+obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 2836516..bb789db 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1040,7 +1040,7 @@ static int light_write(char *buf)
 /* don't list other alternatives as we install a notify handler on the 570 */
 IBM_HANDLE(pci, root, "\\_SB.PCI");	/* 570 */
 
-#ifdef CONFIG_ACPI_IBM_DOCK
+#ifdef CONFIG_THINKPAD_ACPI_DOCK
 
 IBM_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
 	   "\\_SB.PCI0.DOCK",	/* 600e/x,770e,770x,A2xm/p,T20-22,X20-21 */
@@ -1111,13 +1111,13 @@ static int dock_write(char *buf)
 	return 0;
 }
 
-#endif /* CONFIG_ACPI_IBM_DOCK */
+#endif /* CONFIG_THINKPAD_ACPI_DOCK */
 
 /*************************************************************************
  * Bay subdriver
  */
 
-#ifdef CONFIG_ACPI_IBM_BAY
+#ifdef CONFIG_THINKPAD_ACPI_BAY
 static int bay_status_supported;
 static int bay_status2_supported;
 static int bay_eject_supported;
@@ -1208,7 +1208,7 @@ static int bay_write(char *buf)
 
 	return 0;
 }
-#endif /* CONFIG_ACPI_IBM_BAY */
+#endif /* CONFIG_THINKPAD_ACPI_BAY */
 
 /*************************************************************************
  * CMOS subdriver
@@ -2477,7 +2477,7 @@ static struct ibm_struct ibms[] = {
 	 .read = light_read,
 	 .write = light_write,
 	 },
-#ifdef CONFIG_ACPI_IBM_DOCK
+#ifdef CONFIG_THINKPAD_ACPI_DOCK
 	{
 	 .name = "dock",
 	 .read = dock_read,
@@ -2494,7 +2494,7 @@ static struct ibm_struct ibms[] = {
 	 .type = ACPI_SYSTEM_NOTIFY,
 	 },
 #endif
-#ifdef CONFIG_ACPI_IBM_BAY
+#ifdef CONFIG_THINKPAD_ACPI_BAY
 	{
 	 .name = "bay",
 	 .init = bay_init,
@@ -2504,7 +2504,7 @@ static struct ibm_struct ibms[] = {
 	 .handle = &bay_handle,
 	 .type = ACPI_SYSTEM_NOTIFY,
 	 },
-#endif /* CONFIG_ACPI_IBM_BAY */
+#endif /* CONFIG_THINKPAD_ACPI_BAY */
 	{
 	 .name = "cmos",
 	 .read = cmos_read,
@@ -2686,12 +2686,12 @@ IBM_PARAM(hotkey);
 IBM_PARAM(bluetooth);
 IBM_PARAM(video);
 IBM_PARAM(light);
-#ifdef CONFIG_ACPI_IBM_DOCK
+#ifdef CONFIG_THINKPAD_ACPI_DOCK
 IBM_PARAM(dock);
 #endif
-#ifdef CONFIG_ACPI_IBM_BAY
+#ifdef CONFIG_THINKPAD_ACPI_BAY
 IBM_PARAM(bay);
-#endif /* CONFIG_ACPI_IBM_BAY */
+#endif /* CONFIG_THINKPAD_ACPI_BAY */
 IBM_PARAM(cmos);
 IBM_PARAM(led);
 IBM_PARAM(beep);
@@ -2725,18 +2725,18 @@ static int __init acpi_ibm_init(void)
 	IBM_HANDLE_INIT(hkey);
 	IBM_HANDLE_INIT(lght);
 	IBM_HANDLE_INIT(cmos);
-#ifdef CONFIG_ACPI_IBM_DOCK
+#ifdef CONFIG_THINKPAD_ACPI_DOCK
 	IBM_HANDLE_INIT(dock);
 #endif
 	IBM_HANDLE_INIT(pci);
-#ifdef CONFIG_ACPI_IBM_BAY
+#ifdef CONFIG_THINKPAD_ACPI_BAY
 	IBM_HANDLE_INIT(bay);
 	if (bay_handle)
 		IBM_HANDLE_INIT(bay_ej);
 	IBM_HANDLE_INIT(bay2);
 	if (bay2_handle)
 		IBM_HANDLE_INIT(bay2_ej);
-#endif /* CONFIG_ACPI_IBM_BAY */
+#endif /* CONFIG_THINKPAD_ACPI_BAY */
 	IBM_HANDLE_INIT(beep);
 	IBM_HANDLE_INIT(ecrd);
 	IBM_HANDLE_INIT(ecwr);
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 7ebaaa4..ee1b93a 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -163,7 +163,7 @@ static int register_ibmacpi_subdriver(struct ibm_struct *ibm);
  * Bay subdriver
  */
 
-#ifdef CONFIG_ACPI_IBM_BAY
+#ifdef CONFIG_THINKPAD_ACPI_BAY
 static int bay_status_supported, bay_eject_supported;
 static int bay_status2_supported, bay_eject2_supported;
 
@@ -174,7 +174,7 @@ static int bay_init(void);
 static void bay_notify(struct ibm_struct *ibm, u32 event);
 static int bay_read(char *p);
 static int bay_write(char *buf);
-#endif /* CONFIG_ACPI_IBM_BAY */
+#endif /* CONFIG_THINKPAD_ACPI_BAY */
 
 
 /*
@@ -229,13 +229,13 @@ static int cmos_write(char *buf);
  */
 
 static acpi_handle pci_handle;
-#ifdef CONFIG_ACPI_IBM_DOCK
+#ifdef CONFIG_THINKPAD_ACPI_DOCK
 static acpi_handle dock_handle;
 
 static void dock_notify(struct ibm_struct *ibm, u32 event);
 static int dock_read(char *p);
 static int dock_write(char *buf);
-#endif /* CONFIG_ACPI_IBM_DOCK */
+#endif /* CONFIG_THINKPAD_ACPI_DOCK */
 
 
 /*
-- 
1.5.0.3


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
