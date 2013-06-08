From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/16] ACPICA: ACPICA Termination: Delete global lock pending lock
Date: Sat,  8 Jun 2013 08:59:55 +0800
Message-ID: <ebc8661e7ca7167099d5301858d034c564128a0b.1369274559.git.lv.zheng@intel.com>
References: <cover.1369274558.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64569 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab3FHBAS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Jun 2013 21:00:18 -0400
In-Reply-To: <cover.1369274558.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>

From: Tomasz Nowicki <tomasz.nowicki@linaro.org>

Add deletion of this lock, used for the global lock.  ACPICA BZ
1012. Tomasz Nowicki <tomasz.nowicki@linaro.org>

Buglink: https://bugs.acpica.org/show_bug.cgi?id=1012
Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/evglock.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/evglock.c b/drivers/acpi/acpica/evglock.c
index a621481..fdb0a76 100644
--- a/drivers/acpi/acpica/evglock.c
+++ b/drivers/acpi/acpica/evglock.c
@@ -128,6 +128,7 @@ acpi_status acpi_ev_remove_global_lock_handler(void)
 	status = acpi_remove_fixed_event_handler(ACPI_EVENT_GLOBAL,
 						 acpi_ev_global_lock_handler);
 
+	acpi_os_delete_lock(acpi_gbl_global_lock_pending_lock);
 	return_ACPI_STATUS(status);
 }
 
-- 
1.7.10

