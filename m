From: Russell King <rmk+lkml-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH/RFC 1/4]device core changes
Date: Thu, 11 Nov 2004 08:44:11 +0000
Message-ID: <20041111084411.A2400@flint.arm.linux.org.uk>
References: <1099887071.1750.243.camel@sli10-desk.sh.intel.com> <20041108225810.GB16197@kroah.com> <1099961418.15294.11.camel@sli10-desk.sh.intel.com> <1099971341.15294.48.camel@sli10-desk.sh.intel.com> <20041109045843.GA4849@kroah.com> <1099990981.15294.57.camel@sli10-desk.sh.intel.com> <20041110012443.GA9496@kroah.com> <1100051137.7825.6.camel@sli10-desk.sh.intel.com> <20041110042822.A13318@flint.arm.linux.org.uk> <1100156613.8769.26.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1100156613.8769.26.camel-U5EdaLXB8smDugQYiPIPGdh3ngVCH38I@public.gmane.org>; from shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org on Thu, Nov 11, 2004 at 03:03:33PM +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Greg <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Nov 11, 2004 at 03:03:33PM +0800, Li Shaohua wrote:
> On Wed, 2004-11-10 at 12:28, Russell King wrote:
> > On Wed, Nov 10, 2004 at 09:45:37AM +0800, Li Shaohua wrote:
> > > On Wed, 2004-11-10 at 09:24, Greg KH wrote:
> > > > Maybe your other patches weren't so bad...  If we implement them, can we
> > > > drop the platform notify stuff?
> > > Currently only ARM use 'platform_notify', and we can easily convert it
> > > to use per-bus 'platform_bind'. One concern of per-bus 'platform_bind'
> > > is we will have many '#ifdef ..' if many platforms implement their
> > > per-bus 'platform_bind'.
> > 
> > Except none of the merged ARM platforms use platform_notify, and I haven't
> > seen any suggestion in the ARM world of why it would be needed.
> Ok, let me summarize it. we now have two options:
> 1. using 'platform_notify'
> platform_notify only has one parameter 'struct device', we must know the
> exact bus type of a device. We can identify the bus type from its name
> (such as 'pci', 'ide'), but it's quite some ugly. Or we can add a 'type'
> flag in the 'struct bus_type' to indicate the exact bus type which Greg
> doesn't like it. One shortcoming is the method hasn't good flexibility,
> we must add a new type whenever a new bus type is added.

Is there something wrong with doing dev->bus == &pci_bus_type for
example?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
