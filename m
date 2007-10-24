From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: 2.6.24-rc1 acpi battery driver -> sysfs interface does not update
 correctly
Date: Wed, 24 Oct 2007 22:53:08 +0400
Message-ID: <471F9494.8080503@gmail.com>
References: <3e7b9f4b0710241114u73ad1d4bl34070b4fd2b18d63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090308030006020901000400"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:47103 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbXJXSxS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Oct 2007 14:53:18 -0400
Received: by ug-out-1314.google.com with SMTP id z38so379091ugc
        for <linux-acpi@vger.kernel.org>; Wed, 24 Oct 2007 11:53:16 -0700 (PDT)
In-Reply-To: <3e7b9f4b0710241114u73ad1d4bl34070b4fd2b18d63@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ash Milsted <thatistosayiseenem@gawab.com>
Cc: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------090308030006020901000400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Ash Milsted wrote:
> Hello,
> 
> I just tried out the new RC on my laptop system, initially neglecting
> to enable ACPI_PROCFS support. Thus I was thrust into using the new
> sysfs interface for the battery.c driver. ..
> 
> Unfortunately the charge values etc do not seem to update periodically
> - only (un)plugging the AC power updates the status if ACPI_PROCFS is
> disabled.
> If ACPI_PROCFS is enabled then a read to /proc/acpi/battery/state gets
> the up-to-date data, and a subsequent read to the sysfs equivalents
> gives the same results - otherwise sysfs stays stale.
> 
> If you need any more info please say so - this is on an ageing Toshiba
> Satellite 1110.
Could you please test this patch?

> 
> Thanks,
> 
> Ash
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


--------------090308030006020901000400
Content-Type: text/x-diff;
 name="run_update_battery_from_sysfs_read.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="run_update_battery_from_sysfs_read.patch"

ACPI: battery: run acpi_battery_update from sysfs read

From: Alexey Starikovskiy <astarikovskiy@suse.de>

Update battery information at sysfs read.

Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
---

 drivers/acpi/battery.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 681e26b..02a396d 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -130,6 +130,8 @@ static int acpi_battery_technology(struct acpi_battery *battery)
 	return POWER_SUPPLY_TECHNOLOGY_UNKNOWN;
 }
 
+static int acpi_battery_update(struct acpi_battery *battery);
+
 static int acpi_battery_get_property(struct power_supply *psy,
 				     enum power_supply_property psp,
 				     union power_supply_propval *val)
@@ -139,6 +141,7 @@ static int acpi_battery_get_property(struct power_supply *psy,
 	if ((!acpi_battery_present(battery)) &&
 	     psp != POWER_SUPPLY_PROP_PRESENT)
 		return -ENODEV;
+	acpi_battery_update(battery);
 	switch (psp) {
 	case POWER_SUPPLY_PROP_STATUS:
 		if (battery->state & 0x01)

--------------090308030006020901000400--
