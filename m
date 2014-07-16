From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Subject: Re: [PATCH 3/3] RAS, HWPOISON: Fix wrong error recovery status
Date: Wed, 16 Jul 2014 15:57:45 -0400
Message-ID: <20140716195745.GC8524@nhori.redhat.com>
References: <1405478082-30757-1-git-send-email-gong.chen@linux.intel.com>
 <1405478082-30757-4-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45545 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751122AbaGPT6Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2014 15:58:16 -0400
Content-Disposition: inline
In-Reply-To: <1405478082-30757-4-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, bp@alien8.de, linux-acpi@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org

On Tue, Jul 15, 2014 at 10:34:42PM -0400, Chen, Gong wrote:
> When Uncorrected error happens, if the poisoned page is referenced
> by more than one user after error recovery, the recovery is not
> successful. But currently the display result is wrong.
> Before this patch:
> 
> MCE 0x44e336: dirty mlocked LRU page recovery: Recovered
> MCE 0x44e336: dirty mlocked LRU page still referenced by 1 users
> mce: Memory error not recovered
> 
> After this patch:
> 
> MCE 0x44e336: dirty mlocked LRU page recovery: Failed
> MCE 0x44e336: dirty mlocked LRU page still referenced by 1 users
> mce: Memory error not recovered
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>

Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

> ---
>  mm/memory-failure.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index c6399e3..2985861 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -860,7 +860,6 @@ static int page_action(struct page_state *ps, struct page *p,
>  	int count;
>  
>  	result = ps->action(p, pfn);
> -	action_result(pfn, ps->msg, result);
>  
>  	count = page_count(p) - 1;
>  	if (ps->action == me_swapcache_dirty && result == DELAYED)
> @@ -871,6 +870,7 @@ static int page_action(struct page_state *ps, struct page *p,
>  		       pfn, ps->msg, count);
>  		result = FAILED;
>  	}
> +	action_result(pfn, ps->msg, result);
>  
>  	/* Could do more checks here if page looks ok */
>  	/*
> -- 
> 2.0.0.rc2
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
> 
