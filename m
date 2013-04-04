From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 04/20] x86, ACPI: Increase override tables number limit
Date: Thu, 4 Apr 2013 10:50:17 -0700
Message-ID: <20130404175017.GS9425@htj.dyndns.org>
References: <1362897887-30808-1-git-send-email-yinghai@kernel.org>
 <1362897887-30808-5-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:53168 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764142Ab3DDRuW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Apr 2013 13:50:22 -0400
Content-Disposition: inline
In-Reply-To: <1362897887-30808-5-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Renninger <trenn@suse.de>, Tang Chen <tangchen@cn.fujitsu.com>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org

On Sat, Mar 09, 2013 at 10:44:31PM -0800, Yinghai Lu wrote:
> Current acpi tables in initrd is limited to 10, that is too small.
> 64 should be good enough as we have 35 sigs and could have several
> SSDT.
> 
> Two problems in current code prevent us from increasing limit:
> 1. that cpio file info array is put in stack, as every element is 32
>    bytes, could run out of stack if we have that array size to 64.
>    We can move it out from stack, and make it as global and put it in
>    __initdata section.
> 2. early_ioremap only can remap 256k one time. Current code is mapping
>    10 tables one time. If we increase that limit, whole size could be
>    more than 256k, early_ioremap will fail with that.
>    We can map table one by one during copying, instead of mapping
>    all them one time.
> 
> -v2: According to tj, split it out to separated patch, also
>      rename array name to acpi_initrd_files.
> 
> Signed-off-by: Yinghai <yinghai@kernel.org>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: linux-acpi@vger.kernel.org

Acked-by: Tejun Heo <tj@kernel.org>

> @@ -648,14 +647,14 @@ void __init acpi_initrd_override(void *data, size_t size)
>  	memblock_reserve(acpi_tables_addr, acpi_tables_addr + all_tables_size);
>  	arch_reserve_mem_area(acpi_tables_addr, all_tables_size);
>  
> -	p = early_ioremap(acpi_tables_addr, all_tables_size);
> -

It'd be nice to have a brief comment here explaining why we're mapping
each table separately.

>  	for (no = 0; no < table_nr; no++) {
> -		memcpy(p + total_offset, early_initrd_files[no].data,
> -		       early_initrd_files[no].size);
> -		total_offset += early_initrd_files[no].size;
> +		phys_addr_t size = acpi_initrd_files[no].size;
> +
> +		p = early_ioremap(acpi_tables_addr + total_offset, size);
> +		memcpy(p, acpi_initrd_files[no].data, size);
> +		early_iounmap(p, size);
> +		total_offset += size;
>  	}
> -	early_iounmap(p, all_tables_size);

Thanks.

-- 
tejun
