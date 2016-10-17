From: Lv Zheng <zetalog@gmail.com>
Subject: [PATCH 4/7] ACPICA: Increase loop limit for AE_AML_INFINITE_LOOP exception
Date: Tue, 18 Oct 2016 03:03:19 +0800
Message-ID: <1dbbf4f310e3946a0daf1b7962808dfc3a5c5327.1476725675.git.lv.zheng@intel.com>
References: <cover.1476725675.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33395 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935162AbcJQTDg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Oct 2016 15:03:36 -0400
Received: by mail-qt0-f193.google.com with SMTP id m5so6536109qtb.0
        for <linux-acpi@vger.kernel.org>; Mon, 17 Oct 2016 12:03:35 -0700 (PDT)
In-Reply-To: <cover.1476725675.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: linux-acpi@vger.kernel.org

From: Bob Moore <robert.moore@intel.com>

ACPICA commit 9f83b34cb172549c20f18663bc7460fb4145a75b

increase loop limit to accomodate faster processors. From 64k loops max
to 1 million.

Link: https://github.com/acpica/acpica/commit/9f83b34c
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/acglobal.h | 2 +-
 include/acpi/acconfig.h        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/acglobal.h b/drivers/acpi/acpica/acglobal.h
index 750fa82..17f7bb8 100644
--- a/drivers/acpi/acpica/acglobal.h
+++ b/drivers/acpi/acpica/acglobal.h
@@ -242,7 +242,7 @@ ACPI_GLOBAL(struct acpi_thread_state *, acpi_gbl_current_walk_list);
 
 /* Maximum number of While() loop iterations before forced abort */
 
-ACPI_GLOBAL(u16, acpi_gbl_max_loop_iterations);
+ACPI_GLOBAL(u32, acpi_gbl_max_loop_iterations);
 
 /* Control method single step flag */
 
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index 12c2882..d25da93 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -146,7 +146,7 @@
 
 /* Maximum number of While() loops before abort */
 
-#define ACPI_MAX_LOOP_COUNT             0xFFFF
+#define ACPI_MAX_LOOP_COUNT             0x000FFFFF
 
 /******************************************************************************
  *
-- 
2.7.4

