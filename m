From: Hirokazu Takahashi <taka-jCdQPDEk3idL9jVzuh4AOg@public.gmane.org>
Subject: Re: [Lhms-devel] Re: [PATCH] ACPI based Memory Hotplug
 Driver Patch
Date: Sat, 11 Sep 2004 15:08:54 +0900 (JST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040911.150854.71102255.taka@valinux.co.jp>
References: <FEB6C4E97F6CAF41978FB2059D5454180F37E8@bgsmsx402.gar.corp.intel.com>
	<20040910224510.7f78b1b5.tokunaga.keiich@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040910224510.7f78b1b5.tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

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
> This is nice:)  I would like to suggest just one thing.
> 
> 'acpi_memory_enable/disable_device()' seem to call generic
> (not ACPI specific) hotplug functions 'add/remove_memory()' directly.
> I think the generic hotplug functions should not be called directly
> inside kernel, but from the userland for two reasons.

And remove_memory() should be invoked from a process context,
as it would write-back data on the memory or would wait for
the memroy becoming freeable. It can't be removed as long as
there remain references to it.

It would cause weird problems if the function is called from an ACPI
handler directly.

Thank you,
Hirokazu Takahashi.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
