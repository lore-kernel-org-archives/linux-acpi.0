From: John Keller <jpk@sgi.com>
Subject: Re: [PATCH] x86: Allow MMCONFIG above 4GB on x86_64
Date: Fri, 18 Jul 2008 08:02:48 -0500 (CDT)
Message-ID: <200807181302.m6ID2nCX447826@fcbayern.americas.sgi.com>
References: <20080718123858.GR6875@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.171.29]:60761 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751465AbYGRNCy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jul 2008 09:02:54 -0400
In-Reply-To: <20080718123858.GR6875@elte.hu> from "Ingo Molnar" at Jul 18, 2008 02:38:58 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: John Keller <jpk@sgi.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, takayoshi.kochi@gmail.com, Yinghai Lu <yhlu.kernel@gmail.com>, Jesse Barnes <jbarnes@virtuousgeek.org>

> 
> 
> * John Keller <jpk@sgi.com> wrote:
> 
> > SGI UV will have MMCFG base addresses that are greater than 4GB (32 
> > bits).
> 
> > +++ linux-2.6/arch/x86/kernel/acpi/boot.c	2008-07-09 15:25:32.000000000 -0500
> > @@ -200,6 +200,7 @@ int __init acpi_parse_mcfg(struct acpi_t
> >  	}
> >  
> >  	memcpy(pci_mmcfg_config, &mcfg[1], config_size);
> > +#ifndef CONFIG_X86_64
> >  	for (i = 0; i < pci_mmcfg_config_num; ++i) {
> >  		if (pci_mmcfg_config[i].address > 0xFFFFFFFF) {
> >  			printk(KERN_ERR PREFIX
> > @@ -209,6 +210,7 @@ int __init acpi_parse_mcfg(struct acpi_t
> >  			return -ENODEV;
> >  		}
> >  	}
> > +#endif
> 
> hm. If then it should be enabled very carefully and initially probably 
> on a per system (i.e. DMI driven whitelist) basis.
> 
> 	Ingo

I've also posted a revised patch that is platform specific.

http://marc.info/?l=linux-acpi&m=121615159014404&w=2

John
