From: Mathias Krause <minipli@googlemail.com>
Subject: [PATCH 06/12] ACPI / battery: minor tweaks to acpi_battery_units()
Date: Sat, 13 Jun 2015 14:26:54 +0200
Message-ID: <1434198420-8519-7-git-send-email-minipli@googlemail.com>
References: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:36486 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbbFMM1T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Jun 2015 08:27:19 -0400
Received: by wgzl5 with SMTP id l5so14265545wgz.3
        for <linux-acpi@vger.kernel.org>; Sat, 13 Jun 2015 05:27:17 -0700 (PDT)
In-Reply-To: <1434198420-8519-1-git-send-email-minipli@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mathias Krause <minipli@googlemail.com>

Make the acpi_battery_units() function take a const argument and return
a const char*, too. Also make it static. It probably doesn't matter, as
gcc will be clever enough to optimize and inline the code even without
these hints. However, we also get rid of a #ifdef block by moving the
function closer to its usage location, so it's at least a small gain in
code readability.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
---
 drivers/acpi/battery.c |   14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 8ec28e395fa1..309ba02d4eb8 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -338,14 +338,6 @@ static enum power_supply_property energy_battery_props[] = {
 	POWER_SUPPLY_PROP_SERIAL_NUMBER,
 };
 
-#ifdef CONFIG_ACPI_PROCFS_POWER
-inline char *acpi_battery_units(struct acpi_battery *battery)
-{
-	return (battery->power_unit == ACPI_BATTERY_POWER_UNIT_MA) ?
-		"mA" : "mW";
-}
-#endif
-
 /* --------------------------------------------------------------------------
                                Battery Management
    -------------------------------------------------------------------------- */
@@ -792,6 +784,12 @@ static void acpi_battery_refresh(struct acpi_battery *battery)
 #ifdef CONFIG_ACPI_PROCFS_POWER
 static struct proc_dir_entry *acpi_battery_dir;
 
+static const char *acpi_battery_units(const struct acpi_battery *battery)
+{
+	return (battery->power_unit == ACPI_BATTERY_POWER_UNIT_MA) ?
+		"mA" : "mW";
+}
+
 static int acpi_battery_print_info(struct seq_file *seq, int result)
 {
 	struct acpi_battery *battery = seq->private;
-- 
1.7.10.4

