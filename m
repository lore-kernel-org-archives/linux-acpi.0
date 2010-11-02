From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 2/2] ACPI battery: update battery status first when
 querying from sysfs
Date: Tue, 02 Nov 2010 11:24:55 +0800
Message-ID: <1288668295.2234.174.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:27230 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab0KBDZL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Nov 2010 23:25:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, cbou@mail.ru, seblu@seblu.net, "Zhang, Rui" <rui.zhang@intel.com>


Sometimes the Battery driver doesn't get notifications when it's
plugged/unplugged. And this results in the incorrect Battery
status reported by the power supply sysfs I/F.

Update the Battery status first when querying from sysfs.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/battery.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6/drivers/acpi/battery.c
===================================================================
--- linux-2.6.orig/drivers/acpi/battery.c
+++ linux-2.6/drivers/acpi/battery.c
@@ -184,6 +184,9 @@ static int acpi_battery_get_property(str
 	int ret = 0;
 	struct acpi_battery *battery = to_acpi_battery(psy);
 
+	if (acpi_battery_update(battery))
+		return -ENODEV;
+
 	if (acpi_battery_present(battery)) {
 		/* run battery update only if it is present */
 		acpi_battery_get_state(battery);


