From: Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH v7 4/5] ACPI: Update Container hotplug error messages
Date: Tue, 20 Nov 2012 16:42:29 -0700
Message-ID: <1353454950-17010-5-git-send-email-toshi.kani@hp.com>
References: <1353454950-17010-1-git-send-email-toshi.kani@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353454950-17010-1-git-send-email-toshi.kani@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, rjw@sisk.pl, lenb@kernel.org
Cc: linux-kernel@vger.kernel.org, joe@perches.com, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, vijaymohan.pandarathil@hp.com, Toshi Kani <toshi.kani@hp.com>
List-Id: linux-acpi@vger.kernel.org

Updated Container hotplug error messages with acpi_handle_<level>()
and pr_<level>().  Removed an unnecessary check to the device arg
in acpi_container_add().

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
 drivers/acpi/container.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 69e2d6b..811910b 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -110,12 +110,6 @@ static int acpi_container_add(struct acpi_device *device)
 {
 	struct acpi_container *container;
 
-
-	if (!device) {
-		printk(KERN_ERR PREFIX "device is NULL\n");
-		return -EINVAL;
-	}
-
 	container = kzalloc(sizeof(struct acpi_container), GFP_KERNEL);
 	if (!container)
 		return -ENOMEM;
@@ -177,7 +171,7 @@ static void container_notify_cb(acpi_handle handle, u32 type, void *context)
 	case ACPI_NOTIFY_BUS_CHECK:
 		/* Fall through */
 	case ACPI_NOTIFY_DEVICE_CHECK:
-		printk(KERN_WARNING "Container driver received %s event\n",
+		pr_debug("Container driver received %s event\n",
 		       (type == ACPI_NOTIFY_BUS_CHECK) ?
 		       "ACPI_NOTIFY_BUS_CHECK" : "ACPI_NOTIFY_DEVICE_CHECK");
 
@@ -198,7 +192,7 @@ static void container_notify_cb(acpi_handle handle, u32 type, void *context)
 
 		result = container_device_add(&device, handle);
 		if (result) {
-			printk(KERN_WARNING "Failed to add container\n");
+			acpi_handle_warn(handle, "Failed to add container\n");
 			break;
 		}
 
-- 
1.7.11.7
