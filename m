From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/12] ACPI: battery: Fix CONFIG_ACPI_SYSFS_POWER=n
Date: Tue, 06 Apr 2010 03:06:21 -0400
Message-ID: <e363a755e8033e18f733fc0d1687039df8efade0.1270537380.git.len.brown@intel.com>
References: <1270537583-8756-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:53006 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756973Ab0DFVcF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Apr 2010 17:32:05 -0400
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L0H00D7A551QQ84@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 06 Apr 2010 16:32:01 -0500 (CDT)
In-reply-to: <1270537583-8756-1-git-send-email-lenb@kernel.org>
In-reply-to: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
References: <dadf28a10c3eb29421837a2e413ab869ebd9e168.1270537380.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Disabling CONFIG_ACPI_SYSFS_POWER changes the behaviour of
acpi_battery_update().  It will call acpi_battery_get_info()
even if the battery is not present.  I haven't noticed this
causing any problem, but it does look like a bad idea.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 75f39f2..52df994 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -567,13 +567,13 @@ static int acpi_battery_update(struct acpi_battery *battery)
 	result = acpi_battery_get_status(battery);
 	if (result)
 		return result;
-#ifdef CONFIG_ACPI_SYSFS_POWER
 	if (!acpi_battery_present(battery)) {
+#ifdef CONFIG_ACPI_SYSFS_POWER
 		sysfs_remove_battery(battery);
+#endif
 		battery->update_time = 0;
 		return 0;
 	}
-#endif
 	if (!battery->update_time ||
 	    old_present != acpi_battery_present(battery)) {
 		result = acpi_battery_get_info(battery);
-- 
1.6.0.6

