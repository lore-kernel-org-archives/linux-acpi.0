From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH 1/6] acpi, numa, mem_hotplug: Kill save_add_info().
Date: Mon, 19 Aug 2013 12:48:00 -0600
Message-ID: <1376938080.10300.453.camel@misato.fc.hp.com>
References: <1376636809-10159-1-git-send-email-tangchen@cn.fujitsu.com>
	 <1376636809-10159-2-git-send-email-tangchen@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0187.atlanta.hp.com ([15.193.32.64]:20133 "EHLO
	g6t0187.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820Ab3HSStX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Aug 2013 14:49:23 -0400
In-Reply-To: <1376636809-10159-2-git-send-email-tangchen@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tang Chen <tangchen@cn.fujitsu.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, lenb@kernel.org, rjw@sisk.pl, liwanp@linux.vnet.ibm.com, tj@kernel.org, akpm@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, 2013-08-16 at 15:06 +0800, Tang Chen wrote:
> save_add_info() is defined as:
> 
> 	#ifdef CONFIG_MEMORY_HOTPLUG
> 	static inline int save_add_info(void) {return 1;}
> 	#else
> 	static inline int save_add_info(void) {return 0;}
> 	#endif
> 
> which means it is true when memory hotplug is configured.
> 
> In acpi_numa_memory_affinity_init(), it checks the memory hotplug
> flag in SRAT memory affinity and save_add_info() like this:
> 
> 	if ((ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && !save_add_info())
> 		goto out_err;
> 	......
> 	node = setup_node(pxm);
> 	numa_add_memblk(node, start, end);
> 	......
> 
> which means if the memory range is hotpluggable, but memory hotplug is not
> configured, it won't add these memory to numa_meminfo.
> 
> After this, numa_meminfo_cover_memory() will fail, which will finally cause
> numa_init() to fail.
> 
> numa_init()
>  |->numa_register_memblks()
>      |->numa_meminfo_cover_memory()
> 
> When numa_init() fails, it will fallback to numa_init(dummy_numa_init), and
> all numa architecture will not be setup.
> 
> This is nonsense. Even if memory hotplug is not configured, we can also use
> numa architecture.
> 
> Actually, save_add_info() is added by commit 71efa8fdc55e70ec6687c897a30759f0a2c2ad7e
> in 2006. And now it is useless.
> 
> So this patch kill save_add_info() and the nonsense checking.
> 
> Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>

Good catch!

Acked-by: Toshi Kani <toshi.kani@hp.com>

Thanks,
-Toshi

