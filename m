From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [RFC PATCH]: ACPI: Automatically online hot-added memory
Date: Tue, 9 Mar 2010 15:42:43 +0000
Message-ID: <20100309154243.GA26520@srcf.ucam.org>
References: <20100309141203.10037.62453.sendpatchset@prarit.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:54489 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194Ab0CIPmp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Mar 2010 10:42:45 -0500
Content-Disposition: inline
In-Reply-To: <20100309141203.10037.62453.sendpatchset@prarit.bos.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-acpi@vger.kernel.org

On Tue, Mar 09, 2010 at 09:12:03AM -0500, Prarit Bhargava wrote:
> New sockets have on-die memory controllers.  This means that in certain
> HW configurations the memory behind the socket comes and goes as the socket
> is physically enabled and disabled.
> 
> Since the cpu bringup code does on node memory allocations, the memory on the
> added socket must be onlined first.
> 
> Add a .config option to automatically online hot added memory, and enable it
> in the acpi memory add path.

This seems like the right thing to do.

> +config ACPI_HOTPLUG_MEMORY_AUTO_ONLINE
> +	bool "Automatically online hotplugged memory"
> +	depends on ACPI_HOTPLUG_MEMORY
> +	default n

default !S390? default x86?

> +		result = online_pages(info->start_addr >> PAGE_SHIFT,
> +				      info->length >> PAGE_SHIFT);
> +		if (!result)
> +			set_memory_state(info->start_addr, MEM_ONLINE);
> +		else
> +			printk("Memory online failed.\n");

That probably wants to be more descriptive and have a loglevel. What 
happens if this fails? The CPU presumably can't be brought up?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
