From: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 0/2]convert ACPI driver model to Linux driver model
Date: Wed, 21 Sep 2005 00:56:41 -0400
Message-ID: <20050921045641.GB14734@neo.rr.com>
References: <1126502542.5153.17.camel@linux-hp.sh.intel.com> <20050912175741.GA15324@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050912175741.GA15324-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>
Cc: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 12, 2005 at 07:57:41PM +0200, Dominik Brodowski wrote:
> Hi,
> 
> On Mon, Sep 12, 2005 at 01:22:22PM +0800, Shaohua Li wrote:
> > I'm sending the patches out not for merging but for comments. The
> > patches try to convert ACPI driver model to Linux driver model. 
> 
> Excellent.
> 
> > 1. in my mind, acpi should export two sets of info in sysfs. One is
> > current namespace subsystem, it should just export the firmware info.
> > All acpi device/drivers related info don't export here. The other is
> > ACPI bus. It's similar with other buses like PCI bus.
> 
> However, there is no physical ACPI bus. Therefore, it shouldn't exist in
> /sys/devices/ or /sys/bus/. If they are platform devices (devices which can be
> poked at some iomem or ioport address, but aren't on any specific bus), they
> should be registered as platform devices; if these are system devices
> (core devices for basic operation; can live with IRQs off for suspend and 
> resume, or even require that) they should be registered as system devices.

In theory this makes sense, but in practice I think it's very difficult.  The
ACPI specification clearly intends for these representions to show up as real
physical devices.  One of the goals of ACPI is to look like a physical bus for
platform hardware.  Hence, ACPI provides detection, identification, power
management, and other bus-like services.

Also, in the driver model, we don't have physical bus types.  Rather buses are
just collections of devices that have the same interface for detection,
identification, power management, etc.  In general, a bus is just an API for
talking to a type of physical hardware.  Some have even used "struct bus_type"
to represent subcomponents of a physical device (see the PCI Express Port
Driver). Therefore, I think it's very natural to create an ACPI "struct
bus_type".  Every device that utilizes ACPI for detection, power management,
etc... would belong to this bus_type.  I see "struct bus_type" as a type of
physical device class.

Also, platform devices are rather ugly, and I would argue that it may make sense
to eventually remove them from the driver model.  They don't show device tree
dependencies properly and in many ways are just a hack, so it may be better to
register platform devices without a bus or with a legacy bus like ISA depending
on the situation.

> 
> > 2. I regard all devices which don't belong to physical buses in the DSDT
> > as ACPI bus devices. Ideally, PCI devices, PNP devices & other devices
> > should bind them to their physical buses.
> 
> Yes, exactly.
> 
> > Since many devices listed in
> > DSDT aren't in ACPI bus, this makes it impossible to convert current
> > acpi driver model into Linux style.
> 
> Indeed. For each device, you need to decide which bus it resides on:
> > (CPU is in the bus)
> 
> No, CPUs are already registered as system devices. ( /sys/devices/system/cpu/ )
> Don't insert them twice into the device tree, please

Once again, I'm not sure if I agree here.  When ACPI is the root bus, we can
represent things like ACPI wants.  When we're using PnPBIOS or a legacy root
bus, we can use system devices or whatever.  Still, this issue is rather
complex and needs to be worked out.

> 
> >  So I'd like to remove the namespace hotplug interface later.
> Indeed, let's focus on this stuff later on.
> 
> So, let's look at the devices and where they should be registered. In most
> cases, it is just a guess on my side; system devices are suspended and
> resumed with interrupts off; that most probably should be a decisive point
> in this distinction.
> 
> +       "PNP0C09", /* EC */
> -> system or platform, not sure...
> 
> +       "ACPI0003", /* AC */
> -> platform
> 
> +       "PNP0C0F", /* Link */
> -> system. Might this already be registered on some systems? I have
> irqrouter, i8237 and i8259 in /sys/devices/system/
> 
> +       "PNP0C0A", /* battery */
> -> platform
> 
> +       "PNP0C0C", "PNP0C0E", "PNP0C0D", "ACPI_FPB" ,"ACPI_FSB", /* button */
> -> platform
> 
> +       "PNP0C0B", /* fan */
> -> platform
> 
> +       "PNP0A03", /* PCI root */
> -> system or platform, not sure either.... Please make sure that "pci0000:00" or
>    whatever is registered as a child of this device.
> 
> +       ACPI_POWER_HID, /* power */
> -> platform
> 
> +       ACPI_PROCESSOR_HID, /* CPU */
> -> system, is already there...
> 
> +       ACPI_THERMAL_HID, /* thermal */
> -> platform

I'd argue all of these should appear in the device tree.  Their drivers want
to use the ACPI bus interface and will bind in a fashion identical to real
physical devices.

> 
> 
> Also, you might think about adding all these devices to "class ACPI".
> /sys/class/acpi/ is perfectly valid; there you can add some common
> infrastructure for _all_ ACPI-enumerated devices, rely on "class interface"
> and other methods available.

I have some thoughts on this issue also, but it's probably best that we
focus on physical ACPI device representation for now.

Thanks,
Adam



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
