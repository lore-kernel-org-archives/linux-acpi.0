From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [Lhms-devel] Re: [PATCH] ACPI based Memory Hotplug Driver
 Patch
Date: Thu, 16 Sep 2004 11:51:11 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040916115111.72bc9222.tokunaga.keiich@jp.fujitsu.com>
References: <FEB6C4E97F6CAF41978FB2059D5454180F37E8@bgsmsx402.gar.corp.intel.com>
 <20040910230200.73eb0374.tokunaga.keiich@jp.fujitsu.com>
 <1094837554.32531.1997.camel@nighthawk>
 <20040913172318.791db349.tokunaga.keiich@jp.fujitsu.com>
 <1095064865.4671.5.camel@localhost>
 <20040914115844.1e12203d.tokunaga.keiich@jp.fujitsu.com>
 <1095135104.10726.8.camel@localhost>
 <20040914182956.49c9381d.tokunaga.keiich@jp.fujitsu.com>
 <1095181936.3686.29.camel@localhost>
 <20040915090827.7f86a54f.tokunaga.keiich@jp.fujitsu.com>
 <1095207455.12864.30.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <1095207455.12864.30.camel@localhost>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dave Hansen <haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Cc: tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, jschopp-V7BBcbaFuwjMbYB6QlFGEg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 14 Sep 2004 17:17:35 -0700 Dave Hansen wrote:
> On Tue, 2004-09-14 at 17:08, Keiichiro Tokunaga wrote:
> > Please let me make sure one thing.
> > Is this what you have in mind?
> > 
> >   /sys/devices/system/memory/  -->  physical layout
> >   /sys/devices/system/logical/memory/  -->  hotplug controls
> 
> Yeah, something like that.  
> 
> > By the way, I'm not sure what the 'hotplug controls' are.  Can you
> > be more specific about them?
> 
> That's the place where Linux presents each memory section as well as the
> 'status' file so that each section may be added or removed from sysfs.

Thanks.  Adding/removing directories of memsection from sysfs as
needed sounds nice to me:)

Okay, as a first try, I will be making a patch creating the directory
'/sys/firmware/acpi/memory/' and some entries.

Thanks,
Keiichiro Tokunaga


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
