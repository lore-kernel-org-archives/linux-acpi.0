From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 6/9] ACPI: thinkpad-acpi: improve debugging
	for acpi helpers
Date: Fri, 27 Apr 2007 22:00:14 -0300
Message-ID: <11777220183170-git-send-email-hmh@hmh.eng.br>
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

Some issues with the dock subdriver proved that a slightly improved
debugging setup for ACPI notifiers and handler helpers would be useful.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 7aed118..68f1cc0 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -296,14 +296,22 @@ static void drv_acpi_handle_init(char *name,
 	int i;
 	acpi_status status;
 
+	vdbg_printk(TPACPI_DBG_INIT, "trying to locate ACPI handle for %s\n",
+		name);
+
 	for (i = 0; i < num_paths; i++) {
 		status = acpi_get_handle(parent, paths[i], handle);
 		if (ACPI_SUCCESS(status)) {
 			*path = paths[i];
+			dbg_printk(TPACPI_DBG_INIT,
+				   "Found ACPI handle %s for %s\n",
+				   *path, name);
 			return;
 		}
 	}
 
+	vdbg_printk(TPACPI_DBG_INIT, "ACPI handle for %s not found\n",
+		    name);
 	*handle = NULL;
 }
 
@@ -320,19 +328,20 @@ static void dispatch_acpi_notify(acpi_handle handle, u32 event, void *data)
 static int __init setup_acpi_notify(struct ibm_struct *ibm)
 {
 	acpi_status status;
-	int ret;
+	int rc;
 
 	BUG_ON(!ibm->acpi);
 
 	if (!*ibm->acpi->handle)
 		return 0;
 
-	dbg_printk(TPACPI_DBG_INIT,
+	vdbg_printk(TPACPI_DBG_INIT,
 		"setting up ACPI notify for %s\n", ibm->name);
 
-	ret = acpi_bus_get_device(*ibm->acpi->handle, &ibm->acpi->device);
-	if (ret < 0) {
-		printk(IBM_ERR "%s device not present\n", ibm->name);
+	rc = acpi_bus_get_device(*ibm->acpi->handle, &ibm->acpi->device);
+	if (rc < 0) {
+		printk(IBM_ERR "acpi_bus_get_device(%s) failed: %d\n",
+			ibm->name, rc);
 		return -ENODEV;
 	}
 
@@ -364,7 +373,7 @@ static int __init tpacpi_device_add(struct acpi_device *device)
 
 static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
 {
-	int ret;
+	int rc;
 
 	dbg_printk(TPACPI_DBG_INIT,
 		"registering %s as an ACPI driver\n", ibm->name);
@@ -381,16 +390,16 @@ static int __init register_tpacpi_subdriver(struct ibm_struct *ibm)
 	ibm->acpi->driver->ids = ibm->acpi->hid;
 	ibm->acpi->driver->ops.add = &tpacpi_device_add;
 
-	ret = acpi_bus_register_driver(ibm->acpi->driver);
-	if (ret < 0) {
+	rc = acpi_bus_register_driver(ibm->acpi->driver);
+	if (rc < 0) {
 		printk(IBM_ERR "acpi_bus_register_driver(%s) failed: %d\n",
-		       ibm->acpi->hid, ret);
+		       ibm->acpi->hid, rc);
 		kfree(ibm->acpi->driver);
 		ibm->acpi->driver = NULL;
-	} else if (!ret)
+	} else if (!rc)
 		ibm->flags.acpi_driver_registered = 1;
 
-	return ret;
+	return rc;
 }
 
 
-- 
1.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
