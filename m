From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port
 acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
 kernel
Date: Mon, 9 Jan 2017 15:52:06 -0800
Message-ID: <20170109235206.GH3800@linux.vnet.ibm.com>
References: <CAJZ5v0hxrz9os4ZpS=EHbdFp8rd7D+BU10bSyfBV-FE6UHQ6FA@mail.gmail.com>
 <CAJZ5v0idFBHG=OKRiBqvsYPgUrWQsqjTKYXfKxfdG023qsCbkw@mail.gmail.com>
 <20170108130355.vxhjmj6dlkqw6hyq@pd.tnic>
 <1AE640813FDE7649BE1B193DEA596E886CE27B7E@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CE27BEE@SHSMSX101.ccr.corp.intel.com>
 <20170109093329.jd7uwlcpci4icpd3@pd.tnic>
 <20170109221831.GC3800@linux.vnet.ibm.com>
 <20170109231501.xrhwsv46mznw3kqt@pd.tnic>
 <20170109233204.GG3800@linux.vnet.ibm.com>
 <20170109234039.mfefmv5dv4shxnfn@pd.tnic>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36639 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1764424AbdAIXwN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2017 18:52:13 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id v09NnExc034367
        for <linux-acpi@vger.kernel.org>; Mon, 9 Jan 2017 18:52:12 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 27vd122853-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-acpi@vger.kernel.org>; Mon, 09 Jan 2017 18:52:12 -0500
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-acpi@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Jan 2017 16:52:11 -0700
Content-Disposition: inline
In-Reply-To: <20170109234039.mfefmv5dv4shxnfn@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, J?rg R?del <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Tue, Jan 10, 2017 at 12:40:39AM +0100, Borislav Petkov wrote:
> On Mon, Jan 09, 2017 at 03:32:04PM -0800, Paul E. McKenney wrote:
> > We could move rcu_scheduler_starting() later, as long as there
> > is no chance of preemption or context switch before it is invoked.
> > Would that help in this case, or are we already context switching before
> > acpi_os_map_cleanup() is invoked?  (If we are already context switching,
> > short-circuiting synchronize_rcu_expedited() would be a bug.)
> 
> Hmm, how about the below?
> 
> It would still happen before
> 
>         /*
>          * The boot idle thread must execute schedule()
>          * at least once to get things moving:
>          */
>         init_idle_bootup_task(current);
>         schedule_preempt_disabled();
> 
> in rest_init() and right after native_smp_prepare_cpus() which is where
> we're splatting.
> 
> Lemme run it.
> 
> Even if it works, we would have to stress-test this seriously...

Yeah, the call to wait_for_completion() at the beginning of
kernel_init_freeable() makes me extremely nervous.  Even if it does
happen to work, this looks like an accident waiting to happen.

Is it possible to instead move the ACPI initialization to follow the
workqueue initialization?

							Thanx, Paul

> ---
> diff --git a/init/main.c b/init/main.c
> index b0c9d6facef9..9be221cc87c3 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -385,7 +385,6 @@ static noinline void __ref rest_init(void)
>  {
>  	int pid;
> 
> -	rcu_scheduler_starting();
>  	/*
>  	 * We need to spawn init first so that it obtains pid 1, however
>  	 * the init task will end up wanting to create kthreads, which, if
> @@ -1019,6 +1018,8 @@ static noinline void __init kernel_init_freeable(void)
> 
>  	smp_prepare_cpus(setup_max_cpus);
> 
> +	rcu_scheduler_starting();
> +
>  	workqueue_init();
> 
>  	do_pre_smp_initcalls();
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.
> 

