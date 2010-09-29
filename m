From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/16] ACPI: Don't report current_now if battery reports in mWh
Date: Tue, 28 Sep 2010 23:44:31 -0400
Message-ID: <b137b9942a07843c64a934cfdb7d43155e507e13.1285731809.git.len.brown@intel.com>
References: <1285731886-18321-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:44062 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340Ab0I2DpC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Sep 2010 23:45:02 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L9H0006LP2Z8676@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 28 Sep 2010 22:45:01 -0500 (CDT)
In-reply-to: <1285731886-18321-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Matthew Garrett <mjg@redhat.com>, Arjan van de Ven <arjan@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Matthew Garrett <mjg@redhat.com>

ACPI batteries can report in units of either current or energy. Right
now we expose the current_now file even if the battery is reporting
energy units, resulting in a file that should contain mA instead
containing mW. Don't expose this value unless the battery is reporting
current.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index dc58402..9841720 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -273,7 +273,6 @@ static enum power_supply_property energy_battery_props[] = {
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN_DESIGN,
 	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_POWER_NOW,
 	POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN,
 	POWER_SUPPLY_PROP_ENERGY_FULL,
-- 
1.7.3.2.g9027fa

