From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [Lhms-devel] Re: [PATCH] ACPI based Memory Hotplug Driver
 Patch
Date: Tue, 14 Sep 2004 11:58:44 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040914115844.1e12203d.tokunaga.keiich@jp.fujitsu.com>
References: <FEB6C4E97F6CAF41978FB2059D5454180F37E8@bgsmsx402.gar.corp.intel.com>
 <20040910230200.73eb0374.tokunaga.keiich@jp.fujitsu.com>
 <1094837554.32531.1997.camel@nighthawk>
 <20040913172318.791db349.tokunaga.keiich@jp.fujitsu.com>
 <1095064865.4671.5.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <1095064865.4671.5.camel@localhost>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dave Hansen <haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 13 Sep 2004 01:41:05 -0700 Dave Hansen wrote:
> On Mon, 2004-09-13 at 01:23, Keiichiro Tokunaga wrote:
> > On Fri, 10 Sep 2004 10:32:35 -0700 Dave Hansen wrote:
> > > At this point, adding stuff to /proc in mainline has a pretty slim
> > > chance of happening.  sysfs is really the way to go, plus we already
> > > have code in the mhp tree to export the hotplug memory controls via
> > > sysfs.  This stuff seems to me to belong in /sys/firmware.
> > >
> > > But, this brings up something that's been nagging me for a while: what
> > > should /sys/devices/system/memory contain?  A logical view of memory for
> > > use with memory hotplug, or a hardware description of memory?  I think
> > > both are probably necessary, and should link to each other, but how
> > > should we present them?
> > 
> > How about this?
> > 
> > # ls /sys/firmware/acpi/memory/MEM1/
> > resource_type
> > producer_consumer
> > decode
> > min_address
> > max_address
> > granularity
> > min_address_range
> > max_address_range
> > address_translation_offset
> > address_length
> 
> The placement looks right to me.
> 
> > # ls /sys/devices/system/memory/memsection4/
> > start_physaddr
> > <something else>
> > 
> > We can determine which memsection belongs to which ACPI
> > memory object by using min_address_range, max_address_range,
> > and start_physaddr.  In the above case, start_physaddr is between
> > min_address_range and max_address_range if MEM1 contains
> > memsection4.
> 
> sysfs really has a legacy of being linked together with regular old
> symlinks.  There's plenty of stuff in there that we *could* derive by
> looking all over the place, but don't because it's so easy to just
> create links.  I say we create links from one to the other, and make
> sure not to duplicate any information.  
> 
> For instance, there shouldn't really need to be a start_addr in the acpi
> directory if it can easily be determined from the memsections that
> belong to that acpi memory object.  (or the othe way around, maybe)

Creating links from one to the other sounds fine.  But I don't think a
physical start address of an ACPI memory object can be detemined
from the memsections that belong to that object.  This is because
there is no gurantee that an ACPI memory object and a memsection
that belongs to the object always have the same start address.  So,
I think the interface to show physical memory range is necessary in
both the ACPI and memsection directory.

Thanks,
Keiichiro Tokunaga


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
