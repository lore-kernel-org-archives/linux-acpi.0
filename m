From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/10] x86 hibernate: Mark ACPI NVS memory region at startup
Date: Thu, 06 Nov 2008 23:45:29 -0500
Message-ID: <cb6a239a58c2bd34d58239899de8068ace83d5bd.1226032943.git.len.brown@intel.com>
References: <1226033132-16034-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:44620 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbYKGEpf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Nov 2008 23:45:35 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9Y00L3T57YP0O0@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 06 Nov 2008 22:45:35 -0600 (CST)
In-reply-to: <1226033132-16034-1-git-send-email-lenb@kernel.org>
In-reply-to: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com>
References: <007e7d616a5d1c2e16ad627d03f8b97799445e71.1226032943.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Rafael J. Wysocki <rjw@sisk.pl>

Introduce new initcall for marking the ACPI NVS memory at startup, so
that it can be saved/restored during hibernation/resume.

Based on a patch by Zhang Rui.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/e820.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 7aafeb5..74c6a21 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -665,6 +665,27 @@ void __init e820_mark_nosave_regions(unsigned long limit_pfn)
 }
 #endif
 
+#ifdef CONFIG_HIBERNATION
+/**
+ * Mark ACPI NVS memory region, so that we can save/restore it during
+ * hibernation and the subsequent resume.
+ */
+static int __init e820_mark_nvs_memory(void)
+{
+	int i;
+
+	for (i = 0; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+
+		if (ei->type == E820_NVS)
+			hibernate_nvs_register(ei->addr, ei->size);
+	}
+
+	return 0;
+}
+core_initcall(e820_mark_nvs_memory);
+#endif
+
 /*
  * Early reserved memory areas.
  */
-- 
1.5.6.5

