From: Dave Hansen <haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Lhms-devel] Re: [PATCH] ACPI based Memory Hotplug
	Driver Patch
Date: Sat, 11 Sep 2004 00:14:45 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1094886885.3997.2.camel@localhost>
References: <FEB6C4E97F6CAF41978FB2059D5454180F37E8@bgsmsx402.gar.corp.intel.com>
	 <20040910224510.7f78b1b5.tokunaga.keiich@jp.fujitsu.com>
	 <20040911.150854.71102255.taka@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040911.150854.71102255.taka-jCdQPDEk3idL9jVzuh4AOg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Hirokazu Takahashi <taka-jCdQPDEk3idL9jVzuh4AOg@public.gmane.org>
Cc: "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Matthew E Tolentino <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-09-10 at 23:08, Hirokazu Takahashi wrote:
> > 'acpi_memory_enable/disable_device()' seem to call generic
> > (not ACPI specific) hotplug functions 'add/remove_memory()' directly.
> > I think the generic hotplug functions should not be called directly
> > inside kernel, but from the userland for two reasons.
> 
> And remove_memory() should be invoked from a process context,
> as it would write-back data on the memory or would wait for
> the memroy becoming freeable. It can't be removed as long as
> there remain references to it.
> 
> It would cause weird problems if the function is called from an ACPI
> handler directly.

I don't think this is true.  It would be a problem if we were calling
sys_write() on the sysfs files from inside of there, but those
interfaces are *there* for firmware to call them.  

In fact, I think we even mention that where they're defined.  As long as
we claim that they might_sleep(), and ACPI isn't holding any locks at
the time, or in interrupt context, where's the problem?  Worst case, we
schedule_work() to have the removal done in a sleepable context.

-- Dave



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
