From: Dave Hansen <haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Lhms-devel] Re: [PATCH] ACPI based Memory Hotplug
	Driver Patch
Date: Mon, 13 Sep 2004 21:11:44 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1095135104.10726.8.camel@localhost>
References: <FEB6C4E97F6CAF41978FB2059D5454180F37E8@bgsmsx402.gar.corp.intel.com>
	 <20040910230200.73eb0374.tokunaga.keiich@jp.fujitsu.com>
	 <1094837554.32531.1997.camel@nighthawk>
	 <20040913172318.791db349.tokunaga.keiich@jp.fujitsu.com>
	 <1095064865.4671.5.camel@localhost>
	 <20040914115844.1e12203d.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040914115844.1e12203d.tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Matthew E Tolentino <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Joel Schopp <jschopp-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2004-09-13 at 19:58, Keiichiro Tokunaga wrote:
> Creating links from one to the other sounds fine.  But I don't think a
> physical start address of an ACPI memory object can be detemined
> from the memsections that belong to that object.  This is because
> there is no gurantee that an ACPI memory object and a memsection
> that belongs to the object always have the same start address.  So,
> I think the interface to show physical memory range is necessary in
> both the ACPI and memsection directory.

I agree.  It's very possible that ACPI memory areas will be able to span
multiple memory sections, as the inverse.  

Although, I do wonder if we can have memory laid out in the firmware/
directory in some kind of firmware-agnostic way.  

What I want is to make sure that any hotplug memory application that is
written can use the same directories no matter whether it is a ppc
machine using OpenFirmware or an x86/ia64 machine using ACPI.  

Instead of just laying thing out in firmware/acpi, can we have another
directory that mirrors this information in the system/devices/
directory, but is identical across architectures?  

ppc64 guys, what do you think?

-- Dave



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
