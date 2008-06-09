From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: PNPACPI: use _CRS IRQ descriptor length for _SRS, v2
Date: Mon, 9 Jun 2008 12:51:55 -0600
Message-ID: <200806091251.56347.bjorn.helgaas@hp.com>
References: <200805231629.24421.bjorn.helgaas@hp.com> <200805271053.59654.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:10367 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbYFISwV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jun 2008 14:52:21 -0400
In-Reply-To: <200805271053.59654.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adam Belay <ambx1@neo.rr.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adam M Belay <abelay@mit.edu>, Matthieu Castet <castet.matthieu@free.fr>, Li Shaohua <shaohua.li@intel.com>, Len Brown <lenb@kernel.org>, Tom Jaeger <ThJaeger@gmail.com>, Robert Moore <Robert.Moore@intel.com>, linux-acpi@vger.kernel.org

On Tuesday 27 May 2008 10:53:58 am Bjorn Helgaas wrote:
>     [This fixes a long-standing parport PNPACPI bug (see bugzilla
>     links below).  I think it should go in 2.6.26.
> 
>     This v2 patch removes an unnecessary line pointed out by
>     Tom Jaeger.]

This patch is in -mm, but not in 2.6.26-rc5.  I'd like suggest
again that we put it in for 2.6.26 because it fixes parport
on many machines.

> When configuring the resources of an ACPI device, we first
> evaluate _CRS to get a template of resource descriptors, then
> fill in the specific resource values we want, and finally
> evaluate _SRS to actually configure the device.
> 
> Some resources have optional fields, so the size of encoded
> descriptors varies depending on the specific values.  For
> example, IRQ descriptors can be either two or three bytes long.
> The third byte contains triggering information and can be
> omitted if the IRQ is edge-triggered and active high.
> 
> The BIOS often assumes that IRQ descriptors in the _SRS
> buffer use the same format as those in the _CRS buffer, so
> this patch enforces that constraint.
> 
> The "Start Dependent Function" descriptor also has an optional
> byte, but we don't currently encode those descriptors, so I
> didn't do anything for those.
> 
> I have tested this patch on a Toshiba Portege 4000.  Without
> the patch, parport_pc claims the parallel port only if I use
> "pnpacpi=off".  This patch makes it work with PNPACPI.
> 
> This is an extension of a patch by Tom Jaeger:
>     http://bugzilla.kernel.org/show_bug.cgi?id=9487#c42
> 
> References:
>     http://bugzilla.kernel.org/show_bug.cgi?id=5832 Enabling ACPI Plug and Play in kernels >2.6.9 kills Parallel support
>     http://bugzilla.kernel.org/show_bug.cgi?id=9487 buggy firmware expects four-byte IRQ resource descriptor (was: Serial port disappears after Suspend on Toshiba R25)
>     http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=1d5b285da1893b90507b081664ac27f1a8a3dc5b related ACPICA fix
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> 
> Index: work11/drivers/pnp/pnpacpi/rsparser.c
> ===================================================================
> --- work11.orig/drivers/pnp/pnpacpi/rsparser.c	2008-05-22 13:41:52.000000000 -0600
> +++ work11/drivers/pnp/pnpacpi/rsparser.c	2008-05-27 10:34:32.000000000 -0600
> @@ -742,6 +742,9 @@ static acpi_status pnpacpi_type_resource
>  	if (pnpacpi_supported_resource(res)) {
>  		(*resource)->type = res->type;
>  		(*resource)->length = sizeof(struct acpi_resource);
> +		if (res->type == ACPI_RESOURCE_TYPE_IRQ)
> +			(*resource)->data.irq.descriptor_length =
> +					res->data.irq.descriptor_length;
>  		(*resource)++;
>  	}
>  
> @@ -800,10 +803,12 @@ static void pnpacpi_encode_irq(struct pn
>  	irq->interrupt_count = 1;
>  	irq->interrupts[0] = p->start;
>  
> -	dev_dbg(&dev->dev, "  encode irq %d %s %s %s\n", (int) p->start,
> +	dev_dbg(&dev->dev, "  encode irq %d %s %s %s (%d-byte descriptor)\n",
> +		(int) p->start,
>  		triggering == ACPI_LEVEL_SENSITIVE ? "level" : "edge",
>  		polarity == ACPI_ACTIVE_LOW ? "low" : "high",
> -		irq->sharable == ACPI_SHARED ? "shared" : "exclusive");
> +		irq->sharable == ACPI_SHARED ? "shared" : "exclusive",
> +		irq->descriptor_length);
>  }
>  
>  static void pnpacpi_encode_ext_irq(struct pnp_dev *dev,
> 
> 


