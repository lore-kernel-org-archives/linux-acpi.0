From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 05/11] ACPICA: Fix a typo in a function header, no functional change
Date: Fri, 12 Apr 2013 08:25:10 +0800
Message-ID: <1c3269962b6e15ca19d6d4b25c83033bbe912873.1365473142.git.lv.zheng@intel.com>
References: <cover.1364865215.git.lv.zheng@intel.com> <cover.1365473141.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2069 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150Ab3DLAZO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Apr 2013 20:25:14 -0400
In-Reply-To: <cover.1365473141.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org, Colin Ian King <colin.king@canonical.com>, Lv Zheng <lv.zheng@intel.com>

From: Colin Ian King <colin.king@canonical.com>

Reported by Colin King.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evevent.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/evevent.c b/drivers/acpi/acpica/evevent.c
index 02219ff..83cd45f 100644
--- a/drivers/acpi/acpica/evevent.c
+++ b/drivers/acpi/acpica/evevent.c
@@ -258,7 +258,7 @@ u32 acpi_ev_fixed_event_detect(void)
  * DESCRIPTION: Clears the status bit for the requested event, calls the
  *              handler that previously registered for the event.
  *              NOTE: If there is no handler for the event, the event is
- *              disabled to prevent futher interrupts.
+ *              disabled to prevent further interrupts.
  *
  ******************************************************************************/
 
-- 
1.7.10

