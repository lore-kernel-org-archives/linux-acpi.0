From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 7/9] ACPI: thinkpad-acpi: improve dock
	subdriver initialization
Date: Fri, 27 Apr 2007 22:00:15 -0300
Message-ID: <1177722018391-git-send-email-hmh@hmh.eng.br>
References: <11777220172751-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11777220172751-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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

The dock sub-driver has split-personality (two subdrivers), and it was
doing some unoptimal things on init because of that.  Fix it so that the
second half of it will only init when necessary, and only if the first half
initialized sucessfully in the first place.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   78 +++++++++++++++++++++++++++---------------
 1 files changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 68f1cc0..a565265 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1519,6 +1519,33 @@ IBM_HANDLE(dock, root, "\\_SB.GDCK",	/* X30, X31, X40 */
 /* don't list other alternatives as we install a notify handler on the 570 */
 IBM_HANDLE(pci, root, "\\_SB.PCI");	/* 570 */
 
+static struct tp_acpi_drv_struct ibm_dock_acpidriver[2] = {
+	{
+	 .notify = dock_notify,
+	 .handle = &dock_handle,
+	 .type = ACPI_SYSTEM_NOTIFY,
+	},
+	{
+	 .hid = IBM_PCI_HID,
+	 .notify = dock_notify,
+	 .handle = &pci_handle,
+	 .type = ACPI_SYSTEM_NOTIFY,
+	},
+};
+
+static struct ibm_struct dock_driver_data[2] = {
+	{
+	 .name = "dock",
+	 .read = dock_read,
+	 .write = dock_write,
+	 .acpi = &ibm_dock_acpidriver[0],
+	},
+	{
+	 .name = "dock",
+	 .acpi = &ibm_dock_acpidriver[1],
+	},
+};
+
 #define dock_docked() (_sta(dock_handle) & 1)
 
 static int __init dock_init(struct ibm_init_struct *iibm)
@@ -1526,7 +1553,6 @@ static int __init dock_init(struct ibm_init_struct *iibm)
 	vdbg_printk(TPACPI_DBG_INIT, "initializing dock subdriver\n");
 
 	IBM_ACPIHANDLE_INIT(dock);
-	IBM_ACPIHANDLE_INIT(pci);
 
 	vdbg_printk(TPACPI_DBG_INIT, "dock is %s\n",
 		str_supported(dock_handle != NULL));
@@ -1534,6 +1560,28 @@ static int __init dock_init(struct ibm_init_struct *iibm)
 	return (dock_handle)? 0 : 1;
 }
 
+static int __init dock_init2(struct ibm_init_struct *iibm)
+{
+	int dock2_needed;
+
+	vdbg_printk(TPACPI_DBG_INIT, "initializing dock subdriver part 2\n");
+
+	if (dock_driver_data[0].flags.acpi_driver_registered &&
+	    dock_driver_data[0].flags.acpi_notify_installed) {
+		IBM_ACPIHANDLE_INIT(pci);
+		dock2_needed = (pci_handle != NULL);
+		vdbg_printk(TPACPI_DBG_INIT,
+			    "dock PCI handler for the TP 570 is %s\n",
+			    str_supported(dock2_needed));
+	} else {
+		vdbg_printk(TPACPI_DBG_INIT,
+		"dock subdriver part 2 not required\n");
+		dock2_needed = 0;
+	}
+
+	return (dock2_needed)? 0 : 1;
+}
+
 static void dock_notify(struct ibm_struct *ibm, u32 event)
 {
 	int docked = dock_docked();
@@ -1595,33 +1643,6 @@ static int dock_write(char *buf)
 	return 0;
 }
 
-static struct tp_acpi_drv_struct ibm_dock_acpidriver[2] = {
-	{
-	 .notify = dock_notify,
-	 .handle = &dock_handle,
-	 .type = ACPI_SYSTEM_NOTIFY,
-	},
-	{
-	 .hid = IBM_PCI_HID,
-	 .notify = dock_notify,
-	 .handle = &pci_handle,
-	 .type = ACPI_SYSTEM_NOTIFY,
-	},
-};
-
-static struct ibm_struct dock_driver_data[2] = {
-	{
-	 .name = "dock",
-	 .read = dock_read,
-	 .write = dock_write,
-	 .acpi = &ibm_dock_acpidriver[0],
-	},
-	{
-	 .name = "dock",
-	 .acpi = &ibm_dock_acpidriver[1],
-	},
-};
-
 #endif /* CONFIG_THINKPAD_ACPI_DOCK */
 
 /*************************************************************************
@@ -3850,6 +3871,7 @@ static struct ibm_init_struct ibms_init[] __initdata = {
 		.data = &dock_driver_data[0],
 	},
 	{
+		.init = dock_init2,
 		.data = &dock_driver_data[1],
 	},
 #endif
-- 
1.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
