From: Borislav Petkov <bp@alien8.de>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port
 acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
 kernel
Date: Tue, 10 Jan 2017 00:15:01 +0100
Message-ID: <20170109231501.xrhwsv46mznw3kqt@pd.tnic>
References: <20170108003730.hlcqkhdxtah65z66@pd.tnic>
 <CAJZ5v0jgdctHEEOaAUBNZZPb=ni_DLdkJtmiDkvVP4WQUYr3rA@mail.gmail.com>
 <20170108010158.b62eovaxsbmhfnkb@pd.tnic>
 <CAJZ5v0hxrz9os4ZpS=EHbdFp8rd7D+BU10bSyfBV-FE6UHQ6FA@mail.gmail.com>
 <CAJZ5v0idFBHG=OKRiBqvsYPgUrWQsqjTKYXfKxfdG023qsCbkw@mail.gmail.com>
 <20170108130355.vxhjmj6dlkqw6hyq@pd.tnic>
 <1AE640813FDE7649BE1B193DEA596E886CE27B7E@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CE27BEE@SHSMSX101.ccr.corp.intel.com>
 <20170109093329.jd7uwlcpci4icpd3@pd.tnic>
 <20170109221831.GC3800@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:44979 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932978AbdAIXPF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 9 Jan 2017 18:15:05 -0500
Content-Disposition: inline
In-Reply-To: <20170109221831.GC3800@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, J?rg R?del <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Mon, Jan 09, 2017 at 02:18:31PM -0800, Paul E. McKenney wrote:
> @@ -690,6 +690,8 @@ void synchronize_rcu_expedited(void)
>  {
>  	struct rcu_state *rsp = rcu_state_p;
>  
> +	if (!rcu_scheduler_active)
> +		return;
>  	_synchronize_rcu_expedited(rsp, sync_rcu_exp_handler);
>  }
>  EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);

That doesn't work and it is because of those damn what goes before what
boot sequence issues :-\

We have:

rest_init()
|-> rcu_scheduler_starting()  ---> that sets rcu_scheduler_active = 1;
|-> kernel_thread(kernel_init, NULL, CLONE_FS);
|-> kernel_init()
|-> kernel_init_freeable()
|-> native_smp_prepare_cpus(setup_max_cpus)
|-> default_setup_apic_routing
|-> enable_IR_x2apic
|-> irq_remapping_prepare
|-> amd_iommu_prepare
|-> iommu_go_to_state
|-> acpi_put_table(ivrs_base);
|-> acpi_tb_put_table(table_desc);
|-> acpi_tb_invalidate_table(table_desc);
|-> acpi_tb_release_table(...)
|-> acpi_os_unmap_memory
|-> acpi_os_unmap_iomem
|-> acpi_os_map_cleanup
|-> synchronize_rcu_expedited()

Now here we have rcu_scheduler_active already set so the test doesn't
hit and we hang.

So we must do it differently.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
