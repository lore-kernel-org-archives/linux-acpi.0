From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 2/2] RAS, HWPOISON: Fix wrong error recovery status
Date: Mon, 28 Jul 2014 02:51:00 -0400
Message-ID: <1406530260-26078-3-git-send-email-gong.chen@linux.intel.com>
References: <1406530260-26078-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:19979 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbaG1HWP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Jul 2014 03:22:15 -0400
In-Reply-To: <1406530260-26078-1-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, n-horiguchi@ah.jp.nec.com, bp@alien8.de
Cc: linux-acpi@vger.kernel.org, linux-mm@kvack.org, "Chen, Gong" <gong.chen@linux.intel.com>

When Uncorrected error happens, if the poisoned page is referenced
by more than one user after error recovery, the recovery is not
successful. But currently the display result is wrong.
Before this patch:

MCE 0x44e336: dirty mlocked LRU page recovery: Recovered
MCE 0x44e336: dirty mlocked LRU page still referenced by 1 users
mce: Memory error not recovered

After this patch:

MCE 0x44e336: dirty mlocked LRU page recovery: Failed
MCE 0x44e336: dirty mlocked LRU page still referenced by 1 users
mce: Memory error not recovered

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 mm/memory-failure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index c6399e3..2985861 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -860,7 +860,6 @@ static int page_action(struct page_state *ps, struct page *p,
 	int count;
 
 	result = ps->action(p, pfn);
-	action_result(pfn, ps->msg, result);
 
 	count = page_count(p) - 1;
 	if (ps->action == me_swapcache_dirty && result == DELAYED)
@@ -871,6 +870,7 @@ static int page_action(struct page_state *ps, struct page *p,
 		       pfn, ps->msg, count);
 		result = FAILED;
 	}
+	action_result(pfn, ps->msg, result);
 
 	/* Could do more checks here if page looks ok */
 	/*
-- 
2.0.0.rc2

