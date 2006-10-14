From: Len Brown <len.brown@intel.com>
Subject: [PATCH 28/28] ACPI: check battery status on resume for un/plug events during sleep
Date: Sat, 14 Oct 2006 04:06:09 -0400
Message-ID: <11608132063922-git-send-email-len.brown@intel.com>
References: <11608131691346-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:39500 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1160995AbWJNIDk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:03:40 -0400
In-Reply-To: <11608131691346-git-send-email-len.brown@intel.com>
Message-Id: <34c4415ab857dc6d51db08d62bcd45d4b8513bb6.1160812999.git.len.brown@intel.com>
In-Reply-To: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
References: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
Date: Tue, 10 Oct 2006 14:20:41 -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jiri Kosina <jikos@jikos.cz>, Andrew Morton <akpm@osdl.org>, Len Brown <len.brown@intel.com>

From: Jiri Kosina <jikos@jikos.cz>

Add ->resume method to the ACPI battery handler to check
if the battery state has changed during sleep.
If yes, update the ACPI internal data structures
for benefit of /proc/acpi/battery/.

Signed-off-by: Jiri Kosina <jikos@jikos.cz>
Cc: Stefan Seyfried <seife@suse.de>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 9810e2a..026e407 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -64,6 +64,7 @@ extern void *acpi_unlock_battery_dir(str
 
 static int acpi_battery_add(struct acpi_device *device);
 static int acpi_battery_remove(struct acpi_device *device, int type);
+static int acpi_battery_resume(struct acpi_device *device, int status);
 
 static struct acpi_driver acpi_battery_driver = {
 	.name = ACPI_BATTERY_DRIVER_NAME,
@@ -71,6 +72,7 @@ static struct acpi_driver acpi_battery_d
 	.ids = ACPI_BATTERY_HID,
 	.ops = {
 		.add = acpi_battery_add,
+		.resume = acpi_battery_resume,
 		.remove = acpi_battery_remove,
 		},
 };
@@ -753,6 +755,18 @@ static int acpi_battery_remove(struct ac
 	return 0;
 }
 
+/* this is needed to learn about changes made in suspended state */
+static int acpi_battery_resume(struct acpi_device *device, int state)
+{
+	struct acpi_battery *battery;
+
+	if (!device)
+		return -EINVAL;
+
+	battery = device->driver_data;
+	return acpi_battery_check(battery);
+}
+
 static int __init acpi_battery_init(void)
 {
 	int result;
-- 
1.4.3.rc2.g23bed-dirty
