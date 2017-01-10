From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port
 acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
 kernel
Date: Mon, 9 Jan 2017 16:21:02 -0800
Message-ID: <20170110002102.GI3800@linux.vnet.ibm.com>
References: <CAJZ5v0hxrz9os4ZpS=EHbdFp8rd7D+BU10bSyfBV-FE6UHQ6FA@mail.gmail.com>
 <CAJZ5v0idFBHG=OKRiBqvsYPgUrWQsqjTKYXfKxfdG023qsCbkw@mail.gmail.com>
 <20170108130355.vxhjmj6dlkqw6hyq@pd.tnic>
 <1AE640813FDE7649BE1B193DEA596E886CE27B7E@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CE27BEE@SHSMSX101.ccr.corp.intel.com>
 <20170109093329.jd7uwlcpci4icpd3@pd.tnic>
 <20170109221831.GC3800@linux.vnet.ibm.com>
 <20170109231501.xrhwsv46mznw3kqt@pd.tnic>
 <20170109233204.GG3800@linux.vnet.ibm.com>
 <CAJZ5v0hnperiMk7tz7G6hqwuo4XTkzCjR-N2KC43QuVQoV6AgA@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34005 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756739AbdAJAVJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2017 19:21:09 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id v0A0IWxe079185
        for <linux-acpi@vger.kernel.org>; Mon, 9 Jan 2017 19:21:09 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0a-001b2d01.pphosted.com with ESMTP id 27vcm4v5wr-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-acpi@vger.kernel.org>; Mon, 09 Jan 2017 19:21:08 -0500
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-acpi@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Jan 2017 17:21:07 -0700
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hnperiMk7tz7G6hqwuo4XTkzCjR-N2KC43QuVQoV6AgA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, J?rg R?del <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Tue, Jan 10, 2017 at 12:42:47AM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 10, 2017 at 12:32 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Tue, Jan 10, 2017 at 12:15:01AM +0100, Borislav Petkov wrote:
> >> On Mon, Jan 09, 2017 at 02:18:31PM -0800, Paul E. McKenney wrote:
> >> > @@ -690,6 +690,8 @@ void synchronize_rcu_expedited(void)
> >> >  {
> >> >     struct rcu_state *rsp = rcu_state_p;
> >> >
> >> > +   if (!rcu_scheduler_active)
> >> > +           return;
> >> >     _synchronize_rcu_expedited(rsp, sync_rcu_exp_handler);
> >> >  }
> >> >  EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
> >>
> >> That doesn't work and it is because of those damn what goes before what
> >> boot sequence issues :-\
> >>
> >> We have:
> >>
> >> rest_init()
> >> |-> rcu_scheduler_starting()  ---> that sets rcu_scheduler_active = 1;
> >> |-> kernel_thread(kernel_init, NULL, CLONE_FS);
> >> |-> kernel_init()
> >> |-> kernel_init_freeable()
> >> |-> native_smp_prepare_cpus(setup_max_cpus)
> >> |-> default_setup_apic_routing
> >> |-> enable_IR_x2apic
> >> |-> irq_remapping_prepare
> >> |-> amd_iommu_prepare
> >> |-> iommu_go_to_state
> >> |-> acpi_put_table(ivrs_base);
> >> |-> acpi_tb_put_table(table_desc);
> >> |-> acpi_tb_invalidate_table(table_desc);
> >> |-> acpi_tb_release_table(...)
> >> |-> acpi_os_unmap_memory
> >> |-> acpi_os_unmap_iomem
> >> |-> acpi_os_map_cleanup
> >> |-> synchronize_rcu_expedited()
> >>
> >> Now here we have rcu_scheduler_active already set so the test doesn't
> >> hit and we hang.
> >>
> >> So we must do it differently.
> >
> > Yeah, there is a window just as the scheduler is starting where things don't
> > work.
> >
> > We could move rcu_scheduler_starting() later, as long as there
> > is no chance of preemption or context switch before it is invoked.
> > Would that help in this case, or are we already context switching before
> > acpi_os_map_cleanup() is invoked?
> 
> In the particular AMD IOMMU case it doesn't look like we are, but we
> do in other cases.
> 
> > (If we are already context switching,
> > short-circuiting synchronize_rcu_expedited() would be a bug.)
> 
> It may be easier to make the caller avoid RCU synchronization
> altogether if that's not necessary and the caller should actually be
> able to figure out when that's the case.
> 
> The patch from Lv at https://patchwork.kernel.org/patch/9504277/ goes
> in the right direction IMO, but I'm not yet convinced that this is the
> right one.

>From the RCU end, I could force expedited grace periods to translate to
normal grace periods during that window of time, and then make sure that
RCU's grace-period kthreads are spawned beforehand.  Looking into this...

							Thanx, Paul

