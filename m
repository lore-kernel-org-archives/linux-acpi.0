From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: ACPI device using sub-resource of PCI device
Date: Wed, 20 Jul 2016 14:35:43 -0500
Message-ID: <20160720193543.GA4186@localhost>
References: <CAE2855tofJV=HV2dYuC+1=pi2mb942zrRF7f0+wqxPPay44RGA@mail.gmail.com>
 <CAJZ5v0hh1ve=w590D4XncheNVsrmr7f6k1msdr+dzT4UoUa+JQ@mail.gmail.com>
 <CAE2855vrhS7gKGFWEjZy-Hp2S8fNuJskG=WWDSuiBLhq_tDh8A@mail.gmail.com>
 <CAE2855uR=wkxb2xzM4OcG1czffrBXR=1RX8Ms0AfVJ8hzDnUjQ@mail.gmail.com>
 <CAE2855vfhaCVGg-6mBWcU0tQ8akyiAhjv5SrD6xoaj1SbwETDA@mail.gmail.com>
 <CAE2855t5M2=OVXTBfosdNjqg6jUpM-PK02eP6KHC82eKk71-4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43094 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751838AbcGTTfs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Jul 2016 15:35:48 -0400
Content-Disposition: inline
In-Reply-To: <CAE2855t5M2=OVXTBfosdNjqg6jUpM-PK02eP6KHC82eKk71-4w@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Durbin <adurbin@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Tue, Jun 28, 2016 at 09:41:19PM -0700, Aaron Durbin wrote:
> On Fri, Jun 24, 2016 at 12:34 PM, Aaron Durbin <adurbin@google.com> wrote:
> > On Tue, Jun 14, 2016 at 12:04 PM, Aaron Durbin <adurbin@google.com> wrote:
> >> On Wed, May 18, 2016 at 3:32 PM, Aaron Durbin <adurbin@google.com> wrote:
> >>> On Wed, May 18, 2016 at 4:25 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>>> On Wed, May 18, 2016 at 5:54 PM, Aaron Durbin <adurbin@google.com> wrote:
> >>>>> Hi,
> >>>>>
> >>>>> We're currently running into a problem of resource conflicts with a
> >>>>> PCI device and ACPI devices.
> >>>>>
> >>>>> [    0.243534] pci 0000:00:0d.0: can't claim BAR 0 [mem
> >>>>> 0xd0000000-0xd0ffffff 64bit]: address conflict with INT3452:03 [mem
> >>>>> 0xd0c00000-0xd0c03fff]
> >>>>>
> >>>>> The PCI BAR covers a large amount mmio resources, however, there are
> >>>>> ACPI devices with their own HID (for probing) which uses resources
> >>>>> that are a subset of the PCI BAR.
> >>>>>
> >>>>> Short of re-structuring the linux driver is there anything that can be
> >>>>> done with ASL to properly have the ACPI device use a sub-resource of
> >>>>> the PCI device during the ACPI/PCI probing?
> >>>>
> >>>> Do you have an ACPI device object corresponding to the PCI device?
> >>>
> >>> I've been debugging this by proxy, and I did request that test. The
> >>> following is the overall structure:
> >>>
> >>> scope (\_SB.PCI0) {
> >>>
> >>> Device (P2S)
> >>> {
> >>>         Name (_ADR, 0x000D0000)
> >>>         Device (GPO0)
> >>>         {
> >>>                 Name (_ADR, 0)
> >>>                 Name (_HID, "INT3452")
> >>>                 Name (_CID, "INT3452")
> >>>         }
> >>> }
> >>> }
> >>>
> >>> There are _STA methods in both Devices. The GP0 device has a _CRS
> >>> method which just returns a ResourceTemplate which is filled in with
> >>> static values. The PCI bar is at a fixed address from the firmware
> >>> which allows the fixed calculations. However there is no specific
> >>> reference to the P2S device's resources proper -- only the parent
> >>> child relationship within the ASL. I'm not sure how to directly say "I
> >>> want this sub-region of this other device's resource for my resource."
> >>> That seems like the right thing, but it's not clear if that's implied
> >>> by hierarchy of the devices.
> >>>
> >>> Lastly, if it helps, the kernel being used is based on v4.4 (no core
> >>> patches on top).
> >>>
> >>
> >> Hi Rafael,
> >>
> >> I haven't tried a newer kernel yet, but are you of the opinion that
> >> having the Devices as parent-child within the ASL should work? I'm
> >> wondering if there's already a patch in newer kernels that doesn't
> >> report the conflict and works as expected once there are child Devices
> >> under the P2S device.
> >>
> >
> > I've been looking at this more closely. A child ACPI device under a
> > ACPI PCI device doesn't change the resource conflict even when a _CRS
> > method is added to the ACPI PCI device.  Below is my sleuthing which
> > is probably not a surprise to anyone here, but please correct me where
> > I am wrong.
> >
> > acpi_init() and pci_subsys_init() are both subsys_initcalls during
> > boot up. I'm not sure if the ordering is dumb luck or not, but
> > acpi_init() is called prior to pci_subsys_init(). The conflict error
> > is spit out from pcibios_resource_survey() by way of pci_subsys_init()
> >  subsys_initcall. However, the PCI device scanning is kicked off prior
> > to this through acpi_scan_init() by way of acpi_init()
> > subsys_initcall.  The conflict error occurs because there's already
> > the child ACPI device in the resource tree. I'm not sure when/where
> > those ACPI devices' resources are added, but clearly they are sitting
> > in there since the conflict was found.

I think the acpi_init()/pci_subsys_init() ordering is correct.  The
ACPI namespace is primary.  A PCI hierarchy originates at a PCI host
bridge in the ACPI namespace, so we should enumerate the ACPI
namespace first, and when we find a PCI host bridge, we should
enumerate the PCI devices below it.

That said, I think it is correct mostly by accident and it would be
nice if it were more explicit.

> > Somewhere along the way a PCI device from a scan is linked with the
> > ACPI device for that same PCI device in sysfs.  This is with me
> > putting a _HID and _CID in the PCI ACPI device.
> > # readlink -f /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/INT5A92:00/physical_node
> > /sys/devices/pci0000:00/0000:00:0d.0
> > # readlink -f /sys/devices/pci0000\:00/0000\:00\:0d.0/firmware_node/
> > /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/INT5A92:00
> >
> > So the hierarchy is known eventually, but it's clearly not honored
> > when adding resources. The current ACPI support doesn't handle
> > PciBarTarget which initially sounds (from ACPI spec) like the way to
> > go for referencing a resource in a PCI device from an ACPI device.

Yes, I think PCIBARTarget looks like the right way to do this.  It
doesn't *seem* like it'd be that hard to implement; have you looked
into that at all?

Without PCIBARTarget, the AML contains fixed register addresses, so it
will break if Linux reassigns the BAR.

> > So
> > that's out of the question currently, but maybe someone has a patch
> > for that? I don't think reordering the acpi_init() and
> > pci_subsys_init() would do anything different except change which
> > device discovers the conflict.
> >
> > Is there a way to honor the ACPI device hierarchy during resource
> > addition for the PCI devices? The conflict is found because of the
> > presence of a child device claiming resources through _CRS.
> > Alternatively, is there a good way to defer the probing of an ACPI
> > device until one knows PCI resources have been added?
> >
> > Any insights would be very helpful. Thank you.
> 
> I stumbled upon the hierarchy connection. That's all handled with the
> platform_notify() end of things when device_add() is done on the pci
> device. I was thinking we could take advantage of this when adding
> resources, but a struct resource has no struct device. It's just a
> name description for the resource at hand. However, platform devices
> are added when the ACPI tree is parsed along with adding the resources
> associated with them (PciBarTarget would be helpful here) so those
> resources are sitting in the resource tree when PCI BARs are added.
> 
> The following suggestion is sort of hacky, but it's the best I could
> come up with provided the currently supported infrastructure. In
> pci_claim_resource() do request_resource_conflict() as before. If it
> fails do the following: 1. check if the device has an ACPI companion.
> 2. For any children hanging off the ACPI companion device. check if
> that device's name matches the conflict resource's name. 3. If so,
> insert_resource_conflict() to place the BAR within the tree itself.

I think the best solution would be to implement PCIBARTarget, but if
that's impossible, this seems like a plausible workaround.

I don't know if the conflict would necessarily have to be with the
ACPI companion itself.  It seems like you could have some hierarchy of
ACPI devices where the leaf conflicts with a PCI BAR.  Maybe if a
resource of *any* ACPI device below a PCI host bridge conflicts with a
PCI BAR, we should insert the PCI BAR as a parent?

And since moving that BAR would break the AML, we should probably mark
the BAR as IORESOURCE_PCI_FIXED.

Bjorn
