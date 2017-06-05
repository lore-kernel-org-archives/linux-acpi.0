From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 49/53] ACPICA: Unix application OSL: Correctly handle control-c (EINTR)
Date: Mon,  5 Jun 2017 16:42:07 +0800
Message-ID: <d9d0f42ccc9d5f3286a552090ae1d11b61eb1002.1496650343.git.lv.zheng@intel.com>
References: <cover.1496650343.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27817 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751495AbdFEImR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jun 2017 04:42:17 -0400
In-Reply-To: <cover.1496650343.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Bob Moore <robert.moore@intel.com>

From: Bob Moore <robert.moore@intel.com>

ACPICA commit dfbb87c3a96cfd007375f34a96e6f4a8ee477f97

Handle EINTR from a sem_wait operation. Ignore a control-c.

Link: https://github.com/acpica/acpica/commit/dfbb87c3
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 tools/power/acpi/os_specific/service_layers/osunixxf.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/tools/power/acpi/os_specific/service_layers/osunixxf.c
index c04e8fe..025c1b0 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
@@ -750,9 +750,9 @@ acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 msec_timeout)
 {
 	acpi_status status = AE_OK;
 	sem_t *sem = (sem_t *) handle;
+	int ret_val;
 #ifndef ACPI_USE_ALTERNATE_TIMEOUT
 	struct timespec time;
-	int ret_val;
 #endif
 
 	if (!sem) {
@@ -778,7 +778,10 @@ acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 msec_timeout)
 
 	case ACPI_WAIT_FOREVER:
 
-		if (sem_wait(sem)) {
+		while (((ret_val = sem_wait(sem)) == -1) && (errno == EINTR)) {
+			continue;	/* Restart if interrupted */
+		}
+		if (ret_val != 0) {
 			status = (AE_TIME);
 		}
 		break;
@@ -831,7 +834,8 @@ acpi_os_wait_semaphore(acpi_handle handle, u32 units, u16 msec_timeout)
 
 		while (((ret_val = sem_timedwait(sem, &time)) == -1)
 		       && (errno == EINTR)) {
-			continue;
+			continue;	/* Restart if interrupted */
+
 		}
 
 		if (ret_val != 0) {
-- 
2.7.4

