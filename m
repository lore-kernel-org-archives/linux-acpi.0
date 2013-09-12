From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [RESEND PATCH v2 3/9] x86, dma: Support allocate memory from
 bottom upwards in dma_contiguous_reserve().
Date: Thu, 12 Sep 2013 13:22:39 -0600
Message-ID: <1379013759.13477.12.camel@misato.fc.hp.com>
References: <1378979537-21196-1-git-send-email-tangchen@cn.fujitsu.com>
	 <1378979537-21196-4-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:39985 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab3ILTYd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Sep 2013 15:24:33 -0400
In-Reply-To: <1378979537-21196-4-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: tj@kernel.org, rjw@sisk.pl, lenb@kernel.org, tglx@linutronix.de, mingo@elte.hu, hpa@zytor.com, akpm@linux-foundation.org, trenn@suse.de, yinghai@kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com, laijs@cn.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, izumi.taku@jp.fujitsu.com, mgorman@suse.de, minchan@kernel.org, mina86@mina86.com, gong.chen@linux.intel.com, vasilis.liaskovitis@profitbricks.com, lwoodman@redhat.com, riel@redhat.com, jweiner@redhat.com, prarit@redhat.com, zhangyanfei@cn.fujitsu.com, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-acpi@vger.kernel.org

On Thu, 2013-09-12 at 17:52 +0800, Tang Chen wrote:
> During early boot, if the bottom up mode is set, just
> try allocating bottom up from the end of kernel image,
> and if that fails, do normal top down allocation.
> 
> So in function dma_contiguous_reserve(), we add the
> above logic.
> 
> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
> Reviewed-by: Zhang Yanfei <zhangyanfei@cn.fujitsu.com>
> ---
>  drivers/base/dma-contiguous.c |   17 ++++++++++++++---
>  1 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index 99802d6..aada945 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -228,17 +228,28 @@ int __init dma_contiguous_reserve_area(phys_addr_t size, phys_addr_t base,
>  			goto err;
>  		}
>  	} else {
> +		phys_addr_t addr;
> +
> +		if (memblock_direction_bottom_up()) {
> +			addr = memblock_alloc_bottom_up(
> +						MEMBLOCK_ALLOC_ACCESSIBLE,
> +						limit, size, alignment);
> +			if (addr)
> +				goto success;
> +		}

I am afraid that this version went to a wrong direction.  Allocating
from the bottom up needs to be an internal logic within the memblock
allocator.  It should not require the callers to be aware of the
direction and make a special request.

Thanks,
-Toshi


> +
>  		/*
>  		 * Use __memblock_alloc_base() since
>  		 * memblock_alloc_base() panic()s.
>  		 */
> -		phys_addr_t addr = __memblock_alloc_base(size, alignment, limit);
> +		addr = __memblock_alloc_base(size, alignment, limit);
>  		if (!addr) {
>  			ret = -ENOMEM;
>  			goto err;
> -		} else {
> -			base = addr;
>  		}
> +
> +success:
> +		base = addr;
>  	}
>  
>  	/*


