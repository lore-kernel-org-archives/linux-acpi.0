From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: [PATCH 3/3] RAS, HWPOISON: Fix wrong error recovery status
Date: Tue, 15 Jul 2014 22:34:42 -0400
Message-ID: <1405478082-30757-4-git-send-email-gong.chen@linux.intel.com>
References: <1405478082-30757-1-git-send-email-gong.chen@linux.intel.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1405478082-30757-1-git-send-email-gong.chen@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: tony.luck@intel.com, bp@alien8.de
Cc: linux-acpi@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

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

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
