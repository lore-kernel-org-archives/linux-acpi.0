From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 1/2 v2] x86, MCE: Fix a bug in CMCI handler
Date: Thu, 17 Apr 2014 02:28:35 -0400
Message-ID: <1397716119-6164-2-git-send-email-gong.chen@linux.intel.com>
References: <1397716119-6164-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63268 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbaDQGx7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Apr 2014 02:53:59 -0400
In-Reply-To: <1397716119-6164-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com
Cc: rostedt@goodmis.org, linux-acpi@vger.kernel.org, arozansk@redhat.com, "Chen, Gong" <gong.chen@linux.intel.com>

This bug is introduced by me in commit 27f6c573e0. I forget
to execute put_cpu_var operation after get_cpu_var. Fix it
via this_cpu_write instead of get_cpu_var.

v2 -> v1: Separate cleanup from bug fix.

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/kernel/cpu/mcheck/mce.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
index eeee23f..68317c8 100644
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -598,7 +598,6 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 {
 	struct mce m;
 	int i;
-	unsigned long *v;
 
 	this_cpu_inc(mce_poll_count);
 
@@ -618,8 +617,7 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (!(m.status & MCI_STATUS_VAL))
 			continue;
 
-		v = &get_cpu_var(mce_polled_error);
-		set_bit(0, v);
+		this_cpu_write(mce_polled_error, 1);
 		/*
 		 * Uncorrected or signalled events are handled by the exception
 		 * handler when it is enabled, so don't process those here.
-- 
1.9.0

