From: pingfank@linux.vnet.com
Subject: [PATCH] ACPI: Call ACPI remove handler when handling
	ACPI eject event
Date: Tue,  4 Oct 2011 19:13:36 +0800
Message-ID: <1317726818-8514-2-git-send-email-pingfank@linux.vnet.com>
References: <1317726818-8514-1-git-send-email-pingfank@linux.vnet.com>
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <1317726818-8514-1-git-send-email-pingfank@linux.vnet.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: </archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: linux-acpi@vger.kernel.org, qemu-devel@nongnu.org
Cc: aliguori@us.ibm.com, Liu Ping Fan <pingfank@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, ryanh@us.ibm.com, shaohua.li@intel.com, lenb@kernel.org
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
