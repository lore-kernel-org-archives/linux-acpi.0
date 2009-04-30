From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH 6/6] ACPI: eeepc-laptop: use .notify method
	instead of	installing handler directly
Date: Thu, 30 Apr 2009 09:36:03 -0600
Message-ID: <20090430153603.12628.46200.stgit@bob.kio>
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
CC: acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
CC: Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/platform/x86/eeepc-laptop.c |   19 ++++++-------------
 1 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 6f54fd1..d9424fd 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -177,6 +177,7 @@ static struct key_entry eeepc_keymap[] = {
  */
 static int eeepc_hotk_add(struct acpi_device *device);
 static int eeepc_hotk_remove(struct acpi_device *device, int type);
+static void eeepc_hotk_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id eeepc_device_ids[] = {
 	{EEEPC_HOTK_HID, 0},
@@ -188,9 +189,11 @@ static struct acpi_driver eeepc_hotk_driver = {
 	.name = EEEPC_HOTK_NAME,
 	.class = EEEPC_HOTK_CLASS,
 	.ids = eeepc_device_ids,
+	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = eeepc_hotk_add,
 		.remove = eeepc_hotk_remove,
+		.notify = eeepc_hotk_notify,
 	},
 };
 
@@ -554,13 +557,15 @@ static void eeepc_rfkill_notify(acpi_handle handle, u32 event, void *data)
 	}
 }
 
-static void eeepc_hotk_notify(acpi_handle handle, u32 event, void *data)
+static void eeepc_hotk_notify(struct acpi_device *device, u32 event)
 {
 	static struct key_entry *key;
 	u16 count;
 
 	if (!ehotk)
 		return;
+	if (event > ACPI_MAX_SYS_NOTIFY)
+		return;
 	if (event >= NOTIFY_BRN_MIN && event <= NOTIFY_BRN_MAX)
 		notify_brn();
 	count = ehotk->event_count[event % 128]++;
@@ -626,7 +631,6 @@ static void eeepc_unregister_rfkill_notifier(char *node)
 
 static int eeepc_hotk_add(struct acpi_device *device)
 {
-	acpi_status status = AE_OK;
 	int result;
 
 	if (!device)
@@ -644,11 +648,6 @@ static int eeepc_hotk_add(struct acpi_device *device)
 	result = eeepc_hotk_check();
 	if (result)
 		goto ehotk_fail;
-	status = acpi_install_notify_handler(ehotk->handle, ACPI_SYSTEM_NOTIFY,
-					     eeepc_hotk_notify, ehotk);
-	if (ACPI_FAILURE(status))
-		printk(EEEPC_ERR "Error installing notify handler\n");
-
 	if (get_acpi(CM_ASL_WLAN) != -1) {
 		ehotk->eeepc_wlan_rfkill = rfkill_allocate(&device->dev,
 							   RFKILL_TYPE_WLAN);
@@ -726,14 +725,8 @@ static int eeepc_hotk_add(struct acpi_device *device)
 
 static int eeepc_hotk_remove(struct acpi_device *device, int type)
 {
-	acpi_status status = 0;
-
 	if (!device || !acpi_driver_data(device))
 		 return -EINVAL;
-	status = acpi_remove_notify_handler(ehotk->handle, ACPI_SYSTEM_NOTIFY,
-					    eeepc_hotk_notify);
-	if (ACPI_FAILURE(status))
-		printk(EEEPC_ERR "Error removing notify handler\n");
 
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P6");
 	eeepc_unregister_rfkill_notifier("\\_SB.PCI0.P0P7");


------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
