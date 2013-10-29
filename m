From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 09/20] ACPICA: Fix possible memory leaks in the GPE handling.
Date: Tue, 29 Oct 2013 09:29:40 +0800
Message-ID: <4f3b9ac3b44792b11edbd54c36ce80e58fe88e02.1383009405.git.lv.zheng@intel.com>
References: <cover.1383009405.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:61282 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755810Ab3J2B3s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Oct 2013 21:29:48 -0400
In-Reply-To: <cover.1383009405.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org

This change fixes potential memory leaks in the error paths of the GPE
handling code. Lv Zheng.

Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 drivers/acpi/acpica/evgpe.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index c8a1f7d..1979a25 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -522,6 +522,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 
 	status = acpi_ut_release_mutex(ACPI_MTX_EVENTS);
 	if (ACPI_FAILURE(status)) {
+		ACPI_FREE(local_gpe_event_info);
 		return_VOID;
 	}
 
-- 
1.7.10

