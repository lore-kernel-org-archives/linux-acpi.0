From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH 5/6] ACPI: asus-acpi: use .notify method
	instead of installing	handler directly
Date: Thu, 30 Apr 2009 09:35:58 -0600
Message-ID: <20090430153558.12628.80916.stgit@bob.kio>
References: <20090430153419.12628.91088.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090430153419.12628.91088.stgit-tBlMHHroXgg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Karol Kozimor <sziwan-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexey Starikovskiy <alexey.y.starikovskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This patch adds a .notify() method.  The presence of .notify() causes
Linux/ACPI to manage event handlers and notify handlers on our behalf,
so we don't have to install and remove them ourselves.

This driver relies on seeing system notify events, not device-specific
ones (because it used ACPI_SYSTEM_NOTIFY).  We use the
ACPI_DRIVER_ALL_NOTIFY_EVENTS driver flag to request all events, then
just ignore any device events we get.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
CC: Corentin Chary <corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org>
CC: Karol Kozimor <sziwan-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
CC: acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
---
 drivers/platform/x86/asus_acpi.c |   30 +++++++++++++-----------------
 1 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/asus_acpi.c b/drivers/platform/x86/asus_acpi.c
index ba1f749..ddf5240 100644
--- a/drivers/platform/x86/asus_acpi.c
+++ b/drivers/platform/x86/asus_acpi.c
@@ -455,6 +455,8 @@ static struct asus_hotk *hotk;
  */
 static int asus_hotk_add(struct acpi_device *device);
 static int asus_hotk_remove(struct acpi_device *device, int type);
+static void asus_hotk_notify(struct acpi_device *device, u32 event);
+
 static const struct acpi_device_id asus_device_ids[] = {
 	{"ATK0100", 0},
 	{"", 0},
@@ -465,9 +467,11 @@ static struct acpi_driver asus_hotk_driver = {
 	.name = "asus_acpi",
 	.class = ACPI_HOTK_CLASS,
 	.ids = asus_device_ids,
+	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = asus_hotk_add,
 		.remove = asus_hotk_remove,
+		.notify = asus_hotk_notify,
 		},
 };
 
@@ -1101,12 +1105,20 @@ static int asus_hotk_remove_fs(struct acpi_device *device)
 	return 0;
 }
 
-static void asus_hotk_notify(acpi_handle handle, u32 event, void *data)
+static void asus_hotk_notify(struct acpi_device *device, u32 event)
 {
 	/* TODO Find a better way to handle events count. */
 	if (!hotk)
 		return;
 
+	/*
+	 * The BIOS *should* be sending us device events, but apparently
+	 * Asus uses system events instead, so just ignore any device
+	 * events we get.
+	 */
+	if (event > ACPI_MAX_SYS_NOTIFY)
+		return;
+
 	if ((event & ~((u32) BR_UP)) < 16)
 		hotk->brightness = (event & ~((u32) BR_UP));
 	else if ((event & ~((u32) BR_DOWN)) < 16)
@@ -1346,15 +1358,6 @@ static int asus_hotk_add(struct acpi_device *device)
 	if (result)
 		goto end;
 
-	/*
-	 * We install the handler, it will receive the hotk in parameter, so, we
-	 * could add other data to the hotk struct
-	 */
-	status = acpi_install_notify_handler(hotk->handle, ACPI_SYSTEM_NOTIFY,
-					     asus_hotk_notify, hotk);
-	if (ACPI_FAILURE(status))
-		printk(KERN_ERR "  Error installing notify handler\n");
-
 	/* For laptops without GPLV: init the hotk->brightness value */
 	if ((!hotk->methods->brightness_get)
 	    && (!hotk->methods->brightness_status)
@@ -1389,16 +1392,9 @@ end:
 
 static int asus_hotk_remove(struct acpi_device *device, int type)
 {
-	acpi_status status = 0;
-
 	if (!device || !acpi_driver_data(device))
 		return -EINVAL;
 
-	status = acpi_remove_notify_handler(hotk->handle, ACPI_SYSTEM_NOTIFY,
-					    asus_hotk_notify);
-	if (ACPI_FAILURE(status))
-		printk(KERN_ERR "Asus ACPI: Error removing notify handler\n");
-
 	asus_hotk_remove_fs(device);
 
 	kfree(hotk);


------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
