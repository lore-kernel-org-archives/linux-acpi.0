From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH] ACPI based Memory Hotplug Driver Patch
Date: Tue, 14 Sep 2004 17:06:51 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040914170651.6eea6d84.tokunaga.keiich@jp.fujitsu.com>
References: <FEB6C4E97F6CAF41978FB2059D5454180F3802@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <FEB6C4E97F6CAF41978FB2059D5454180F3802-OkeUvhg1trkFyVwBAnZdSLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 13 Sep 2004 23:20:10 +0530 S, Naveen B wrote:
> Thanks Keiichiro Tokunaga
> 
> > This is nice:)  I would like to suggest just one thing.
> > 
> > 'acpi_memory_enable/disable_device()' seem to call generic
> > (not ACPI specific) hotplug functions 'add/remove_memory()' directly.
> > I think the generic hotplug functions should not be called directly
> > inside kernel, but from the userland for two reasons.
> > 
> In the hotadd case, add_memory is invoked to notify the VM that there is
> change in physical memory and it's up to the VM, not the acpi driver to
> determine where and when that the new memory region should be onlined.
> Currently the VM leaves the onlining decision to userspace and when
> add_memory is invoked the required initialization is done, but the pages
> are not available for allocation. So the policy of onlining the memory
> is still left to userland. 
>
> As mentioned in the code, user notification is still TBD in the
> hot-remove code path, as hot-remove support isn't there fully in the
> kernel yet.

I see.  Thanks for the information:)

Thanks,
Keiichiro Tokunaga


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
