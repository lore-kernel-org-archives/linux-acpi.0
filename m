From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH] ACPICA: Events: Fix issue that GPE register modifications are not protected after _Lxx/_Exx evaluation.
Date: Tue,  2 Dec 2014 08:56:55 +0800
Message-ID: <8b74d60e865216529ee0f5443fa9bcca949884f8.1417481649.git.lv.zheng@intel.com>
References: <2017469.J3BZteXtBu@vostro.rjw.lan>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59541 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161AbaLBA5J (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 1 Dec 2014 19:57:09 -0500
In-Reply-To: <2017469.J3BZteXtBu@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org

It is reported that there are pieces of code invoking acpi_ev_finish_gpe()
without holding acpi_gbl_gpe_lock. Since this function will modify GPE
register values, there could be race breaking the register modification
process.

This patch fixes this issue. Lv Zheng.

Reported-by: Joe Liu <joe.liu@apple.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
---
 drivers/acpi/acpica/evgpe.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 81db932..aa70154 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -616,8 +616,11 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 static void ACPI_SYSTEM_XFACE acpi_ev_asynch_enable_gpe(void *context)
 {
 	struct acpi_gpe_event_info *gpe_event_info = context;
+	acpi_cpu_flags flags;
 
+	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 	(void)acpi_ev_finish_gpe(gpe_event_info);
+	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 
 	ACPI_FREE(gpe_event_info);
 	return;
-- 
1.7.10

