From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH 3/7] ACPICA: MacOSX: Fix wrong sem_destroy definition
Date: Tue, 18 Oct 2016 03:03:01 +0800
Message-ID: <064cfde6bf403ab874bfa8b6e5c5f9af384c894d.1476725675.git.lv.zheng@intel.com>
References: <cover.1476725675.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35081 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933210AbcJQTDQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Oct 2016 15:03:16 -0400
Received: by mail-qk0-f196.google.com with SMTP id v138so14974892qka.2
        for <linux-acpi@vger.kernel.org>; Mon, 17 Oct 2016 12:03:15 -0700 (PDT)
In-Reply-To: <cover.1476725675.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: linux-acpi@vger.kernel.org

ACPICA commit bbcb58f7875381d5c7f3d614bad3bc628a3f5cc6

The following build errors can be seen for MacOSX builds:
.../osunixxf.c:882:9: error: 'sem_close' is deprecated [-Werror,-Wdeprecated-declarations]
.../acmacosx.h:122:29: note: expanded from macro 'sem_destroy'
#define sem_destroy         sem_close

sem_destroy() issue is caused by the wrong order of the following lines:
  #define #sem_destroy        sem_close
  #include <semaphore.h>
This patch fixes it by removing the buggy re-definitiion. Lv Zheng.

Linux is not affected by this change.

Link: https://github.com/acpica/acpica/commit/bbcb58f7
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 tools/power/acpi/os_specific/service_layers/osunixxf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/tools/power/acpi/os_specific/service_layers/osunixxf.c
index 8f5ded8..10648aa 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
@@ -696,10 +696,15 @@ acpi_status acpi_os_delete_semaphore(acpi_handle handle)
 	if (!sem) {
 		return (AE_BAD_PARAMETER);
 	}
-
+#ifdef __APPLE__
+	if (sem_close(sem) == -1) {
+		return (AE_BAD_PARAMETER);
+	}
+#else
 	if (sem_destroy(sem) == -1) {
 		return (AE_BAD_PARAMETER);
 	}
+#endif
 
 	return (AE_OK);
 }
-- 
2.7.4

