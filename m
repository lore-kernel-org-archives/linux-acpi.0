From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/94] x86 hibernate: Mark ACPI NVS memory region at startup
Date: Fri, 09 Jan 2009 04:26:09 -0500
Message-ID: <b69edc76539be6a4aa39a22f85365fd4a3b3b9d2.1231492607.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:51416 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbZAIJ1t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:27:49 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700A2S6ABW9K9@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:27:48 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
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
1.5.6.6

