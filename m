From: tianyu.lan@intel.com
Subject: [PATCH] ACPI/Battery: Fix parsing _BIX return value
Date: Tue, 30 Jul 2013 09:54:58 +0800
Message-ID: <1375149298-28206-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22237 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062Ab3G3CDN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Jul 2013 22:03:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, jan.christian.hoffmann@gmail.com

From: Lan Tianyu <tianyu.lan@intel.com>

The _BIX method returns extended battery info as a package. According
ACPI spec 10.2.2.2, the first member should be "Revision". However,
current acpi battery driver treats the first member as "Power Unit"
which should be the second member. So the parsing operation is mismatch.
This patch is to fix it.

Reported-and-tested-by: Jan Hoffmann <jan.christian.hoffmann@gmail.com>
Reference: http://bugzilla.kernel.org/show_bug.cgi?id=60519
CC: stable@vger.kernel.org  #v2.6.34+
Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 drivers/acpi/battery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index c760b61..2c9958c 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -117,6 +117,7 @@ struct acpi_battery {
 	struct acpi_device *device;
 	struct notifier_block pm_nb;
 	unsigned long update_time;
+	int revision;
 	int rate_now;
 	int capacity_now;
 	int voltage_now;
@@ -359,6 +360,7 @@ static struct acpi_offsets info_offsets[] = {
 };
 
 static struct acpi_offsets extended_info_offsets[] = {
+	{offsetof(struct acpi_battery, revision), 0},
 	{offsetof(struct acpi_battery, power_unit), 0},
 	{offsetof(struct acpi_battery, design_capacity), 0},
 	{offsetof(struct acpi_battery, full_charge_capacity), 0},
-- 
1.8.3.2

