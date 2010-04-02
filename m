From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [RFC PATCH] acpi: Automatically online hot-added memory [v2]
Date: Fri, 2 Apr 2010 09:31:46 -0600
Message-ID: <201004020931.46783.bjorn.helgaas@hp.com>
References: <20100401131944.4086.82010.sendpatchset@prarit.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:30534 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519Ab0DBPbt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Apr 2010 11:31:49 -0400
In-Reply-To: <20100401131944.4086.82010.sendpatchset@prarit.bos.redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-acpi@vger.kernel.org, trenn@suse.de, mjg@redhat.com

On Thursday 01 April 2010 07:19:44 am Prarit Bhargava wrote:
> New sockets have on-die memory controllers.  This means that in certain
> HW configurations the memory behind the socket comes and goes as the socket
> is physically enabled and disabled.
> 
> When a cpu is brought into service it requests memory from the local node.  If
> this fails, memory will be accessed from a different node for percpu data*.
> This results in a performance hit on large systems under scheduling
> intensive loads.
> 
> A solution to this is to have the memory come online automatically so that
> when the cpus are onlined they will have local node memory to allocate from.
> 
> This patch automatically onlines memory added via an ACPI event.
> 
> * A patch to fix this in slab has just been presented upstream.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index e4cbca5..7cd174d 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -1416,6 +1416,9 @@ and is between 256 and 4096 characters. It is defined in the file
>  			seconds.  Use this parameter to check at some
>  			other rate.  0 disables periodic checking.
>  
> +	mem_hotadd_auto= [KNL]
> +			Disable the auto-onlining of hot-added memory.
> +
>  	memtest=	[KNL,X86] Enable memtest
>  			Format: <integer>
>  			default : 0 <disable>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 93d2c79..dece6bd 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -350,6 +350,14 @@ config ACPI_HOTPLUG_MEMORY
>  	  To compile this driver as a module, choose M here:
>  	  the module will be called acpi_memhotplug.
>  
> +config ACPI_HOTPLUG_MEMORY_AUTO_ONLINE
> +	bool "Automatically online hotplugged memory"
> +	depends on ACPI_HOTPLUG_MEMORY
> +	default n
> +	help
> +	  This forces memory that is brought into service by ACPI
> +	  to be automatically onlined.

I don't know the use cases here, so let me just ask some naive
questions.

Is it really worth having both the config option and the kernel
parameter?  I'd expect few if any uses of hot-add in the field now,
so even if you removed the config option and made the default be to
always online hot-added memory, would that break anybody?

It looks like acpi_memhotplug can be compiled as a module, so
shouldn't "mem_hotadd_auto=" be a module parameter?

Is it possible that a user would want to online memory for some
hot-add events but not others?  If so, maybe the mem_hotadd_auto
thing should also be in sysfs?

> @@ -252,6 +264,18 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>  		result = add_memory(node, info->start_addr, info->length);
>  		if (result)
>  			continue;
> +#ifdef CONFIG_ACPI_HOTPLUG_MEMORY_AUTO_ONLINE
> +		if (mem_hotadd_auto) {
> +			result = online_pages(info->start_addr >> PAGE_SHIFT,
> +					      info->length >> PAGE_SHIFT);
> +			if (!result)
> +				set_memory_state(info->start_addr >> PAGE_SHIFT,
> +						 info->length >> PAGE_SHIFT,
> +						 MEM_ONLINE);
> +			else
> +				printk("Memory online failed.\n");

Printks with constant text are one of my pet peeves because they don't
give any clues for debugging.  Surely there's useful information we
could include here, like the ACPI device info (maybe using dev_err()),
the memory range, etc?

Bjorn
