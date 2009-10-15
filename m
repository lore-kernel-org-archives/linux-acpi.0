From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: [PATCH 2/4] POWER: Add support for cycle_count
Date: Thu, 15 Oct 2009 14:31:30 +0400
Message-ID: <20091015103130.3853.89932.stgit@thinkpad>
References: <20091015103122.3853.34760.stgit@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:39491 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756996AbZJOKcI (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Thu, 15 Oct 2009 06:32:08 -0400
In-Reply-To: <20091015103122.3853.34760.stgit@thinkpad>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/power/power_supply_sysfs.c |    1 +
 include/linux/power_supply.h       |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)


diff --git a/drivers/power/power_supply_sysfs.c b/drivers/power/power_supply_sysfs.c
index 0814439..2a52345 100644
--- a/drivers/power/power_supply_sysfs.c
+++ b/drivers/power/power_supply_sysfs.c
@@ -96,6 +96,7 @@ static struct device_attribute power_supply_attrs[] = {
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

