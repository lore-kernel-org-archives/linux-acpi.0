From: Borislav Petkov <bp@alien8.de>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port
 acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
 kernel
Date: Sun, 8 Jan 2017 14:03:56 +0100
Message-ID: <20170108130355.vxhjmj6dlkqw6hyq@pd.tnic>
References: <20170107204227.bwdb5yzrjpiggkmo@pd.tnic>
 <4034dde8-ffc1-18e2-f40c-00cf37471793@intel.com>
 <20170108000702.wrov5ajeou2y3tuy@pd.tnic>
 <CAJZ5v0jtGo207YmBGDw55uCV+3sp-QX2Gx7cup-4e8ESjnHhrQ@mail.gmail.com>
 <20170108003730.hlcqkhdxtah65z66@pd.tnic>
 <CAJZ5v0jgdctHEEOaAUBNZZPb=ni_DLdkJtmiDkvVP4WQUYr3rA@mail.gmail.com>
 <20170108010158.b62eovaxsbmhfnkb@pd.tnic>
 <CAJZ5v0hxrz9os4ZpS=EHbdFp8rd7D+BU10bSyfBV-FE6UHQ6FA@mail.gmail.com>
 <CAJZ5v0idFBHG=OKRiBqvsYPgUrWQsqjTKYXfKxfdG023qsCbkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:55984 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754096AbdAHNEB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 8 Jan 2017 08:04:01 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0idFBHG=OKRiBqvsYPgUrWQsqjTKYXfKxfdG023qsCbkw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Sun, Jan 08, 2017 at 03:20:20AM +0100, Rafael J. Wysocki wrote:
>  drivers/iommu/amd_iommu_init.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/iommu/amd_iommu_init.c
> ===================================================================
> --- linux-pm.orig/drivers/iommu/amd_iommu_init.c
> +++ linux-pm/drivers/iommu/amd_iommu_init.c
> @@ -2230,7 +2230,7 @@ static int __init early_amd_iommu_init(v
>  	 */
>  	ret = check_ivrs_checksum(ivrs_base);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
>  	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);

Good catch, this one needs to be applied regardless.

However, it doesn't fix my issue though.

But I think I have it - I went and applied the well-proven debugging
technique of sprinkling printks around. Here's what I'm seeing:

early_amd_iommu_init()
|-> acpi_put_table(ivrs_base);
|-> acpi_tb_put_table(table_desc);
|-> acpi_tb_invalidate_table(table_desc);
|-> acpi_tb_release_table(...)
|-> acpi_os_unmap_memory
|-> acpi_os_unmap_iomem
|-> acpi_os_map_cleanup
|-> synchronize_rcu_expedited	<-- the kernel/rcu/tree_exp.h version with CONFIG_PREEMPT_RCU=y

Now that function goes and sends IPIs, i.e., schedule_work()
but this is too early - we haven't even done workqueue_init().
Actually, from looking at the callstack, we do
kernel_init_freeable->native_smp_prepare_cpus() and workqueue_init()
comes next.

And this makes sense because the splat rIP points to __queue_work() but
we haven't done that yet.

So that acpi_put_table() is happening too early. Looks like AMD IOMMU
should not put the table but WTH do I know?!

In any case, commenting out:

        acpi_put_table(ivrs_base);
        ivrs_base = NULL;

and the end of early_amd_iommu_init() makes the box boot again.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
