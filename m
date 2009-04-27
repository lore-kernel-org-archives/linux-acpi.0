From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] x86/pci: do assign root bus res if _CRS is used
Date: Mon, 27 Apr 2009 13:44:01 -0600
Message-ID: <200904271344.04099.bjorn.helgaas@hp.com>
References: <49ED22EC.2040204@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:19145 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754899AbZD0ToL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Apr 2009 15:44:11 -0400
In-Reply-To: <49ED22EC.2040204@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, Gary Hade <garyhade@us.ibm.com>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>

On Monday 20 April 2009 07:35:40 pm Yinghai Lu wrote:
> it wil be overwriten later if _CRS is used, so don't bother to set it.
> 
> [ Impact: cleanup ]
> 
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> 
> ---
>  arch/x86/pci/amd_bus.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> Index: linux-2.6/arch/x86/pci/amd_bus.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/pci/amd_bus.c
> +++ linux-2.6/arch/x86/pci/amd_bus.c
> @@ -100,6 +100,10 @@ void x86_pci_root_bus_res_quirks(struct
>  	int j;
>  	struct pci_root_info *info;
>  
> +	/* don't go for it if _CRS is used */
> +	if (pci_probe & PCI_USE__CRS)
> +		return;
> +
>  	/* if only one root bus, don't need to anything */
>  	if (pci_root_num < 2)
>  		return;

This isn't a comment on this patch per se.

I am concerned about the fact that "pci=use_crs" is not the default.
>From the changelog of 62f420f8282, it sounds like you have to boot an
IBM x3850 with "pci=use_crs" to make hot-plug work, even though ACPI
tells us everything we need to know.  That's backwards.

We shouldn't need an option to tell Linux that the firmware is
trustworthy.  We should have an option to *ignore* it for the times
when we trip over something broken and haven't figured out a way to
work around it yet.

Bjorn
