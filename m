From: akpm@osdl.org
Subject: [patch 10/12] acpi: preserve correct battery state through suspend/resume cycles
Date: Tue, 10 Oct 2006 14:20:41 -0700
Message-ID: <200610102120.k9ALKfDU024293@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:46754 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030554AbWJJVvT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 10 Oct 2006 17:51:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, jikos@jikos.cz, pavel@ucw.cz, seife@suse.de

From: Jiri Kosina <jikos@jikos.cz>

There is a problem in th following scenario(s):

boot -> suspend -> (un)plug battery -> resume

The problem arises in both cases - i.e.  suspend with battery plugged in,
and resume with battery unplugged, or vice versa.

After resume, when the battery status has changed (plugged in -> unplegged
or unplugged -> plugged in) during the time when the system was sleeping,
the /proc/acpi/battery/*/* is wrong (showing the state before suspend, not
the current state).

The following patch adds ->resume method to the ACPI battery handler, which
has the only aim - to check whether the battery state has changed during
sleep, and if so, update the ACPI internal data structures, so that
information published through /proc/acpi/battery/*/* is correct even after
suspend/resume cycle, during which the battery was removed/inserted.

The patch is against current ACPI git tree, but applies cleanly also
against -mm and probably other trees. Please apply.

Signed-off-by: Jiri Kosina <jikos@jikos.cz>
Cc: "Brown, Len" <len.brown@intel.com>
Cc: Stefan Seyfried <seife@suse.de>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/battery.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+)

diff -puN drivers/acpi/battery.c~acpi-preserve-correct-battery-state-through-suspend-resume-cycles drivers/acpi/battery.c
--- a/drivers/acpi/battery.c~acpi-preserve-correct-battery-state-through-suspend-resume-cycles
+++ a/drivers/acpi/battery.c
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
_
