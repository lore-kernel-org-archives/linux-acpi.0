From: Len Brown <len.brown@intel.com>
Subject: [PATCH 04/77] process reading battery status hangs
Date: Sun, 22 Jul 2007 05:13:49 -0400
Message-ID: <11850957062754-git-send-email-len.brown@intel.com>
References: <11850957022956-git-send-email-len.brown@intel.com>
 <11850957033938-git-send-email-len.brown@intel.com>
 <11850957043270-git-send-email-len.brown@intel.com>
 <11850957053842-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54665 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761457AbXGVJPI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 22 Jul 2007 05:15:08 -0400
In-Reply-To: <11850957053842-git-send-email-len.brown@intel.com>
Message-Id: <6eedeef73e7fff32eb5fa25178c3c77b1db0ec0f.1185095456.git.len.brown@intel.com>
In-Reply-To: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
References: <a1f0eff21edac1bd87e397f56c4258b9611b5a50.1185095456.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Vladimir Lebedev <vladimir.p.lebedev@gmail.com>, Len Brown <len.brown@intel.com>

From: Vladimir Lebedev <vladimir.p.lebedev@gmail.com>

http://bugzilla.kernel.org/show_bug.cgi?id=8351

Signed-off-by: Vladimir Lebedev <vladimir.p.lebedev@gmail.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/battery.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index fc9c50a..b5df318 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -937,10 +937,8 @@ static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 	case ACPI_BATTERY_NOTIFY_INFO:
 	case ACPI_NOTIFY_BUS_CHECK:
 	case ACPI_NOTIFY_DEVICE_CHECK:
-		acpi_battery_mutex_lock(battery);
 		device = battery->device;
 		acpi_battery_notify_update(battery);
-		acpi_battery_mutex_unlock(battery);
 		acpi_bus_generate_event(device, event,
 					acpi_battery_present(battery));
 		break;
-- 
1.5.3.rc2.22.g69a9b
