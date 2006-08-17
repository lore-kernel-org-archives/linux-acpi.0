From: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [patch 11/14] ACPI: change GFP_ATOMIC to GFP_KERNEL for non-atomic
  allocation
Date: Thu, 17 Aug 2006 11:15:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0608171104390.28168@twin.jikos.cz>
References: <200608150537.k7F5bTu8011560@shell0.pdx.osdl.net>
 <200608161902.02221.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:14297 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S932374AbWHQJPw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Aug 2006 05:15:52 -0400
In-Reply-To: <200608161902.02221.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@osdl.org, linux-acpi@vger.kernel.org

On Wed, 16 Aug 2006, Len Brown wrote:

> > acpi_pci_link_set() allocates with GFP_ATOMIC. On resume from suspend,
> > this is called with interrupts off, otherwise GFP_KERNEL is safe.
> So you are suggesting this?
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index 7f3e7e7..d53bd98 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -307,7 +307,7 @@ static int acpi_pci_link_set(struct acpi
>  	if (!link || !irq)
>  		return -EINVAL;
>  
> -	resource = kmalloc(sizeof(*resource) + 1, GFP_ATOMIC);
> +	resource = kmalloc(sizeof(*resource) + 1, irqs_disabled() ? GFP_ATOMIC: GFP_KERNEL);
>  	if (!resource)
>  		return -ENOMEM;
>  
> 

Yes, exactly.

> > acpi_pci_link_resume -> acpi_pci_link_set -> acpi_set_current_resources ->
> > acpi_rs_set_srs_method_data -> acpi_ut_create_internal_object_dbg ->
> > acpi_ut_allocate_object_desc_dbg -> acpi_os_acquire_object ->
> > kmem_cache_alloc(GFP_KERNEL) flag.
> I don't understand this comment.
> acpi_os_acquire_object is implemented in aclinux.h:
> static inline void *acpi_os_acquire_object(acpi_cache_t * cache) {
>         return kmem_cache_zalloc(cache, irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
> }

This happened in some -rc of 2.6.18 (can be seen at
http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6%2Ftesting%2Fpatch-2.6.18-rc4.bz2;z=2727)  
- the acpi_os_acquire_object() was renamed to acpi_os_validate_interface()  
... which allocates solely with GFP_KERNEL, but this may be OK, I haven't
checked.

Anyway ...

Unfortunately, looking at the refactorized ACPI code in
2.6.18-rc4, there are still issues with sleeping functions called with
disabled interrupts (during resume), in ACPI code.

Two random examples:

- when acpi_pci_link_set() is called during resume (local irqs off), the
following callchain happens, which is bad: acpi_pci_link_resume ->
acpi_pci_link_set -> acpi_set_current_resources ->
acpi_rs_set_srs_method_data -> acpi_ns_evaluate -> acpi_ns_get_node ..
here the mutex is acquired. Not good.

- device_power_up -> sysdev_resume -> __sysdev_resume -> cpufreq_resume ->
blocking_notifier_call_chain -> down on semaphore. Not good.

Is there any general idea for solution?

Thanks,

-- 
JiKos.
