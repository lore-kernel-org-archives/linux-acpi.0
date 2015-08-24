From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] nfit, nd_blk: BLK status register is only 32 bits
Date: Mon, 24 Aug 2015 13:02:17 -0400
Message-ID: <x49wpwkbox2.fsf@segfault.boston.devel.redhat.com>
References: <1440109658-29164-1-git-send-email-ross.zwisler@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54709 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753908AbbHXRCT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Aug 2015 13:02:19 -0400
In-Reply-To: <1440109658-29164-1-git-send-email-ross.zwisler@linux.intel.com>
	(Ross Zwisler's message of "Thu, 20 Aug 2015 16:27:38 -0600")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-nvdimm@ml01.01.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

Ross Zwisler <ross.zwisler@linux.intel.com> writes:

> Only read 32 bits for the BLK status register in read_blk_stat().
>
> The format and size of this register is defined in the
> "NVDIMM Driver Writer's guide":
>
> http://pmem.io/documents/NVDIMM_Driver_Writers_Guide.pdf
>
> Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> Reported-by: Nicholas Moulin <nicholas.w.moulin@linux.intel.com>

Looks fine,

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

However, now that you've drawn attention to that code, I'll note that
there is no checking of the pending or retry bits.  In fact,
ACPI_NFIT_CONTROL_BUFFERED isn't even checked upon loading the tables.
Is this on a todo list somewhere?

Cheers,
Jeff

> ---
>  drivers/acpi/nfit.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/nfit.c b/drivers/acpi/nfit.c
> index 7c2638f..8689ee1 100644
> --- a/drivers/acpi/nfit.c
> +++ b/drivers/acpi/nfit.c
> @@ -1009,7 +1009,7 @@ static void wmb_blk(struct nfit_blk *nfit_blk)
>  		wmb_pmem();
>  }
>  
> -static u64 read_blk_stat(struct nfit_blk *nfit_blk, unsigned int bw)
> +static u32 read_blk_stat(struct nfit_blk *nfit_blk, unsigned int bw)
>  {
>  	struct nfit_blk_mmio *mmio = &nfit_blk->mmio[DCR];
>  	u64 offset = nfit_blk->stat_offset + mmio->size * bw;
> @@ -1017,7 +1017,7 @@ static u64 read_blk_stat(struct nfit_blk *nfit_blk, unsigned int bw)
>  	if (mmio->num_lines)
>  		offset = to_interleave_offset(offset, mmio);
>  
> -	return readq(mmio->base + offset);
> +	return readl(mmio->base + offset);
>  }
>  
>  static void write_blk_ctl(struct nfit_blk *nfit_blk, unsigned int bw,
