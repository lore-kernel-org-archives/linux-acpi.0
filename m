From: Jiang Liu <liuj97@gmail.com>
Subject: [PATCH v3 03/10] ACPI, DOCK: mark initialization functions with __init
Date: Sat, 29 Jun 2013 00:24:36 +0800
Message-ID: <1372436683-31711-4-git-send-email-liuj97@gmail.com>
References: <1372436683-31711-1-git-send-email-liuj97@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1372436683-31711-1-git-send-email-liuj97@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@sisk.pl>
Cc: liuj97@gmail.com, Jiang Liu <jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

From: Jiang Liu <jiang.liu@huawei.com>

Mark all initialization functions with __init to reduce runtime memory
consumption.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/acpi/dock.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index a73571f..8c4214d 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -100,7 +100,7 @@ struct dock_dependent_device {
  *
  * Add the dependent device to the dock's dependent device list.
  */
-static int
+static int __init
 add_dock_dependent_device(struct dock_station *ds, acpi_handle handle)
 {
 	struct dock_dependent_device *dd;
@@ -244,7 +244,7 @@ static int is_dock(acpi_handle handle)
 	return 1;
 }
 
-static int is_ejectable(acpi_handle handle)
+static int __init is_ejectable(acpi_handle handle)
 {
 	acpi_status status;
 	acpi_handle tmp;
@@ -255,7 +255,7 @@ static int is_ejectable(acpi_handle handle)
 	return 1;
 }
 
-static int is_ata(acpi_handle handle)
+static int __init is_ata(acpi_handle handle)
 {
 	acpi_handle tmp;
 
@@ -268,7 +268,7 @@ static int is_ata(acpi_handle handle)
 	return 0;
 }
 
-static int is_battery(acpi_handle handle)
+static int __init is_battery(acpi_handle handle)
 {
 	struct acpi_device_info *info;
 	int ret = 1;
@@ -284,7 +284,7 @@ static int is_battery(acpi_handle handle)
 	return ret;
 }
 
-static int is_ejectable_bay(acpi_handle handle)
+static int __init is_ejectable_bay(acpi_handle handle)
 {
 	acpi_handle phandle;
 
@@ -848,7 +848,7 @@ static struct notifier_block dock_acpi_notifier = {
  * check to see if an object has an _EJD method.  If it does, then it
  * will see if it is dependent on the dock station.
  */
-static acpi_status
+static acpi_status __init
 find_dock_devices(acpi_handle handle, u32 lvl, void *context, void **rv)
 {
 	acpi_status status;
-- 
1.8.1.2
