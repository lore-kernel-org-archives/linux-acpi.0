From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] ACPI / ARM64: Get configuration base address of ECAM via
 ACPI MCFG table
Date: Tue, 1 Sep 2015 11:19:22 +0100
Message-ID: <20150901101921.GB24809@red-moon>
References: <1440766163-12101-1-git-send-email-dennis.chen@arm.com>
 <20150828143943.GF15924@red-moon>
 <20150831055158.GA14910@arm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59940 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752216AbbIAKTQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 1 Sep 2015 06:19:16 -0400
Content-Disposition: inline
In-Reply-To: <20150831055158.GA14910@arm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dennis Chen <dennis.chen@arm.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>

On Mon, Aug 31, 2015 at 06:51:58AM +0100, Dennis Chen wrote:
> On Fri, Aug 28, 2015 at 03:39:43PM +0100, Lorenzo Pieralisi wrote:
> > Hi Dennis,
> > 
> > You should CC linux-pci@vger.kernel.org and the PCI subsystem
> > maintainer next time.
> >
> >
> 
> Good reminder! Thanks, mate ;-)
>  
> > On Fri, Aug 28, 2015 at 01:49:23PM +0100, Dennis Chen wrote:
> > > This patch will fall back to ACPI MCFG table if _CBA method fails
> > > to get the configuration base address of ECAM. Firmware on ARM
> > > platform uses MCFG table instead of _CBA method. This is needed
> > > to scan the PCIe root complex for ARM SoC.
> > 
> > Code to enumerate PCI with ACPI on ARM64 is under review:
> > 
> > https://lkml.org/lkml/2015/6/8/443
> >
> 
> Oops,seems I am late, just go through the code to scan the root:
> https://lkml.org/lkml/2015/5/26/215
> a little bit complicated, to be honest. Maybe I can have some input then.
>  
> > Having said that, I do not think this patch will be needed,
> > you can't add code in the kernel because it may be needed in
> > the future, I do not see how it can be possibly useful at present
> > on ARM64 unless you pulled some patch dependencies; if that's the
> > case you should have listed them.
> > 
> > This patch can't be review standalone since it has no use in
> > the current kernel (at least for ARM64, it should be tested
> > on x86 though).
> 
> I do have a patch set to enumerate all the downstream devices of
> the PCIe root bridge. With this patch, I can focus on the enabling/fixing
> of the drivers of those devices. As you can imagine, the patch have some 
> redundant codes with PCI/ACPI codes now under x86 directory. It's reasonable 
> to move those arch-agnostic codes to a common place. I am OK to keep
> them pending as private as a test code base for me  
> 
> As for this patch, it's used to get the ecam address from MCFG instead of
> _CBA which x86 is using, see acpi_pci_root_get_mcfg_addr() code.
> So, it's for ARM64 and can be tested with uefi definitely. I'm missing some 
> context here?

No, but as I said this patch is no use standalone (and again it has to
be tested on x86), there is no reason for it to go upstream given the
patch dependencies you mentioned. When the dust settles on the ACPI/PCI
enablement we will have a look at this patch and see if it is still
needed, there is no point in merging it as-is, it serves no purpose
at present.

Lorenzo
