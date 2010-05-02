From: Pavel Kysilka <goldenfish@linuxsoft.cz>
Subject: Re: linux pnp bug - report
Date: Sun, 02 May 2010 19:51:05 +0200
Message-ID: <1272822665.2801.9.camel@goldenfish.development.local>
References: <1269373637.3113.12.camel@goldenfish.development.local>
	 <201003251611.41000.bjorn.helgaas@hp.com>
	 <1269716956.2355.5.camel@goldenfish.development.local>
	 <201004281457.59128.bjorn.helgaas@hp.com>
	 <1272655284.3607.6.camel@goldenfish.development.local>
	 <1272686583.28149.53.camel@dc7800.home>
Reply-To: goldenfish@linuxsoft.cz
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-nqqwgbtYR6YIH+AjpUEv"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from butterfly.cecak.cz ([82.208.29.33]:39220 "EHLO
	butterfly.cecak.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758428Ab0EBSAs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 May 2010 14:00:48 -0400
In-Reply-To: <1272686583.28149.53.camel@dc7800.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org


--=-nqqwgbtYR6YIH+AjpUEv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2010-04-30 at 22:03 -0600, Bjorn Helgaas wrote:
> Pavel wrote:
> > i am playing with old PIII computer (HP Vectra VE) and ISA soundcards.
> > Soundcars are PNP(yamaha,opti,ess,...) and no PNP (multisound).
> > Machine
> > is old, but ACPI compilant - old BIOS.
> > 
> > Computer booting OK. PNP0 devices allocate resources OK, but PNP1
> > devices (one ISA slot) not. PNP soundcard driver is not correctly
> > loaded
> > - soundcard device not created.
> 
> I think this is a regression, i.e., 2.6.33 worked, but 2.6.34-rc6 does
> not.  Right?  Even worse, I think it's my fault :-(  If this is a
> regression, we should open a bugzilla at http://bugzilla.kernel.org and
> assign it to me.
2.6.33 kernel working without problem.

> 
> Here's the problem (I think):
> 
>   pnp 00:01: parse allocated resources
>   pnp 00:01:   add [bus 00-ff flags 0x1000]
>   pnp 00:01:   add [io  0x0000-0x0cf7 flags 0x200101]
>   pnp 00:01: Plug and Play ACPI device, IDs PNP0a03 (active)
> 
> This PNP0a03 PCI host bridge has a window [io  0x0000-0x0cf7] that is
> forwarded to the PCI bridge.  This is perfectly normal, but in 2.6.33,
> PNPACPI ignored that window, so it didn't appear as a PNP resource of
> the bridge.
> 
>   cmi8330 01:01.00: pnp_assign_resources, try dependent set 0
>   cmi8330 01:01.00: trying to assign [??? 0x00000530-0x00000537 flags 0x40000001]
>   cmi8330 01:01.00: check whether [??? 0x00000530-0x00000537 flags 0x40000001] is available
>   cmi8330 01:01.00: conflict with 00:01 resource 1 [io  0x0000-0x0cf7 flags 0x200101]
>   cmi8330 01:01.00:   couldn't assign io 0 (min 0x530 max 0x530)
> 
> Now we come along and try to assign [io  0x0530-0x0537] to the cmi8330
> device.  The last piece of pnp_check_port() checks it against all
> resources of other PNP devices, including the PNP0a03 host bridge
> window.  We should ignore windows, because the bridge doesn't *consume*
> that range, it only *forwards* it, so it's still available for devices
> to use.
> 
> I'd like to rework PNP resource management to make it more similar to
> PCI's, or even integrate them somehow.  But we only have time for the
> most minimal fix for 2.6.34.  Can you try the patch below, please?
Yes, with your patch is soundcard working. More in attachment.
> 
> Bjorn

    Pavel

> 
> 
> diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
> index 2e54e6a..e3446ab 100644
> --- a/drivers/pnp/resource.c
> +++ b/drivers/pnp/resource.c
> @@ -211,6 +211,8 @@ int pnp_check_port(struct pnp_dev *dev, struct resource *res)
>  			if (tres->flags & IORESOURCE_IO) {
>  				if (cannot_compare(tres->flags))
>  					continue;
> +				if (tres->flags & IORESOURCE_WINDOW)
> +					continue;
>  				tport = &tres->start;
>  				tend = &tres->end;
>  				if (ranged_conflict(port, end, tport, tend))
> @@ -271,6 +273,8 @@ int pnp_check_mem(struct pnp_dev *dev, struct resource *res)
>  			if (tres->flags & IORESOURCE_MEM) {
>  				if (cannot_compare(tres->flags))
>  					continue;
> +				if (tres->flags & IORESOURCE_WINDOW)
> +					continue;
>  				taddr = &tres->start;
>  				tend = &tres->end;
>  				if (ranged_conflict(addr, end, taddr, tend))
> 
> 


--=-nqqwgbtYR6YIH+AjpUEv
Content-Type: application/x-gzip; name="dmesg.gz"
Content-Disposition: attachment; filename="dmesg.gz"
Content-Transfer-Encoding: base64

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


--=-nqqwgbtYR6YIH+AjpUEv--

