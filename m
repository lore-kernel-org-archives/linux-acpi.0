From: Dave Hansen <haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Lhms-devel] Re: [PATCH] ACPI based Memory Hotplug
	Driver Patch
Date: Fri, 10 Sep 2004 10:32:35 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1094837554.32531.1997.camel@nighthawk>
References: <FEB6C4E97F6CAF41978FB2059D5454180F37E8@bgsmsx402.gar.corp.intel.com>
	 <20040910230200.73eb0374.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040910230200.73eb0374.tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Matthew E Tolentino <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-09-10 at 07:02, Keiichiro Tokunaga wrote:
> On Thu, 09 Sep 2004 16:24:46 +0530 S, Naveen B wrote:
> > Attached is an ACPI based hot plug driver patch to support physical
> > memory hotplug. This driver supports physical hotplug operation on
> > memory, fields notifications from firmware and notifies the VM of the
> > affected memory ranges.  The following patch is against kernel
> > 2.6.8.1-mm3, and works with the current memory hotplug VM patches
> > posted at: http://sprucegoose.sr71.net/patches.  This patch has been
> > tested on real prototype hardware in the hot-add memory case. Hot
> > remove feature is tested in an emulated environment (by overriding
> > ACPI DSDT). 
> > 
> > Please review and consider for inclusion. 
> 
> I would like to add a feature into drivers/acpi/memory.c.
> 
> Please see the patch below.  This patch is for the kernel applying
> your patch.
> 
> This patch generates procfs entry 'info' for each memory ACPI
> object to expose memory device information.  This information
> is needed to determine which logical memory ID(s) (memsection ID)
> belongs which memory ACPI object (e.g. memsection5 --> MEM0).
> Memsection IDs could be fingured out from min_address_range
> and max_address_range that 'info' file shows.

At this point, adding stuff to /proc in mainline has a pretty slim
chance of happening.  sysfs is really the way to go, plus we already
have code in the mhp tree to export the hotplug memory controls via
sysfs.  This stuff seems to me to belong in /sys/firmware.

But, this brings up something that's been nagging me for a while: what
should /sys/devices/system/memory contain?  A logical view of memory for
use with memory hotplug, or a hardware description of memory?  I think
both are probably necessary, and should link to each other, but how
should we present them?

One thing that causes a problem is that ppc64 already exports a view of
its memory in /proc/device-tree.  But, I don't think this is something
that ACPI should perpetuate.  

-- Dave



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
