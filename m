From: Aaron Durbin <adurbin@google.com>
Subject: Re: ACPI device using sub-resource of PCI device
Date: Wed, 20 Jul 2016 17:06:24 -0500
Message-ID: <CAE2855scKYvgqTvCtZBZ06GwS1CQTXCe5DyjLF0jGjeMJcEXAw@mail.gmail.com>
References: <CAE2855tofJV=HV2dYuC+1=pi2mb942zrRF7f0+wqxPPay44RGA@mail.gmail.com>
 <CAJZ5v0hh1ve=w590D4XncheNVsrmr7f6k1msdr+dzT4UoUa+JQ@mail.gmail.com>
 <CAE2855vrhS7gKGFWEjZy-Hp2S8fNuJskG=WWDSuiBLhq_tDh8A@mail.gmail.com>
 <CAE2855uR=wkxb2xzM4OcG1czffrBXR=1RX8Ms0AfVJ8hzDnUjQ@mail.gmail.com>
 <CAE2855vfhaCVGg-6mBWcU0tQ8akyiAhjv5SrD6xoaj1SbwETDA@mail.gmail.com>
 <CAE2855t5M2=OVXTBfosdNjqg6jUpM-PK02eP6KHC82eKk71-4w@mail.gmail.com> <20160720193543.GA4186@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:34704 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808AbcGTWG0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 20 Jul 2016 18:06:26 -0400
Received: by mail-io0-f177.google.com with SMTP id q83so60235564iod.1
        for <linux-acpi@vger.kernel.org>; Wed, 20 Jul 2016 15:06:26 -0700 (PDT)
In-Reply-To: <20160720193543.GA4186@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, Jul 20, 2016 at 2:35 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Jun 28, 2016 at 09:41:19PM -0700, Aaron Durbin wrote:
>> On Fri, Jun 24, 2016 at 12:34 PM, Aaron Durbin <adurbin@google.com> wrote:
>> > On Tue, Jun 14, 2016 at 12:04 PM, Aaron Durbin <adurbin@google.com> wrote:
>> >> On Wed, May 18, 2016 at 3:32 PM, Aaron Durbin <adurbin@google.com> wrote:
>> >>> On Wed, May 18, 2016 at 4:25 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> >>>> On Wed, May 18, 2016 at 5:54 PM, Aaron Durbin <adurbin@google.com> wrote:
>> >>>>> Hi,
>> >>>>>
>> >>>>> We're currently running into a problem of resource conflicts with a
>> >>>>> PCI device and ACPI devices.
>> >>>>>
>> >>>>> [    0.243534] pci 0000:00:0d.0: can't claim BAR 0 [mem
>> >>>>> 0xd0000000-0xd0ffffff 64bit]: address conflict with INT3452:03 [mem
>> >>>>> 0xd0c00000-0xd0c03fff]
>> >>>>>
>> >>>>> The PCI BAR covers a large amount mmio resources, however, there are
>> >>>>> ACPI devices with their own HID (for probing) which uses resources
>> >>>>> that are a subset of the PCI BAR.
>> >>>>>
>> >>>>> Short of re-structuring the linux driver is there anything that can be
>> >>>>> done with ASL to properly have the ACPI device use a sub-resource of
>> >>>>> the PCI device during the ACPI/PCI probing?
>> >>>>
>> >>>> Do you have an ACPI device object corresponding to the PCI device?
>> >>>
>> >>> I've been debugging this by proxy, and I did request that test. The
>> >>> following is the overall structure:
>> >>>
>> >>> scope (\_SB.PCI0) {
>> >>>
>> >>> Device (P2S)
>> >>> {
>> >>>         Name (_ADR, 0x000D0000)
>> >>>         Device (GPO0)
>> >>>         {
>> >>>                 Name (_ADR, 0)
>> >>>                 Name (_HID, "INT3452")
>> >>>                 Name (_CID, "INT3452")
>> >>>         }
>> >>> }
>> >>> }
>> >>>
>> >>> There are _STA methods in both Devices. The GP0 device has a _CRS
>> >>> method which just returns a ResourceTemplate which is filled in with
>> >>> static values. The PCI bar is at a fixed address from the firmware
>> >>> which allows the fixed calculations. However there is no specific
>> >>> reference to the P2S device's resources proper -- only the parent
>> >>> child relationship within the ASL. I'm not sure how to directly say "I
>> >>> want this sub-region of this other device's resource for my resource."
>> >>> That seems like the right thing, but it's not clear if that's implied
>> >>> by hierarchy of the devices.
>> >>>
>> >>> Lastly, if it helps, the kernel being used is based on v4.4 (no core
>> >>> patches on top).
>> >>>
>> >>
>> >> Hi Rafael,
>> >>
>> >> I haven't tried a newer kernel yet, but are you of the opinion that
>> >> having the Devices as parent-child within the ASL should work? I'm
>> >> wondering if there's already a patch in newer kernels that doesn't
>> >> report the conflict and works as expected once there are child Devices
>> >> under the P2S device.
>> >>
>> >
>> > I've been looking at this more closely. A child ACPI device under a
>> > ACPI PCI device doesn't change the resource conflict even when a _CRS
>> > method is added to the ACPI PCI device.  Below is my sleuthing which
>> > is probably not a surprise to anyone here, but please correct me where
>> > I am wrong.
>> >
>> > acpi_init() and pci_subsys_init() are both subsys_initcalls during
>> > boot up. I'm not sure if the ordering is dumb luck or not, but
>> > acpi_init() is called prior to pci_subsys_init(). The conflict error
>> > is spit out from pcibios_resource_survey() by way of pci_subsys_init()
>> >  subsys_initcall. However, the PCI device scanning is kicked off prior
>> > to this through acpi_scan_init() by way of acpi_init()
>> > subsys_initcall.  The conflict error occurs because there's already
>> > the child ACPI device in the resource tree. I'm not sure when/where
>> > those ACPI devices' resources are added, but clearly they are sitting
>> > in there since the conflict was found.
>
> I think the acpi_init()/pci_subsys_init() ordering is correct.  The
> ACPI namespace is primary.  A PCI hierarchy originates at a PCI host
> bridge in the ACPI namespace, so we should enumerate the ACPI
> namespace first, and when we find a PCI host bridge, we should
> enumerate the PCI devices below it.
>
> That said, I think it is correct mostly by accident and it would be
> nice if it were more explicit.
>
>> > Somewhere along the way a PCI device from a scan is linked with the
>> > ACPI device for that same PCI device in sysfs.  This is with me
>> > putting a _HID and _CID in the PCI ACPI device.
>> > # readlink -f /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/INT5A92:00/physical_node
>> > /sys/devices/pci0000:00/0000:00:0d.0
>> > # readlink -f /sys/devices/pci0000\:00/0000\:00\:0d.0/firmware_node/
>> > /sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/INT5A92:00
>> >
>> > So the hierarchy is known eventually, but it's clearly not honored
>> > when adding resources. The current ACPI support doesn't handle
>> > PciBarTarget which initially sounds (from ACPI spec) like the way to
>> > go for referencing a resource in a PCI device from an ACPI device.
>
> Yes, I think PCIBARTarget looks like the right way to do this.  It
> doesn't *seem* like it'd be that hard to implement; have you looked
> into that at all?
>

I just noticed that linux has no support for it. With the ability of
the BAR to be reassigned it sounds way more complicated unless you
were considering the support to be one-shot. During ACPI scan one
would have to see if the _CRS is using PciBarTarget and defer resource
probing until PCI devices' resources were added. However, that
deferral should likely happen before the device is added to the system
such that driver probing doesn't occur on a partially resolved ACPI
device (we need the PCI device and its resources before a driver
should engage it).

> Without PCIBARTarget, the AML contains fixed register addresses, so it
> will break if Linux reassigns the BAR.

Understood. Do we need to worry about reassignment when a driver is
bound to a device? If so that complicates everything. I'm also not
sure how one would go about suspending the dependent child while a BAR
is being reassigned -- resources need to be removed and re-added for
both the PCI parent and the ACPI child device.

>
>> > So
>> > that's out of the question currently, but maybe someone has a patch
>> > for that? I don't think reordering the acpi_init() and
>> > pci_subsys_init() would do anything different except change which
>> > device discovers the conflict.
>> >
>> > Is there a way to honor the ACPI device hierarchy during resource
>> > addition for the PCI devices? The conflict is found because of the
>> > presence of a child device claiming resources through _CRS.
>> > Alternatively, is there a good way to defer the probing of an ACPI
>> > device until one knows PCI resources have been added?
>> >
>> > Any insights would be very helpful. Thank you.
>>
>> I stumbled upon the hierarchy connection. That's all handled with the
>> platform_notify() end of things when device_add() is done on the pci
>> device. I was thinking we could take advantage of this when adding
>> resources, but a struct resource has no struct device. It's just a
>> name description for the resource at hand. However, platform devices
>> are added when the ACPI tree is parsed along with adding the resources
>> associated with them (PciBarTarget would be helpful here) so those
>> resources are sitting in the resource tree when PCI BARs are added.
>>
>> The following suggestion is sort of hacky, but it's the best I could
>> come up with provided the currently supported infrastructure. In
>> pci_claim_resource() do request_resource_conflict() as before. If it
>> fails do the following: 1. check if the device has an ACPI companion.
>> 2. For any children hanging off the ACPI companion device. check if
>> that device's name matches the conflict resource's name. 3. If so,
>> insert_resource_conflict() to place the BAR within the tree itself.
>
> I think the best solution would be to implement PCIBARTarget, but if
> that's impossible, this seems like a plausible workaround.

I'm not sure I'm in a position to do it correctly as I'm not an ACPI
subystem expert. I was hoping someone already had this on their radar
for such support. I could take a stab at it, but the nuances listed
above makes me think it's beyond me currently w/ my current ACPI
subsystem knowledge. Perhaps there's an easy way to deal w/ deferrals
and removal of devices from the system to handle resource updates?
What am I missing w.r.t. your comment about not seeming that hard?

>
> I don't know if the conflict would necessarily have to be with the
> ACPI companion itself.  It seems like you could have some hierarchy of
> ACPI devices where the leaf conflicts with a PCI BAR.  Maybe if a
> resource of *any* ACPI device below a PCI host bridge conflicts with a
> PCI BAR, we should insert the PCI BAR as a parent?

I was going to attempt to see if the resource name matches a child.
Your suggestion seems to allow any conflict -- even if it's a true
conflict. That's why I specifically created an ACPI device for the PCI
one with a true ACPI device nested under that. There's a parent-child
relationship which is explicit that we can leverage in the kernel.

>
> And since moving that BAR would break the AML, we should probably mark
> the BAR as IORESOURCE_PCI_FIXED.
>
> Bjorn
