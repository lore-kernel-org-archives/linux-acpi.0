From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/34] POWER: Add support for cycle_count
Date: Sun, 14 Mar 2010 21:40:45 -0400
Message-ID: <c955fe8e0bdd7be7a6bc2d49245d570a816f7cc5.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173017pub.verizon.net ([206.46.173.17]:38088 "EHLO
	vms173017pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab0COBrc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 21:47:32 -0400
Received: from sony ([unknown] [192.102.209.1]) by vms173017.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KZA005GAVN0N7U5@vms173017.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 14 Mar 2010 20:47:25 -0500 (CDT)
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/power/power_supply_sysfs.c |    1 +
 include/linux/power_supply.h       |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power_supply_sysfs.c
index c790e0c..ff05e61 100644
--- a/drivers/power/power_supply_sysfs.c
+++ b/drivers/power/power_supply_sysfs.c
@@ -99,6 +99,7 @@ static struct device_attribute power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(present),
 	POWER_SUPPLY_ATTR(online),
 	POWER_SUPPLY_ATTR(technology),
+	POWER_SUPPLY_ATTR(cycle_count),
 	POWER_SUPPLY_ATTR(voltage_max),
 	POWER_SUPPLY_ATTR(voltage_min),
 	POWER_SUPPLY_ATTR(voltage_max_design),
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index b5d096d..ebd2b8f 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -82,6 +82,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_ONLINE,
 	POWER_SUPPLY_PROP_TECHNOLOGY,
+	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_VOLTAGE_MAX,
 	POWER_SUPPLY_PROP_VOLTAGE_MIN,
 	POWER_SUPPLY_PROP_VOLTAGE_MAX_DESIGN,
-- 
1.7.0.2.201.g80978

