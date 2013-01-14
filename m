From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] ACPI / PM: remove leading whitespace from #ifdef
Date: Mon, 14 Jan 2013 22:13:37 +0200
Message-ID: <1358194417-10477-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:59143 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758047Ab3ANUM7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Jan 2013 15:12:59 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Mika Westerberg <mika.westerberg@linux.intel.com>

It is there probably due to an accident, get rid of it so that the format
is consistent across the file.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/acpi/device_pm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index 8bca746..43116cd 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -592,7 +592,7 @@ static inline void acpi_wakeup_device(acpi_handle handle, u32 event,
 				      void *context) {}
 #endif /* CONFIG_PM_RUNTIME */
 
- #ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_PM_SLEEP
 /**
  * __acpi_device_sleep_wake - Enable or disable device to wake up the system.
  * @dev: Device to enable/desible to wake up the system.
-- 
1.7.10.4

