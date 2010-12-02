From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v3 1/4] printk, Add pr_pfx for library functions
Date: Thu,  2 Dec 2010 16:05:02 +0800
Message-ID: <1291277105-31758-2-git-send-email-ying.huang@intel.com>
References: <1291277105-31758-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291277105-31758-1-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-acpi@vger.kernel.org

For library functions doing printk, the log level and line prefix
usually need to be specified by the caller. So this patch adds
"pr_pfx" to make the life of these library functions easier.

Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 include/linux/printk.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -202,6 +202,13 @@ extern void print_hex_dump_bytes(const c
 #endif
 
 /*
+ * Used by library functions, where log level and line prefix need to
+ * be specifieded by the caller.
+ */
+#define pr_pfx(pfx, fmt, ...) \
+	printk("%s" fmt, pfx, ##__VA_ARGS__)
+
+/*
  * ratelimited messages with local ratelimit_state,
  * no local ratelimit_state used in the !PRINTK case
  */
