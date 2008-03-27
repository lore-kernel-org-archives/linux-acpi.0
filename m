From: Len Brown <lenb@kernel.org>
Subject: Re: linux-next: acpi build breakage
Date: Thu, 27 Mar 2008 01:19:36 -0400
Message-ID: <200803270119.37051.lenb@kernel.org>
References: <20080327142032.432ddb0b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57228 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386AbYC0FUG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Mar 2008 01:20:06 -0400
In-Reply-To: <20080327142032.432ddb0b.sfr@canb.auug.org.au>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-acpi@vger.kernel.org, Bjorn Helgaas <bjorn.helgaas@hp.com>

Thanks,
I've alreday pushed bjorn's updated patch,
so this should be gone on the next pull.

-Len

On Wednesday 26 March 2008, Stephen Rothwell wrote:
> Hi Len,
> 
> Today's linux-next build (x86_64 allmodconfig) produces the following
> errors:
> 
> ERROR: "pnp_get_resource" [sound/oss/sb.ko] undefined!
> ERROR: "pnp_get_resource" [sound/drivers/mpu401/snd-mpu401.ko] undefined!
> ERROR: "pnp_get_resource" [drivers/watchdog/sc1200wdt.ko] undefined!
> ERROR: "pnp_get_resource" [drivers/serial/8250_pnp.ko] undefined!
> ERROR: "pnp_get_resource" [drivers/rtc/rtc-cmos.ko] undefined!
> ERROR: "pnp_get_resource" [drivers/parport/parport_pc.ko] undefined!
> ERROR: "pnp_get_resource" [drivers/net/sb1000.ko] undefined!
> ERROR: "pnp_get_resource" [drivers/net/irda/smsc-ircc2.ko] undefined!
> ERROR: "pnp_get_resource" [drivers/net/irda/nsc-ircc.ko] undefined!
> ERROR: "pnp_get_resource" [drivers/mmc/host/wbsd.ko] undefined!
> ERROR: "pnp_get_resource" [drivers/input/serio/i8042.ko] undefined!
> ERROR: "pnp_get_resource" [drivers/input/gameport/ns558.ko] undefined!
> ERROR: "pnp_get_resource" [drivers/ide/ide-pnp.ko] undefined!
> ERROR: "pnp_get_resource" [drivers/char/tpm/tpm_tis.ko] undefined!
> ERROR: "pnp_get_resource" [drivers/char/tpm/tpm_infineon.ko] undefined!
> 
> I added the following patch.  It should really be merged back into commit
> 6d889e6c99155449934449ef6e2f87747eb4487e ("PNP: add pnp_get_resource()
> interface").
> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
> 
> >From 99b26196cf3fd1c66047376bfe82c05fa1ff2a85 Mon Sep 17 00:00:00 2001
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Thu, 27 Mar 2008 14:13:37 +1100
> Subject: [PATCH] Export pnp_get_resource
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/pnp/resource.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
> index 9911b92..36487ae 100644
> --- a/drivers/pnp/resource.c
> +++ b/drivers/pnp/resource.c
> @@ -613,6 +613,7 @@ struct resource *pnp_get_resource(struct pnp_dev *dev,
>  	}
>  	return NULL;
>  }
> +EXPORT_SYMBOL_GPL(pnp_get_resource);
>  
>  /* format is: pnp_reserve_irq=irq1[,irq2] .... */
>  static int __init pnp_setup_reserve_irq(char *str)


