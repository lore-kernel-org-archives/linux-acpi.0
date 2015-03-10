From: Jake Oshins <jakeo@microsoft.com>
Subject: RE: [PATCH 1/3] drivers:pnp Add support for descendants claiming
 memory address space
Date: Tue, 10 Mar 2015 22:10:17 +0000
Message-ID: <DM2PR0301MB12329507E2600FD4AEF9A7E7AB180@DM2PR0301MB1232.namprd03.prod.outlook.com>
References: <1424202111-14461-1-git-send-email-jakeo@microsoft.com>
 <54F8E0C3.6080103@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54F8E0C3.6080103@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, KY Srinivasan <kys@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, "olaf@aepfle.de" <olaf@aepfle.de>, "apw@canonical.com" <apw@canonical.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rafael.j.wysocki@intel.com]
> Sent: Thursday, March 5, 2015 3:04 PM
> To: Jake Oshins
> Cc: gregkh@linuxfoundation.org; KY Srinivasan; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; vkuznets@redhat.com; Rafael J. Wysocki; Linux ACPI
> Subject: Re: [PATCH 1/3] drivers:pnp Add support for descendants claiming
> memory address space
> 
> On 2/17/2015 8:41 PM, Jake Oshins wrote:
> > This patch adds some wrapper functions in the pnp layer.  The intent is
> > to allow memory address space claims by devices which are descendants
> > (a child or grandchild of) a device which is already part of the pnp
> > layer.  This allows a device to make a resource claim that doesn't
> > conflict with its "aunts" and "uncles."
> 
> How is this going to happen?

First, thanks for the review.  

As for your question, I'm not sure whether you're asking how the code that I supplied makes it happen or how we might happen to be in a situation where you want to make a resource claim that doesn't conflict with aunts and uncles.  I'll address the second interpretation first.

Imagine you have a PC from the mid '90s, or any time period when PCI coexisted with other bus technologies like ISA and EISA.  You have a region of memory address space that's reserved for I/O devices.  PCI devices sit below that.  So do bridges to other bus technologies.  When picking a memory region for one of the PCI devices, you need to ensure that it doesn't overlap both other PCI devices and devices which are beneath the EISA/ISA/other bridge. The PCI devices are the aunts and uncles.  The EISA/ISA devices are nephews and nieces.  The bridge to the EISA/ISA bus claims nothing and just passes through cycles that aren't claimed by PCI devices.

A Hyper-V VM is much like that mid '90s PC.  "Generation 1 VMs" in Hyper-V are like it because they are, in fact, an emulation of a specific PC from 1997.  "Generation 2 VMs" in Hyper-V are like it because they have a single region reported by the virtual UEFI firmware to be used by everything below that, with nothing else described by the firmware, except a "bridge" to a virtual bus called VMBus, which itself has no address space description, much like the EISA/ISA bus had no address space description.  Devices can be added or removed from the VM while it is running, and they have no description in ACPI.

As for how the code I supplied makes this happen, it adds a more generic wrapper to the pnp layer, augmenting the four wrappers which already exist; ISAPNP/PNPBIOS, PCI, PCMCIA and ACPI.  Each of these four wrappers has code specific to the bus type.  I just added a small wrapper that doesn't have that.

> 
> > This is useful in a Hyper-V VM because some paravirtual "devices" need
> > memory-mapped I/O space, and their aunts and uncles can be PCI devices.
> > Furthermore, the hypervisor expresses the possible memory address
> > combinations for the devices in the VM through the ACPI namespace.
> > The paravirtual devices need to suballocate from the ACPI nodes, and
> > they need to avoid conflicting with choices that the Linux PCI code
> > makes about the PCI devices in the VM.
> >
> > It might seem like this should be done in the platform layer rather
> > than the pnp layer, but the platform layer assumes that the
> > configuration of the devices in the machine are static, or at least
> > expressed by firmware in a static fashion.
> 
> I'm not sure if I'm following you here.
> 
> Where exactly do we make that assumption?
> 
> Yes, some code to support platform device hotplug may be missing, but I'd
> very much prefer to add it instead of reviving the dead man walking which is
> the PNP subsystem today.
> 

I'm completely open to adding this to the platform layer instead of the pnp layer.  But it seems like you'd have to accommodate a usage model that doesn't yet exist in the platform layer.  (You confirmed for me yourself in another e-mail that the platform layer doesn't have a provision for asking for things like "any 100MB of memory address space under my root bus, and I won't bloat this message by pasting that in unless you'd like me to send it along.)

If I were to try to use the platform layer without heavily modifying it, I'd have to write code that, from the client, driver, tried to probe for regions of free address space.  Imagine an algorithm that attempted to find a free 16K by just calling allocate_resources() for every 16K region, starting from the top (or bottom) of address space until one of those claims succeeded.  You could cut down the search space considerably by walking up the device tree in your driver, looking for a parent ACPI bus or module device node with a _CRS.  In fact, you'd have to, or else you might end up claiming space that is outside the physical address width of the processor, or in use by something which didn't call allocate_resource(), etc.  You'd have to duplicate much of the code that already exists in d
 rivers/pnp/manager.c.

In fact, the hv_vmbus and hyperv_fb drivers currently in the tree do more or less just this.  They hunt through the ACPI structures looking for the _CRS object in an ACPI module device above hv_vmbus (and the code is broken today in the cases where there isn't a module device, but a root PCI bus) and then they just make claims in that region, hoping for success.

The problem comes in if there are PCI devices in the same region.  There's no easy way to figure out whether the claim conflicts with the PCI devices, since the PCI device's claims are made through the pnp layer.

I'm curious, by the way, about what you really mean when you say that the PNP subsystem is a dead man walking.  Do you intend to pull it out?  If so, I think that you'll have the same sorts of problems in those drivers that I'm describing here.  You could, of course, put the logic for assigning resources across all the devices on the bus into the platform layer, but that will just end up merging it the pnp layer, no?

If you want to take the path of adding to the platform layer what's missing there, the specific requirements would be something like these:

1)  It must be possible to describe "options" for the device, not specific regions for the device.  These options are generally expressed in terms of base, limit, length and alignment.

2)  It must be possible to look up the assignments that were chosen from among the options, after a phase where all the options have been collected and the various possible configurations have been boiled down to specific set of assignments.


> > The nature of a Hyper-V
> > VM is that new devices can be added while the machine is running,
> > and the potential configurations for them are expressed as part of
> > the paravirtual communications channel.  This much more naturally
> > aligns with the pnp layer.
> 
> That's debatable.
> 
> That aside, it would help a lot if you described your design in plain
> English
> and added some useful kerneldoc comments to the new functions.
> 
> Kind regards,
> Rafael

If comments are the fundamental issue here, I'm more than happen to add them.  I'll wait to propose specific changes there until this discussion resolves.

Thank you so much for your time,
Jake Oshins
