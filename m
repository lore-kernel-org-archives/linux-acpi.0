From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] HPET: handle multiple ACPI EXTENDED_IRQ resources
Date: Mon, 13 Feb 2006 14:55:18 -0700
Message-ID: <200602131455.18254.bjorn.helgaas@hp.com>
References: <200602071650.27379.bjorn.helgaas@hp.com> <200602131424.28369.bjorn.helgaas@hp.com> <20060213134913.13352735.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atlrel7.hp.com ([156.153.255.213]:8358 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S964870AbWBMVzY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Feb 2006 16:55:24 -0500
In-Reply-To: <20060213134913.13352735.akpm@osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: bob.picco@hp.com, robert.picco@hp.com, venkatesh.pallipadi@intel.com, linux-acpi@vger.kernel.org, len.brown@intel.com, ambx1@neo.rr.com, rdunlap@xenotime.net

On Monday 13 February 2006 14:49, Andrew Morton wrote:
> Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> >
> >  Andrew, I know it's late in the 2.6.16 cycle, but it would be really
> >  nice if this patch made it.  Without it, HPETs on new HP boxes don't
> >  work, so we're going to have to get it in the distros some way or
> >  another.
> 
> OK..
> 
> What about hpet-fix-acpi-memory-range-length-handling.patch?

The range length patch has no functional impact on any machine I
know about; it's just a cleanup/align-with-spec thing.  Definitely
post-2.6.16 material.

> From: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> ACPI address space descriptors contain _MIN, _MAX, and _LEN.  _MIN and _MAX
> are the bounds within which the region can be moved (this is clarified in
> Table 6-38 of the ACPI 3.0 spec).  We should use _LEN to determine the size
> of the region, not _MAX - _MIN + 1.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  drivers/char/hpet.c |    5 +----
>  1 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff -puN drivers/char/hpet.c~hpet-fix-acpi-memory-range-length-handling drivers/char/hpet.c
> --- 25/drivers/char/hpet.c~hpet-fix-acpi-memory-range-length-handling	Tue Feb  7 15:47:01 2006
> +++ 25-akpm/drivers/char/hpet.c	Tue Feb  7 15:47:01 2006
> @@ -925,11 +925,8 @@ static acpi_status hpet_resources(struct
>  	status = acpi_resource_to_address64(res, &addr);
>  
>  	if (ACPI_SUCCESS(status)) {
> -		unsigned long size;
> -
> -		size = addr.maximum - addr.minimum + 1;
>  		hdp->hd_phys_address = addr.minimum;
> -		hdp->hd_address = ioremap(addr.minimum, size);
> +		hdp->hd_address = ioremap(addr.minimum, addr.address_length);
>  
>  		if (hpet_is_known(hdp)) {
>  			printk(KERN_DEBUG "%s: 0x%lx is busy\n",
> _
> 
> 
> (It's hard for me to judge when people don't describe what the impact of
> the problem is, so thanks for the poke).
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
