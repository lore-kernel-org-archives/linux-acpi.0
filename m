From: Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC 0/2]convert ACPI driver model to Linux driver model
Date: Wed, 21 Sep 2005 00:31:47 -0400
Message-ID: <20050921043147.GA14734@neo.rr.com>
References: <1126502542.5153.17.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1126502542.5153.17.camel-ECwVeV2eNyQD0+JXs3kMbRL4W9x8LtSr@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Shaohua Li <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-dev <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Shaohua,

I'm sorry for the late reply.

On Mon, Sep 12, 2005 at 01:22:22PM +0800, Shaohua Li wrote:
> Hi,
> I'm sending the patches out not for merging but for comments. The
> patches try to convert ACPI driver model to Linux driver model. There
> are still many things unsettled. If you have any
> comment/suggestion/requirement, please let me know.
> 
> 1. in my mind, acpi should export two sets of info in sysfs. One is
> current namespace subsystem, it should just export the firmware info.
> All acpi device/drivers related info don't export here. The other is
> ACPI bus. It's similar with other buses like PCI bus.

I'm not sure if we want to export the ACPI namespace in sysfs.  In
theory, we can attach most of that information on to the device tree
directly.  I agree that an ACPI bus would be useful.  I think it should
represent every device that can't be enumerated by another standard.

> 
> 2. I regard all devices which don't belong to physical buses in the DSDT
> as ACPI bus devices. Ideally, PCI devices, PNP devices & other devices
> should bind them to their physical buses. Since many devices listed in
> DSDT aren't in ACPI bus, this makes it impossible to convert current
> acpi driver model into Linux style. You might look at my patch, many
> routines required by Linux driver model are empty. Though we can't
> completely utilize the advantage of Linux driver model, the partial
> convert still benefits us many such as sysfs support and suspend/resume
> support.

This partial implementation has its advantages, but it's also important
to have a well defined plan of transition.  I think we should migrate the
ACPI code entirely to the linux driver model.  I've made some progress on
this issue.

> 
> 3. The acpi namespace hotplug interface looks strange. After we
> introduce ACPI bus (CPU is in the bus), we can send hotplug event
> through it. So I'd like to remove the namespace hotplug interface later.

Agreed.

> 
> There are something to prevent us from completely converting ACPI driver
> model to Linux style:
> 1. Current ACPI driver model can register drivers for all devices listed
> in DSDT. ACPI bus can't handle this.

I'm assuming you're referring to devices that don't need ACPI for
enumeration.  All other types shouldn't be a problem.

I've ran into this with some of my PCI bus code.  My current strategy is
to move the responsibility of attaching firmware data to the specific
device driver of the device in question rather than having the ACPI bus
handle it.  The idea is that only ACPI-aware drivers will utilize ACPI,
otherwise it will be ignored.  Essentially, ACPI aware devices will serve
as anchoring points for ACPI objects, including those that belong to the
ACPI Bus type.  Any comments?

> 2. Current ACPI hotplug (CPU/IO) relays on separate .add/.start
> callbacks, but Linux driver can only provide a .probe. We might split
> ACPI hotplug support to separate drivers.
> Since these, my patch just adds fake Linux driver model support, but it
> still is very useful.

This was also an issue that I came across.

Could you explain the role of .add/.start and why it's necessary?  It
may be reasonable to add this functionality to the Linux driver model
so that other drivers can utilize it.


I would appreciate any comments.

Thanks,
Adam


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
