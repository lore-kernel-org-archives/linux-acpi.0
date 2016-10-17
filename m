From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH 2/7] ACPICA: MacOSX: Fix anonymous semaphore implementation
Date: Tue, 18 Oct 2016 03:02:40 +0800
Message-ID: <5e5749f96dac6d16f5b7f5225a9a83e5a167c1ba.1476725675.git.lv.zheng@intel.com>
References: <cover.1476725675.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35979 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932518AbcJQTC6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Oct 2016 15:02:58 -0400
Received: by mail-qk0-f195.google.com with SMTP id z190so14960647qkc.3
        for <linux-acpi@vger.kernel.org>; Mon, 17 Oct 2016 12:02:58 -0700 (PDT)
In-Reply-To: <cover.1476725675.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: linux-acpi@vger.kernel.org

ACPICA commit 01eb9a58f4cf6300a0feb838a02bc4b1895c76e8
ACPICA commit de5b9c0ef1ccb264cbe57c88f6dd3fbf8229f907

The following build errors can be seen for MacOSX builds:
.../osunixxf.c:829:42: error: 'tmpnam' is deprecated: This function is provided for compatibility reasons only.  Due to security concerns inherent in the design of tmpnam(3), it is highly recommended that you use mkstemp(3) instead. [-Werror,-Wdeprecated-declarations]

Using of temporal file name functions can easily result in bus errors on
MacOSX. This patch implements anonymous semaphore using an automatic
increasing number. Lv Zheng.

Linux is not affected by this change.

Link: https://github.com/acpica/acpica/commit/01eb9a58
Link: https://github.com/acpica/acpica/commit/de5b9c0e
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
---
 tools/power/acpi/os_specific/service_layers/osunixxf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/power/acpi/os_specific/service_layers/osunixxf.c b/tools/power/acpi/os_specific/service_layers/osunixxf.c
index 8d8003c..8f5ded8 100644
--- a/tools/power/acpi/os_specific/service_layers/osunixxf.c
+++ b/tools/power/acpi/os_specific/service_layers/osunixxf.c
@@ -646,8 +646,12 @@ acpi_os_create_semaphore(u32 max_units,
 	}
 #ifdef __APPLE__
 	{
-		char *semaphore_name = tmpnam(NULL);
+		static int semaphore_count = 0;
+		char semaphore_name[32];
 
+		snprintf(semaphore_name, sizeof(semaphore_name), "acpi_sem_%d",
+			 semaphore_count++);
+		printf("%s\n", semaphore_name);
 		sem =
 		    sem_open(semaphore_name, O_EXCL | O_CREAT, 0755,
 			     initial_units);
-- 
2.7.4

