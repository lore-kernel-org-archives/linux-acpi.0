From: Yi Yang <yi.y.yang@intel.com>
Subject: [PATCH 2.6.28-rc3] ACPI: fix inconsistent acpi event format
Date: Thu, 06 Nov 2008 00:42:52 +0800
Message-ID: <1225903372.17794.63.camel@yangyi-dev>
Reply-To: yi.y.yang@intel.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31476 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753619AbYKEInc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 5 Nov 2008 03:43:32 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Subject: ACPI: fix inconsistent acpi event format
From: Yi Yang <yi.y.yang@intel.com>

Event format acpi generates for /proc/acpi/event is different from
that for generic netlink interface. Here are i got:

>From /proc/acpi/event, i got the following events when i suspend and
resume Acer's Aspire One:

battery BAT1 00000080 00000000
battery BAT1 00000081 00000000
ac_adapter ACAD 00000080 00000001
battery BAT1 00000080 00000000

But from generic netlink socket, i got the following events when i suspend
and resume Acer's Aspire One:

battery PNP0C0A:00 00000080 00000000
battery PNP0C0A:00 00000081 00000000
ac_adapter ACPI0003:00 00000080 00000001
battery PNP0C0A:00 00000080 00000000

Such inconsistent event format will make acpid or hald confused, this patch
fixes this issue, it makes acpid or hald see the same thing no matter they use
/proc/acpi/event or generic netlink interface.

After applying this patch, event format i got from /proc/acpi/event and generic
netlink interface is same, all of them are:

battery BAT1 00000080 00000000
battery BAT1 00000081 00000000
ac_adapter ACAD 00000080 00000001
battery BAT1 00000080 00000000

Please consider applying, thanks.

Signed-off-by: Yi Yang <yi.y.yang@intel.com>
---
 battery.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index b2133e8..e52b336 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -782,7 +782,7 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 	acpi_bus_generate_proc_event(device, event,
 				     acpi_battery_present(battery));
 	acpi_bus_generate_netlink_event(device->pnp.device_class,
-					device->dev.bus_id, event,
+					device->pnp.bus_id, event,
 					acpi_battery_present(battery));
 #ifdef CONFIG_ACPI_SYSFS_POWER
 	/* acpi_batter_update could remove power_supply object */


