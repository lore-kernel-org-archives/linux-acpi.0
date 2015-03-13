From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] ACPI / scan: fix fixed event handler return value
Date: Fri, 13 Mar 2015 13:52:50 +0800
Message-ID: <20150313055250.GA23305@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59965 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbbCMFyI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 13 Mar 2015 01:54:08 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

The fixed event handler should return a value that is either 0 or 1
meanning if the event is handled or not, instead of an acpi_status to
mean if the handler runs well or not.

Suggested-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/acpi/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index bbca7830e18a..3e5a2768c3b4 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1062,10 +1062,10 @@ static void acpi_device_notify_fixed(void *data)
 	acpi_device_notify(NULL, ACPI_FIXED_HARDWARE_EVENT, device);
 }
 
-static acpi_status acpi_device_fixed_event(void *data)
+static u32 acpi_device_fixed_event(void *data)
 {
 	acpi_os_execute(OSL_NOTIFY_HANDLER, acpi_device_notify_fixed, data);
-	return AE_OK;
+	return ACPI_INTERRUPT_HANDLED;
 }
 
 static int acpi_device_install_notify_handler(struct acpi_device *device)
-- 
2.1.0

