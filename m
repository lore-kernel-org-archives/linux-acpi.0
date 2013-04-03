From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
Date: Wed, 03 Apr 2013 13:00:39 +0200
Message-ID: <4565620.kVgyMAxUbs@vostro.rjw.lan>
References: <2282655.IicBMMa6jN@vostro.rjw.lan> <5030643.tE4LAX0txW@vostro.rjw.lan> <CAErSpo6VS6obMfsnGz9KHQup8CdKBBR=ezVsEJp2-tas=vMJGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:50655 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761846Ab3DCKxE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Apr 2013 06:53:04 -0400
In-Reply-To: <CAErSpo6VS6obMfsnGz9KHQup8CdKBBR=ezVsEJp2-tas=vMJGg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, huang ying <huang.ying.caritas@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Sarah Sharp <sarah.a.sharp@linux.intel.com>

On Tuesday, April 02, 2013 05:58:42 PM Bjorn Helgaas wrote:
> On Tue, Apr 2, 2013 at 4:49 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Tuesday, April 02, 2013 10:30:54 AM Bjorn Helgaas wrote:
> >> On Tue, Apr 2, 2013 at 9:02 AM, Martin Mokrejs
> >> <mmokrejs@fold.natur.cuni.cz> wrote:
> >> > Hi Ying,
> >> >
> >> > huang ying wrote:
> >>
> >> >> And please give me the full dmesg for boot and incremental dmesg for
> >> >> operations.
> >> >
> >> >
> >> > The incremental bits here, the full dmesg will send only directly to your email, due to its size.
> >>
> >> Is there a bugzilla for this issue?  Please attach the complete dmesg
> >> there or somewhere similar so we can all benefit.
> >>
> >> I think we have two problems that may be relevant to this discussion.
> >>
> >> 1) The _OSC "PCI Express Capability Structure control" bit.  I don't
> >> think Linux pays attention to whether the BIOS has granted us control
> >> over the capability, so we may do things to it that the BIOS doesn't
> >> expect.
> >
> > Yes, it does, as far as I can say.
> 
> Let me expand on this to see if we're talking about the same thing.
> I'm looking at Tables 6-149 and 6-150 in ACPI spec 5.0, and I
> interpret them as saying the OS should not perform any configuration
> in the PCI Express, VC, Power Budgeting, AER, or Serial Number
> capabilities unless the BIOS grants "PCI Express Capability Structure
> control."
> 
> I see the code in acpi_pci_root_add() that runs _OSC with
> OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL in flags, but I don't see
> anything that uses the result to decide whether we can write to the
> Device Control, Link Control, Slot Control, etc., registers in the
> capability, or to the other extended capabilities.  (ASPM is an
> exception -- we *do* call pcie_no_aspm(), and maybe that keeps us from
> touching the ASPM part of Link Control.)
> 
> I haven't looked deeply enough to identify a problem; it's just
> something that worries me.

That actually is more convoluted.  Because we pass
OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL to acpi_pci_osc_control_set() as the
minimum requirement, it won't request any of the other PCIe flags without it.
This causes those flags to be unset in root->osc_control_set and then
*srv_mask from pcie_port_acpi_setup() will always be 0, in which case no native
PCIe port services will be used.

Of course, whether this is sufficient or not is a good question.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
