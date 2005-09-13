From: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC 0/2]convert ACPI driver model to Linux driver model
Date: Tue, 13 Sep 2005 14:50:50 +0800
Message-ID: <1126594250.4096.9.camel@linux-hp.sh.intel.com>
References: <1126502542.5153.17.camel@linux-hp.sh.intel.com>
	 <20050912175741.GA15324@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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
Cc: acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2005-09-12 at 19:57 +0200, Dominik Brodowski wrote:
> Hi,
> 
> On Mon, Sep 12, 2005 at 01:22:22PM +0800, Shaohua Li wrote:
> > I'm sending the patches out not for merging but for comments. The
> > patches try to convert ACPI driver model to Linux driver model. 
Thanks for your time.

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
Not sure. It's just a virtual bus. Some acpi devices haven't any
iomem/ioports. And some devices are platform devices and some not, which
means we must take care devices separately. We haven't a generic method
for all devices.

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
Ok, might be a sysdevice driver.
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
This one is broken for a long time. It can't be suspend/resume with
interrupt disabled.
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
> 
> 
> Also, you might think about adding all these devices to "class ACPI".
> /sys/class/acpi/ is perfectly valid; there you can add some common
> infrastrucutre for _all_ ACPI-enumerated devices, rely on "class interface"
> and other methods available.


Thanks,
Shaohua



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
