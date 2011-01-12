From: Len Brown <lenb@kernel.org>
Subject: [PATCH 46/48] ACPI: Always check if _PRW is present before trying to
 evaluate it
Date: Wed, 12 Jan 2011 05:19:40 -0500
Message-ID: <86e4e20e8a5301ff7104a4f40f35fd5bee408186.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64394 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab1ALRAc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 12:00:32 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX001MR5WB77F2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 11:00:27 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Before evaluating _PRW for devices that are reported as inactive or
not present by their _STA control methods we should check if those
methods are actually present (otherwise the evaulation of _PRW will
obviously fail and a scary message will be printed unnecessarily).

Reported-by: Andreas Mohr <andi@lisas.de>
Reported-by: Maciej Rutecki <maciej.rutecki@gmail.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/scan.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 64d4da0..b5e4ded 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1388,7 +1388,6 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl,
 	struct acpi_bus_ops *ops = context;
 	int type;
 	unsigned long long sta;
-	struct acpi_device_wakeup wakeup;
 	struct acpi_device *device;
 	acpi_status status;
 	int result;
@@ -1399,7 +1398,13 @@ static acpi_status acpi_bus_check_add(acpi_handle handle, u32 lvl,
 
 	if (!(sta & ACPI_STA_DEVICE_PRESENT) &&
 	    !(sta & ACPI_STA_DEVICE_FUNCTIONING)) {
-		acpi_bus_extract_wakeup_device_power_package(handle, &wakeup);
+		struct acpi_device_wakeup wakeup;
+		acpi_handle temp;
+
+		status = acpi_get_handle(handle, "_PRW", &temp);
+		if (ACPI_SUCCESS(status))
+			acpi_bus_extract_wakeup_device_power_package(handle,
+								     &wakeup);
 		return AE_CTRL_DEPTH;
 	}
 
-- 
1.7.4.rc1.7.g2cf08

