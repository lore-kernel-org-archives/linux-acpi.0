From: Dave Hansen <haveblue-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>
Subject: Re: [Lhms-devel] [PATCH] ACPI based Memory Hotplug Driver
	Patch
Date: Thu, 09 Sep 2004 08:50:47 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1094745047.29990.62.camel@nighthawk>
References: <FEB6C4E97F6CAF41978FB2059D5454180F37E8@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <FEB6C4E97F6CAF41978FB2059D5454180F37E8-OkeUvhg1trkFyVwBAnZdSLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "S, Naveen B" <naveen.b.s-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lhms <lhms-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Matthew E Tolentino <matthew.e.tolentino-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-09-09 at 03:54, S, Naveen B wrote:
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

Very cool!  A few comments below.

> +config ACPI_HOTPLUG_MEMORY
> +	tristate "Memory Hotplug"
> +	depends on ACPI
> +	depends on MEMORY_HOTPLUG
> +	default m
> +	help
> +	  This driver adds supports for ACPI Memory Hotplug.
>  endmenu
...
> +obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= memory.o

What does this end up naming the module?  If it ends up being memory.o,
you might want to think about making it something a bit more
descriptive.  Does it even need to be allowed to be a module, or is that
standard ACPI practice?

> +static int 
> +acpi_memory_disable_device(struct acpi_memory_device *mem_device) 
> +{
> +	int result;
> +
> +	ACPI_FUNCTION_TRACE("acpi_memory_disable_device");
> +
> +	/* 
> +	 * Ask the VM to offline this memory range.
> +	 * Note: Assume that this function returns zero on success 
> +	 */
> +	if (remove_memory(mem_device->start_addr,
> +		(mem_device->end_addr - mem_device->start_addr) + 1,
> +		mem_device->read_write_attribute)) {
> +		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Hot-Remove failed.\n"));
> +		return_VALUE(-EINVAL);	
> +	}
> +

How about actually passing up the value that remove_memory() gave back? 
Also, what's with the +1 on the size?

If it ends up that all of the callers of remove_memory() prefer to give
start and end addresses, we'll probably change the calling convention at
some point.  Whatever is most natural.

I think I'd slightly prefer something that looks more like this (same
thing goes for the add function): 

acpi_memory_disable_device(struct acpi_memory_device *mem_device) 
{
	int err;
	u64 start = mem_device->start_addr;
	u64 len = mem_device->end_addr - start + 1;
	unsigned long attr = mem_device->read_write_attribute;

	ACPI_FUNCTION_TRACE("acpi_memory_disable_device");

	/* 
	 * Ask the VM to offline this memory range.
	 */
	err = remove_memory(start, len, attr);

	if (err) {
		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Hot-Remove failed.\n"));
		return_VALUE(err);	
	}
...

Otherwise, this looks very self-contained which, since we've given up on
ACPI code looking nice, is all we can ask for. :)

Other than the add/remove_memory() calls does this have any real
interaction with any non-ACPI code that I overlooked?

-- Dave



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
