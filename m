From: Len Brown <lenb@kernel.org>
Subject: [PATCH 07/37] Hibernation: Move function prototypes to header
Date: Thu, 31 Jan 2008 23:36:38 -0500
Message-ID: <d7b47cc8a4c8dbb1a4a05f4ee48304fb4a4e0099.1201840183.git.len.brown@intel.com>
References: <1201840628-23136-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:61240 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754474AbYBAEl4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jan 2008 23:41:56 -0500
In-Reply-To: <1201840628-23136-1-git-send-email-lenb@kernel.org>
In-Reply-To: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
References: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>

From: Adrian Bunk <bunk@kernel.org>

This patch moves the prototypes of count_highmem_pages() and
restore_highmem() to kernel/power/power.h

Signed-off-by: Adrian Bunk <bunk@kernel.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 kernel/power/power.h    |    8 ++++++++
 kernel/power/snapshot.c |    1 -
 kernel/power/swsusp.c   |    8 --------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/power/power.h b/kernel/power/power.h
index ef90605..c5321eb 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -180,3 +180,11 @@ static inline int pm_notifier_call_chain(unsigned long val)
 	return (blocking_notifier_call_chain(&pm_chain_head, val, NULL)
 			== NOTIFY_BAD) ? -EINVAL : 0;
 }
+
+#ifdef CONFIG_HIGHMEM
+unsigned int count_highmem_pages(void);
+int restore_highmem(void);
+#else
+static inline unsigned int count_highmem_pages(void) { return 0; }
+static inline int restore_highmem(void) { return 0; }
+#endif
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index c5ce0f3..1ec3ecc 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -872,7 +872,6 @@ unsigned int count_highmem_pages(void)
 }
 #else
 static inline void *saveable_highmem_page(unsigned long pfn) { return NULL; }
-static inline unsigned int count_highmem_pages(void) { return 0; }
 #endif /* CONFIG_HIGHMEM */
 
 /**
diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
index e1722d3..605c536 100644
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -64,14 +64,6 @@ unsigned long image_size = 500 * 1024 * 1024;
 
 int in_suspend __nosavedata = 0;
 
-#ifdef CONFIG_HIGHMEM
-unsigned int count_highmem_pages(void);
-int restore_highmem(void);
-#else
-static inline int restore_highmem(void) { return 0; }
-static inline unsigned int count_highmem_pages(void) { return 0; }
-#endif
-
 /**
  *	The following functions are used for tracing the allocated
  *	swap pages, so that they can be freed in case of an error.
-- 
1.5.4.rc5.16.gc0279

