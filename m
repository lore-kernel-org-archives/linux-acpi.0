From: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: PATCH/RFC: driver model/pmcore wakeup hooks (1/4)
Date: 20 Oct 2004 02:16:07 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098252967.26601.4273.camel@d845pe>
References: <200410051309.02105.david-b@pacbell.net>
	 <1097906636.14156.41.camel@d845pe> <200410182041.02192.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200410182041.02192.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-10-18 at 23:41, David Brownell wrote:
> On Friday 15 October 2004 11:03 pm, Len Brown wrote:
> > > - ACPI (this should probably replace the new /proc/acpi/wakeup)
> >
> > Agreed.  That file is a temporary solution.
> > The right solution is for the devices to appear in the right
> > place in the device tree and to hang the wakeup capabilities
> > off of them there.
> 
> So what would that patch need before ACPI could convert to use it?
> 
> I didn't notice any obvious associations between the strings in
> the acpi/wakeup file and anything in sysfs.  Which of USB1..USB4
> was which of the three controllers shown by "lspci" (and which
> one was "extra"!), as one head-scratcher.

The strings "USB1" etc. are completely arbitrary, which is one
reason that /proc/acpi/wakeup is only marginally useful.

> For PCI, I'd kind of expect pci_enable_wake() to trigger the
> additional ACPI-specific work to make sure the device can
> actually wake that system.   Seems like dev->platform_data
> might need to combine with some platform-specific API hook.

In the ACPI DSDT...
Devices are explicitly identified as PCI busses by their PNP-id.
These PCI busses are enumerated by their _BBN or _CRS.
The devices under the PCI busses all contain an _ADR which encodes the
PCI device/function number.

Ie. ACPI tells us the PCI bus/dev/func for each PCI device in the DSDT,
and with this information it needs to be able to find devices in the
Linux device tree and associate some ACPI capabilities with it.

-Len




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
