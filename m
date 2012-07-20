From: Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH v2 4/4] ACPI: Update Container hotplug messages
Date: Fri, 20 Jul 2012 10:54:16 -0600
Message-ID: <1342803256-17514-5-git-send-email-toshi.kani@hp.com>
References: <1342803256-17514-1-git-send-email-toshi.kani@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1342803256-17514-1-git-send-email-toshi.kani@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lenb@kernel.org, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, joe@perches.com, bhelgaas@google.com, isimatu.yasuaki@jp.fujitsu.com, liuj97@gmail.com, srivatsa.bhat@linux.vnet.ibm.com, prarit@redhat.com, imammedo@redhat.com, vijaymohan.pandarathil@hp.com, Toshi Kani <toshi.kani@hp.com>
List-Id: linux-acpi@vger.kernel.org

Updated Container hotplug log messages with acpi_pr_<level>()
and pr_<level>().

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
 drivers/acpi/container.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/container.c b/drivers/acpi/container.c
index 01a986d..643e962 100644
--- a/drivers/acpi/container.c
+++ b/drivers/acpi/container.c
@@ -99,7 +99,7 @@ static int acpi_container_add(struct acpi_device *device)
 
 
 	if (!device) {
-		printk(KERN_ERR PREFIX "device is NULL\n");
+		pr_err(PREFIX "device is NULL\n");
 		return -EINVAL;
 	}
 
@@ -164,7 +164,7 @@ static void container_notify_cb(acpi_handle handle, u32 type, void *context)
 	case ACPI_NOTIFY_BUS_CHECK:
 		/* Fall through */
 	case ACPI_NOTIFY_DEVICE_CHECK:
-		printk(KERN_WARNING "Container driver received %s event\n",
+		pr_warn("Container driver received %s event\n",
 		       (type == ACPI_NOTIFY_BUS_CHECK) ?
 		       "ACPI_NOTIFY_BUS_CHECK" : "ACPI_NOTIFY_DEVICE_CHECK");
 
@@ -185,7 +185,7 @@ static void container_notify_cb(acpi_handle handle, u32 type, void *context)
 
 		result = container_device_add(&device, handle);
 		if (result) {
-			pr_warn("Failed to add container\n");
+			acpi_pr_warn(handle, "Failed to add container\n");
 			break;
 		}
 
-- 
1.7.7.6
