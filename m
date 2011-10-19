From: pingfank@linux.vnet.ibm.com
Subject: [PATCH 1/1] ACPI: Call ACPI remove handler when handling ACPI eject event
Date: Wed, 19 Oct 2011 10:47:50 +0800
Message-ID: <1318992470-10195-2-git-send-email-pingfank@linux.vnet.ibm.com>
References: <1318992470-10195-1-git-send-email-pingfank@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1318992470-10195-1-git-send-email-pingfank@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, seabios@seabios.org, lenb@kernel.org, shaohua.li@intel.com
Cc: linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, aliguori@us.ibm.com, dave@linux.vnet.ibm.com, Liu Ping Fan <pingfank@linux.vnet.ibm.com>
List-Id: linux-acpi@vger.kernel.org

From: Liu Ping Fan <pingfank@linux.vnet.ibm.com>

Call the remove handler for ACPI_NOTIFY_EJECT_REQUEST

Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
---
 drivers/acpi/bus.c      |    2 +-
 drivers/acpi/scan.c     |    2 +-
 include/acpi/acpi_bus.h |    2 ++
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 437ddbf..d06ec6d 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -764,7 +764,7 @@ static void acpi_bus_notify(acpi_handle handle, u32 type, void *data)
 		break;
 
 	case ACPI_NOTIFY_EJECT_REQUEST:
-		/* TBD */
+		acpi_os_hotplug_execute(acpi_bus_hot_remove_device, handle);
 		break;
 
 	case ACPI_NOTIFY_DEVICE_CHECK_LIGHT:
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 449c556..3b97b61 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -83,7 +83,7 @@ acpi_device_modalias_show(struct device *dev, struct device_attribute *attr, cha
 }
 static DEVICE_ATTR(modalias, 0444, acpi_device_modalias_show, NULL);
 
-static void acpi_bus_hot_remove_device(void *context)
+void acpi_bus_hot_remove_device(void *context)
 {
 	struct acpi_device *device;
 	acpi_handle handle = context;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 6cd5b64..b19c09d 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -310,6 +310,8 @@ extern int unregister_acpi_notifier(struct notifier_block *);
 
 extern int register_acpi_bus_notifier(struct notifier_block *nb);
 extern void unregister_acpi_bus_notifier(struct notifier_block *nb);
+extern void acpi_bus_hot_remove_device(void *context);
+
 /*
  * External Functions
  */
-- 
1.7.4.4
