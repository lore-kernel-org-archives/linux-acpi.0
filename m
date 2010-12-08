From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 4/4] ACPI: update battery status first when querying from
 sysfs
Date: Wed, 08 Dec 2010 10:40:49 +0800
Message-ID: <1291776049.19296.705.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:1415 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756043Ab0LHClE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Dec 2010 21:41:04 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, seblu@seblu.net, "Zhang, Rui" <rui.zhang@intel.com>

Sometimes the Battery driver doesn't get notifications when it's
plugged/unplugged. And this results in the incorrect Battery
status reported by the power supply sysfs I/F.

Update Battery status first when querying from sysfs.
http://marc.info/?l=linux-acpi&m=128855015826728&w=2

Tested_by: Seblu <seblu@seblu.net>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/battery.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6/drivers/acpi/battery.c
===================================================================
--- linux-2.6.orig/drivers/acpi/battery.c
+++ linux-2.6/drivers/acpi/battery.c
@@ -130,6 +130,8 @@ struct acpi_battery {
 	unsigned long flags;
 };
 
+static int acpi_battery_update(struct acpi_battery *battery);
+
 #define to_acpi_battery(x) container_of(x, struct acpi_battery, bat);
 
 inline int acpi_battery_present(struct acpi_battery *battery)
@@ -184,6 +186,9 @@ static int acpi_battery_get_property(str
 	int ret = 0;
 	struct acpi_battery *battery = to_acpi_battery(psy);
 
+	if (acpi_battery_update(battery))
+		return -ENODEV;
+
 	if (acpi_battery_present(battery)) {
 		/* run battery update only if it is present */
 		acpi_battery_get_state(battery);


