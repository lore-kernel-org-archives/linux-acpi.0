From: Baoquan He <bhe@redhat.com>
Subject: Re: [Patch v3 1/2] x86/mm/numa: Open code function
 early_get_boot_cpu_id
Date: Sun, 7 Aug 2016 16:09:54 +0800
Message-ID: <20160807080954.GB16660@x1.redhat.com>
References: <1469877001-18393-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39312 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbcHGIJ7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 7 Aug 2016 04:09:59 -0400
Content-Disposition: inline
In-Reply-To: <1469877001-18393-1-git-send-email-bhe@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mingo@kernel.org
Cc: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

Hi Ingo,

Ping,

Do you have another comment to this two patches?

Thanks
Baoquan

On 07/30/16 at 07:10pm, Baoquan He wrote:
> Previously early_acpi_boot_init is called in early_get_boot_cpu_id()
> to get value for boot_cpu_physical_apicid. Now early_acpi_boot_init()
> has been taken out and moved to setup_arch(), the name of
> early_get_boot_cpu_id doesn't match its implementation. And only the
> getting boot-time SMP configuration code is left. So in this patch
> open code it.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
> v1->v3:
>   No change from v1.
> 
>  arch/x86/mm/amdtopology.c | 25 ++++++++-----------------
>  1 file changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/mm/amdtopology.c b/arch/x86/mm/amdtopology.c
> index 2ca15b59..9928dad 100644
> --- a/arch/x86/mm/amdtopology.c
> +++ b/arch/x86/mm/amdtopology.c
> @@ -53,21 +53,6 @@ static __init int find_northbridge(void)
>  	return -ENOENT;
>  }
>  
> -static __init void early_get_boot_cpu_id(void)
> -{
> -	/*
> -	 * need to get the APIC ID of the BSP so can use that to
> -	 * create apicid_to_node in amd_scan_nodes()
> -	 */
> -#ifdef CONFIG_X86_MPPARSE
> -	/*
> -	 * get boot-time SMP configuration:
> -	 */
> -	if (smp_found_config)
> -		early_get_smp_config();
> -#endif
> -}
> -
>  int __init amd_numa_init(void)
>  {
>  	u64 start = PFN_PHYS(0);
> @@ -181,8 +166,14 @@ int __init amd_numa_init(void)
>  	cores = 1 << bits;
>  	apicid_base = 0;
>  
> -	/* get the APIC ID of the BSP early for systems with apicid lifting */
> -	early_get_boot_cpu_id();
> +#ifdef CONFIG_X86_MPPARSE
> +	/*
> +	 * get boot-time SMP configuration:
> +	 */
> +	if (smp_found_config)
> +		early_get_smp_config();
> +#endif
> +
>  	if (boot_cpu_physical_apicid > 0) {
>  		pr_info("BSP APIC ID: %02x\n", boot_cpu_physical_apicid);
>  		apicid_base = boot_cpu_physical_apicid;
> -- 
> 2.5.5
> 
