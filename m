From: Keiichiro Tokunaga <tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Subject: Re: [PATCH] ACPI based Memory Hotplug Driver Patch
Date: Fri, 10 Sep 2004 22:45:10 +0900
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040910224510.7f78b1b5.tokunaga.keiich@jp.fujitsu.com>
References: <FEB6C4E97F6CAF41978FB2059D5454180F37E8@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <FEB6C4E97F6CAF41978FB2059D5454180F37E8-OkeUvhg1trkFyVwBAnZdSLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: tokunaga.keiich-+CUm20s59erQFUHtdCDX3A@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Tolentino, Matthew E" <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 09 Sep 2004 16:24:46 +0530 S, Naveen B wrote:
> Attached is an ACPI based hot plug driver patch to support physical
> memory hotplug. This driver supports physical hotplug operation on
> memory, fields notifications from firmware and notifies the VM of the
> affected memory ranges.  The following patch is against kernel
> 2.6.8.1-mm3, and works with the current memory hotplug VM patches
> posted at: http://sprucegoose.sr71.net/patches.  This patch has been
> tested on real prototype hardware in the hot-add memory case. Hot
> remove feature is tested in an emulated environment (by overriding
> ACPI DSDT). 
> 
> Please review and consider for inclusion. 

This is nice:)  I would like to suggest just one thing.

'acpi_memory_enable/disable_device()' seem to call generic
(not ACPI specific) hotplug functions 'add/remove_memory()' directly.
I think the generic hotplug functions should not be called directly
inside kernel, but from the userland for two reasons.

One reason is:  ACPI based CPU hotplug takes a different approach.
ACPI based CPU hotplug is assuming to have its user mode agent
script (maybe, 'cpu.agent'?).  This agent is to inovke the generic
hotplug functions via sysfs. (e.g. echo 0 > /sys/devices/system/cpu/cpu0/online)
ACPI based CPU hotplug issues /sbin/hotplug to invoke the agent
and does not call the generic hotplug functions directly inside kernel.
If ACPI based memory hotplug does not take the same approach,
ACPI based CPU and memory drivers have different approaches
to this.

Another reason is:  ACPI container driver is not assuming that
the generic memory hotplug function is called by ACPI based memory
driver directly.  ACPI container hotplug needs to invoke the generic CPU
and memory hotplug functions.  For this, it uses its agent 'container.agent'
to call the functions as well as CPU hotplug.  This is because that it would
be more flexible than doing everything inside kernel.  With this approach,
'container.agent' can have a policy for container hotplug (e.g. invocation
order of the generic hotplug functions, error policy, etc)  Actually, this
approach was recommended by community people when I posted the
first patches of the container driver.  if ACPI memory hotplug calls the
generic memory hotplug function directly inside kernel, this story would
be broken.

Can you consider this?

Thanks,
Keiichiro Tokunaga


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
