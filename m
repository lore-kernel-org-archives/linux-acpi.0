From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port
 acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
 kernel
Date: Mon, 9 Jan 2017 15:14:16 -0800
Message-ID: <20170109231416.GF3800@linux.vnet.ibm.com>
References: <CAJZ5v0jgdctHEEOaAUBNZZPb=ni_DLdkJtmiDkvVP4WQUYr3rA@mail.gmail.com>
 <20170108010158.b62eovaxsbmhfnkb@pd.tnic>
 <CAJZ5v0hxrz9os4ZpS=EHbdFp8rd7D+BU10bSyfBV-FE6UHQ6FA@mail.gmail.com>
 <CAJZ5v0idFBHG=OKRiBqvsYPgUrWQsqjTKYXfKxfdG023qsCbkw@mail.gmail.com>
 <20170108130355.vxhjmj6dlkqw6hyq@pd.tnic>
 <1AE640813FDE7649BE1B193DEA596E886CE27B7E@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CE27BEE@SHSMSX101.ccr.corp.intel.com>
 <20170109093329.jd7uwlcpci4icpd3@pd.tnic>
 <20170109221831.GC3800@linux.vnet.ibm.com>
 <CAJZ5v0hVJ0BOYqoDX4yoprSzgShOpskw5L3FdPGP=CRKH1NyRg@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36293 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S942100AbdAIXOX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Jan 2017 18:14:23 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id v09NDvK6008613
        for <linux-acpi@vger.kernel.org>; Mon, 9 Jan 2017 18:14:22 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
        by mx0a-001b2d01.pphosted.com with ESMTP id 27vjr32ket-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-acpi@vger.kernel.org>; Mon, 09 Jan 2017 18:14:22 -0500
Received: from localhost
        by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-acpi@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 9 Jan 2017 16:14:20 -0700
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hVJ0BOYqoDX4yoprSzgShOpskw5L3FdPGP=CRKH1NyRg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, J?rg R?del <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>

On Mon, Jan 09, 2017 at 11:25:39PM +0100, Rafael J. Wysocki wrote:
> Hi Paul,
> 
> On Mon, Jan 9, 2017 at 11:18 PM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Mon, Jan 09, 2017 at 10:33:29AM +0100, Borislav Petkov wrote:
> >> + Paul for comment.
> >>
> >> Leaving in the rest for him.
> >>
> >> On Mon, Jan 09, 2017 at 02:36:33AM +0000, Zheng, Lv wrote:
> >> > Hi,
> >> >
> >> > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Zheng,
> >> > > Lv
> >> > > Subject: RE: 174cc7187e6f ACPICA: Tables: Back port acpi_get_table_with_size() and
> >> > > early_acpi_os_unmap_memory() from Linux kernel
> >> > >
> >> > > Hi,
> >> > >
> >> > > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of
> >> > > Borislav
> >> > > > Petkov
> >> > > > Subject: Re: 174cc7187e6f ACPICA: Tables: Back port acpi_get_table_with_size() and
> >> > > > early_acpi_os_unmap_memory() from Linux kernel
> >> > > >
> >> > > > On Sun, Jan 08, 2017 at 03:20:20AM +0100, Rafael J. Wysocki wrote:
> >> > > > >  drivers/iommu/amd_iommu_init.c |    2 +-
> >> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> > > > >
> >> > > > > Index: linux-pm/drivers/iommu/amd_iommu_init.c
> >> > > > > ===================================================================
> >> > > > > --- linux-pm.orig/drivers/iommu/amd_iommu_init.c
> >> > > > > +++ linux-pm/drivers/iommu/amd_iommu_init.c
> >> > > > > @@ -2230,7 +2230,7 @@ static int __init early_amd_iommu_init(v
> >> > > > >        */
> >> > > > >       ret = check_ivrs_checksum(ivrs_base);
> >> > > > >       if (ret)
> >> > > > > -             return ret;
> >> > > > > +             goto out;
> >> > > > >
> >> > > > >       amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
> >> > > > >       DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
> >> > > >
> >> > > > Good catch, this one needs to be applied regardless.
> >> > > >
> >> > > > However, it doesn't fix my issue though.
> >> > > >
> >> > > > But I think I have it - I went and applied the well-proven debugging
> >> > > > technique of sprinkling printks around. Here's what I'm seeing:
> >> > > >
> >> > > > early_amd_iommu_init()
> >> > > > |-> acpi_put_table(ivrs_base);
> >> > > > |-> acpi_tb_put_table(table_desc);
> >> > > > |-> acpi_tb_invalidate_table(table_desc);
> >> > > > |-> acpi_tb_release_table(...)
> >> > > > |-> acpi_os_unmap_memory
> >> > > > |-> acpi_os_unmap_iomem
> >> > > > |-> acpi_os_map_cleanup
> >> > > > |-> synchronize_rcu_expedited   <-- the kernel/rcu/tree_exp.h version with CONFIG_PREEMPT_RCU=y
> >> > > >
> >> > > > Now that function goes and sends IPIs, i.e., schedule_work()
> >> > > > but this is too early - we haven't even done workqueue_init().
> >> > > > Actually, from looking at the callstack, we do
> >> > > > kernel_init_freeable->native_smp_prepare_cpus() and workqueue_init()
> >> > > > comes next.
> >> > > >
> >> > > > And this makes sense because the splat rIP points to __queue_work() but
> >> > > > we haven't done that yet.
> >> > > >
> >> > > > So that acpi_put_table() is happening too early. Looks like AMD IOMMU
> >> > > > should not put the table but WTH do I know?!
> >> > > >
> >> > > > In any case, commenting out:
> >> > > >
> >> > > >         acpi_put_table(ivrs_base);
> >> > > >         ivrs_base = NULL;
> >> > > >
> >> > > > and the end of early_amd_iommu_init() makes the box boot again.
> >> > >
> >> > > So please help to comment out these 2 lines (with descriptions and do not delete them).
> >> > > Until acpi_os_unmap_memory() is able to handle such an early case.
> >> >
> >> > IMO, synchronize_rcu_expedited() should be improved:
> >> > If rcu_init() isn't called or there is nothing to synchronize, schedule_work() shouldn't be invoked.
> >
> > Indeed it should!
> >
> > Does the (untested) patch below fix things for you?
> >
> > If so, does this need to go into 4.10?  (My default workflow would get
> > it into 4.11 or 4.12, so please speak up if you need it.)
> 
> Yes it should go into 4.10 (if it fixes the problem) as the reported
> regression was introduced in 4.10-rc1.

OK, I will test with rcutorture, but I also need a Tested-by for the
specific problem at hand.

> > ------------------------------------------------------------------------
> >
> > commit 1b7feb708241f1662cfd529118468c9f9c0b1449
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Mon Jan 9 14:10:50 2017 -0800
> >
> >     rcu: Make synchronize_rcu_expedited() safe for early boot
> >
> >     The synchronize_rcu_expedited() function does not check for early-boot
> >     use, which can result in failures if it is invoked before the scheduler
> >     has started.  Given that the rcupdate.rcu_expedited kernel parameter
> >     causes all calls to synchronize_rcu() to be directed instead to
> >     synchronize_rcu_expedited(), a usage restriction does not make sense.
> >
> >     This commit therefore adds a rcu_scheduler_active check to
> >     synchronize_rcu_expedited(), so that it is a no-op before the scheduler
> >     starts.  This behavior is correct because there is only a single CPU
> >     running during that time.
> >
> >     Reported-by: Lv Zheng <lv.zheng@intel.com>
> >     Reported-by: Borislav Petkov <bp@alien8.de>
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> When applying this, please also add:
> 
> Fixes: 174cc7187e6f ("ACPICA: Tables: Back port
> acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
> kernel")
> Link: https://lkml.kernel.org/r/4034dde8-ffc1-18e2-f40c-00cf37471793@intel.com

Like this?

							Thanx, Paul

------------------------------------------------------------------------

commit 9ae87e58f7c40b39ff80737e3375672f16316d23
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Mon Jan 9 14:10:50 2017 -0800

    rcu: Make synchronize_rcu_expedited() safe for early boot
    
    The synchronize_rcu_expedited() function does not check for early-boot
    use, which can result in failures if it is invoked before the scheduler
    has started.  Given that the rcupdate.rcu_expedited kernel parameter
    causes all calls to synchronize_rcu() to be directed instead to
    synchronize_rcu_expedited(), a usage restriction does not make sense.
    
    This commit therefore adds a rcu_scheduler_active check to
    synchronize_rcu_expedited(), so that it is a no-op before the scheduler
    starts.  This behavior is correct because there is only a single CPU
    running during that time.
    
    Reported-by: Lv Zheng <lv.zheng@intel.com>
    Reported-by: Borislav Petkov <bp@alien8.de>
    Fixes: 174cc7187e6f ("ACPICA: Tables: Back port acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux kernel")
    Link: Link: https://lkml.kernel.org/r/4034dde8-ffc1-18e2-f40c-00cf37471793@intel.com
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index dfc3ba5a429e..a6c3d86480de 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -690,6 +690,8 @@ void synchronize_rcu_expedited(void)
 {
 	struct rcu_state *rsp = rcu_state_p;
 
+	if (!rcu_scheduler_active)
+		return;
 	_synchronize_rcu_expedited(rsp, sync_rcu_exp_handler);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);

