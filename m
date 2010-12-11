From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/15] ACPI battery: update status upon sysfs query
Date: Sat, 11 Dec 2010 02:06:29 -0500
Message-ID: <3138b32d5e0998ba3cbd1c74bdc1887d74c5279b.1292051119.git.len.brown@intel.com>
References: <1292051200-13689-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:52844 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094Ab0LKHG6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Dec 2010 02:06:58 -0500
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LD900LZN53JRHR2@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 11 Dec 2010 01:06:58 -0600 (CST)
In-reply-to: <1292051200-13689-1-git-send-email-lenb@kernel.org>
In-reply-to: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
References: <212967c69afd348342548272aedbe4d46a9325d6.1292051119.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Sometimes the Battery driver doesn't get notifications when it's
plugged/unplugged. And this results in the incorrect Battery
status reported by the power supply sysfs I/F.

Update Battery status first when querying from sysfs.
http://marc.info/?l=linux-acpi&m=128855015826728&w=2

Tested_by: Seblu <seblu@seblu.net>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 95649d3..9fb9d5a 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -130,6 +130,8 @@ struct acpi_battery {
 	unsigned long flags;
 };
 
+static int acpi_battery_update(struct acpi_battery *battery);
+
 #define to_acpi_battery(x) container_of(x, struct acpi_battery, bat);
 
 inline int acpi_battery_present(struct acpi_battery *battery)
@@ -184,6 +186,9 @@ static int acpi_battery_get_property(struct power_supply *psy,
 	int ret = 0;
 	struct acpi_battery *battery = to_acpi_battery(psy);
 
+	if (acpi_battery_update(battery))
+		return -ENODEV;
+
 	if (acpi_battery_present(battery)) {
 		/* run battery update only if it is present */
 		acpi_battery_get_state(battery);
-- 
1.7.3.3.480.g2f76a

