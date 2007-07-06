From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 16/16] ACPI: thinkpad-acpi: rename pci HID
	constant
Date: Thu,  5 Jul 2007 23:42:28 -0300
Message-ID: <1183689750540-git-send-email-hmh@hmh.eng.br>
References: <11836897482509-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11836897482509-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Rename an internal driver constant, on request by Len Brown.  Also,
document exactly what it is for.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |    7 +++++--
 drivers/misc/thinkpad_acpi.h |    1 -
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index c1e6a01..78e4110 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2026,7 +2026,10 @@ static struct tp_acpi_drv_struct ibm_dock_acpidriver[2] = {
 	 .type = ACPI_SYSTEM_NOTIFY,
 	},
 	{
-	 .hid = IBM_PCI_HID,
+	/* THIS ONE MUST NEVER BE USED FOR DRIVER AUTOLOADING.
+	 * We just use it to get notifications of dock hotplug
+	 * in very old thinkpads */
+	 .hid = PCI_ROOT_HID_STRING,
 	 .notify = dock_notify,
 	 .handle = &pci_handle,
 	 .type = ACPI_SYSTEM_NOTIFY,
@@ -2085,7 +2088,7 @@ static int __init dock_init2(struct ibm_init_struct *iibm)
 static void dock_notify(struct ibm_struct *ibm, u32 event)
 {
 	int docked = dock_docked();
-	int pci = ibm->acpi->hid && strstr(ibm->acpi->hid, IBM_PCI_HID);
+	int pci = ibm->acpi->hid && strstr(ibm->acpi->hid, PCI_ROOT_HID_STRING);
 
 	if (event == 1 && !pci)	/* 570 */
 		acpi_bus_generate_event(ibm->acpi->device, event, 1);	/* button */
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index c5c1316..fee0421 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -107,7 +107,6 @@ static const char *str_supported(int is_supported);
 
 /* ACPI HIDs */
 #define IBM_HKEY_HID    "IBM0068"
-#define IBM_PCI_HID     "PNP0A03"
 
 /* ACPI helpers */
 static int __must_check acpi_evalf(acpi_handle handle,
-- 
1.5.2.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
