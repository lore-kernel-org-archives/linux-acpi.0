From: Yinghai Lu <yhlu.kernel@gmail.com>
Subject: [PATCH 4/7] mm: print out meminit for memmap
Date: Wed, 24 Sep 2008 19:04:34 -0700
Message-ID: <1222308277-10984-4-git-send-email-yhlu.kernel@gmail.com>
References: <1222308277-10984-1-git-send-email-yhlu.kernel@gmail.com>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1222308277-10984-1-git-send-email-yhlu.kernel@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yhlu.kernel@gmail.com>
List-Id: linux-acpi@vger.kernel.org

Signed-off-by: Yinghai Lu <yhlu.kernel@gmail.com>
---
 mm/page_alloc.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e293c58..db30af6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3425,8 +3425,8 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat,
 			PAGE_ALIGN(size * sizeof(struct page)) >> PAGE_SHIFT;
 		if (realsize >= memmap_pages) {
 			realsize -= memmap_pages;
-			mminit_dprintk(MMINIT_TRACE, "memmap_init",
-				"%s zone: %lu pages used for memmap\n",
+			printk(KERN_DEBUG
+				"  %s zone: %lu pages used for memmap\n",
 				zone_names[j], memmap_pages);
 		} else
 			printk(KERN_WARNING
@@ -3436,8 +3436,7 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat,
 		/* Account for reserved pages */
 		if (j == 0 && realsize > dma_reserve) {
 			realsize -= dma_reserve;
-			mminit_dprintk(MMINIT_TRACE, "memmap_init",
-					"%s zone: %lu pages reserved\n",
+			printk(KERN_DEBUG "  %s zone: %lu pages reserved\n",
 					zone_names[0], dma_reserve);
 		}
 
-- 
1.5.6
