From: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
Subject: [PATCH 2/6] ACPI: ac: use .notify method instead
	of installing	handler directly
Date: Thu, 30 Apr 2009 09:35:42 -0600
Message-ID: <20090430153542.12628.94842.stgit@bob.kio>
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

This driver apparently relies on seeing ALL notify events, not just
device-specific ones (because it used ACPI_ALL_NOTIFY).  We use the
ACPI_DRIVER_ALL_NOTIFY_EVENTS driver flag to request all events.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas-VXdhtT5mjnY@public.gmane.org>
CC: Alexey Starikovskiy <alexey.y.starikovskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/ac.c |   20 +++++---------------
 1 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index 88e42ab..0df8fcb 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -61,6 +61,7 @@ static int acpi_ac_open_fs(struct inode *inode, struct file *file);
 static int acpi_ac_add(struct acpi_device *device);
 static int acpi_ac_remove(struct acpi_device *device, int type);
 static int acpi_ac_resume(struct acpi_device *device);
+static void acpi_ac_notify(struct acpi_device *device, u32 event);
 
 static const struct acpi_device_id ac_device_ids[] = {
 	{"ACPI0003", 0},
@@ -72,10 +73,12 @@ static struct acpi_driver acpi_ac_driver = {
 	.name = "ac",
 	.class = ACPI_AC_CLASS,
 	.ids = ac_device_ids,
+	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = acpi_ac_add,
 		.remove = acpi_ac_remove,
 		.resume = acpi_ac_resume,
+		.notify = acpi_ac_notify,
 		},
 };
 
@@ -220,16 +223,14 @@ static int acpi_ac_remove_fs(struct acpi_device *device)
                                    Driver Model
    -------------------------------------------------------------------------- */
 
-static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
+static void acpi_ac_notify(struct acpi_device *device, u32 event)
 {
-	struct acpi_ac *ac = data;
-	struct acpi_device *device = NULL;
+	struct acpi_ac *ac = acpi_driver_data(device);
 
 
 	if (!ac)
 		return;
 
-	device = ac->device;
 	switch (event) {
 	default:
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
@@ -253,7 +254,6 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 static int acpi_ac_add(struct acpi_device *device)
 {
 	int result = 0;
-	acpi_status status = AE_OK;
 	struct acpi_ac *ac = NULL;
 
 
@@ -286,13 +286,6 @@ static int acpi_ac_add(struct acpi_device *device)
 	ac->charger.get_property = get_ac_property;
 	power_supply_register(&ac->device->dev, &ac->charger);
 #endif
-	status = acpi_install_notify_handler(device->handle,
-					     ACPI_ALL_NOTIFY, acpi_ac_notify,
-					     ac);
-	if (ACPI_FAILURE(status)) {
-		result = -ENODEV;
-		goto end;
-	}
 
 	printk(KERN_INFO PREFIX "%s [%s] (%s)\n",
 	       acpi_device_name(device), acpi_device_bid(device),
@@ -328,7 +321,6 @@ static int acpi_ac_resume(struct acpi_device *device)
 
 static int acpi_ac_remove(struct acpi_device *device, int type)
 {
-	acpi_status status = AE_OK;
 	struct acpi_ac *ac = NULL;
 
 
@@ -337,8 +329,6 @@ static int acpi_ac_remove(struct acpi_device *device, int type)
 
 	ac = acpi_driver_data(device);
 
-	status = acpi_remove_notify_handler(device->handle,
-					    ACPI_ALL_NOTIFY, acpi_ac_notify);
 #ifdef CONFIG_ACPI_SYSFS_POWER
 	if (ac->charger.dev)
 		power_supply_unregister(&ac->charger);


------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
