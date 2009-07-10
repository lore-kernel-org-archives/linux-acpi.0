From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 11/12] SFI, PCI: Hook MMCONFIG
Date: Fri, 10 Jul 2009 13:14:57 +0200
Message-ID: <20090710111457.GA3760@elte.hu>
References: <8e4a93858bce74ed3080dd607aa471023f1a2737.1247025117.git.len.brown@intel.com> <24fe646fcbbd9049850de4ac57cf6a67846b38c4.1247025117.git.len.brown@intel.com> <20090710055229.GD22218@elte.hu> <20090710151753.05848348@feng-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:49845 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981AbZGJLPM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Jul 2009 07:15:12 -0400
Content-Disposition: inline
In-Reply-To: <20090710151753.05848348@feng-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Len Brown <lenb@kernel.org>, "x86@kernel.org" <x86@kernel.org>, "sfi-devel@simplefirmware.org" <sfi-devel@simplefirmware.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>


* Feng Tang <feng.tang@intel.com> wrote:

> On Fri, 10 Jul 2009 13:52:29 +0800
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > 
> > > @@ -606,7 +607,9 @@ static void __init __pci_mmcfg_init(int early)
> > >  	}
> > >  
> > >  	if (!known_bridge)
> > > -		acpi_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
> > > +		if (acpi_table_parse(ACPI_SIG_MCFG,
> > > pci_parse_mcfg))
> > > +			sfi_acpi_table_parse(ACPI_SIG_MCFG, NULL,
> > > NULL, 0,
> > > +				pci_parse_mcfg);
> > 
> > Please introduce one common/generic helper:
> > 
> > 		x86_table_parse(ACPI_SIG_MCFG, pci_parse_mcfg);
> > 
> > and do the fallback in that helper. We generally want to try 
> > ACPI first, SFI second. That helper makes it easier to add such 
> > fallback in other places as well, and will de-uglify the above 
> > code as well.
> 
> Should we have a new acpi_sfi.c or .h to contain all these helper 
> functions? I think it is not appropriate to put it to either ACPI 
> or SFI code.

They are of the same family and there's reuse in terms of table 
parsing code, etc. Do you have some nice name that covers both? I 
didnt find any good one beyond the x86_table_*() namespace.

> Also, ACPI and SFI code under arch/x86/kernel have lots of similar 
> code in cpu/io-apic parsing, we thought about extracting these 
> sharable codes out and move them to apic.c/io_apic.c, but don't 
> know if this will uglify current apic/ioapic code? how do you 
> think about it?

it all depends on the patches ... and the APIC enumeration code 
definitely needs cleanups so if you can do it that would be welcome.

	Ingo
