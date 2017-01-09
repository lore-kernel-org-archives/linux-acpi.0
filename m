From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: 174cc7187e6f ACPICA: Tables: Back port
 acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux
 kernel
Date: Mon, 9 Jan 2017 14:18:31 -0800
Message-ID: <20170109221831.GC3800@linux.vnet.ibm.com>
References: <CAJZ5v0jtGo207YmBGDw55uCV+3sp-QX2Gx7cup-4e8ESjnHhrQ@mail.gmail.com>
 <20170108003730.hlcqkhdxtah65z66@pd.tnic>
 <CAJZ5v0jgdctHEEOaAUBNZZPb=ni_DLdkJtmiDkvVP4WQUYr3rA@mail.gmail.com>
 <20170108010158.b62eovaxsbmhfnkb@pd.tnic>
 <CAJZ5v0hxrz9os4ZpS=EHbdFp8rd7D+BU10bSyfBV-FE6UHQ6FA@mail.gmail.com>
 <CAJZ5v0idFBHG=OKRiBqvsYPgUrWQsqjTKYXfKxfdG023qsCbkw@mail.gmail.com>
 <20170108130355.vxhjmj6dlkqw6hyq@pd.tnic>
 <1AE640813FDE7649BE1B193DEA596E886CE27B7E@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E886CE27BEE@SHSMSX101.ccr.corp.intel.com>
 <20170109093329.jd7uwlcpci4icpd3@pd.tnic>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170109093329.jd7uwlcpci4icpd3@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, J?rg R?del <joro@8bytes.org>, lkml <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 09, 2017 at 10:33:29AM +0100, Borislav Petkov wrote:
> + Paul for comment.
> 
> Leaving in the rest for him.
> 
> On Mon, Jan 09, 2017 at 02:36:33AM +0000, Zheng, Lv wrote:
> > Hi,
> > 
> > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Zheng,
> > > Lv
> > > Subject: RE: 174cc7187e6f ACPICA: Tables: Back port acpi_get_table_with_size() and
> > > early_acpi_os_unmap_memory() from Linux kernel
> > > 
> > > Hi,
> > > 
> > > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of
> > > Borislav
> > > > Petkov
> > > > Subject: Re: 174cc7187e6f ACPICA: Tables: Back port acpi_get_table_with_size() and
> > > > early_acpi_os_unmap_memory() from Linux kernel
> > > >
> > > > On Sun, Jan 08, 2017 at 03:20:20AM +0100, Rafael J. Wysocki wrote:
> > > > >  drivers/iommu/amd_iommu_init.c |    2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > Index: linux-pm/drivers/iommu/amd_iommu_init.c
> > > > > ===================================================================
> > > > > --- linux-pm.orig/drivers/iommu/amd_iommu_init.c
> > > > > +++ linux-pm/drivers/iommu/amd_iommu_init.c
> > > > > @@ -2230,7 +2230,7 @@ static int __init early_amd_iommu_init(v
> > > > >  	 */
> > > > >  	ret = check_ivrs_checksum(ivrs_base);
> > > > >  	if (ret)
> > > > > -		return ret;
> > > > > +		goto out;
> > > > >
> > > > >  	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
> > > > >  	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
> > > >
> > > > Good catch, this one needs to be applied regardless.
> > > >
> > > > However, it doesn't fix my issue though.
> > > >
> > > > But I think I have it - I went and applied the well-proven debugging
> > > > technique of sprinkling printks around. Here's what I'm seeing:
> > > >
> > > > early_amd_iommu_init()
> > > > |-> acpi_put_table(ivrs_base);
> > > > |-> acpi_tb_put_table(table_desc);
> > > > |-> acpi_tb_invalidate_table(table_desc);
> > > > |-> acpi_tb_release_table(...)
> > > > |-> acpi_os_unmap_memory
> > > > |-> acpi_os_unmap_iomem
> > > > |-> acpi_os_map_cleanup
> > > > |-> synchronize_rcu_expedited	<-- the kernel/rcu/tree_exp.h version with CONFIG_PREEMPT_RCU=y
> > > >
> > > > Now that function goes and sends IPIs, i.e., schedule_work()
> > > > but this is too early - we haven't even done workqueue_init().
> > > > Actually, from looking at the callstack, we do
> > > > kernel_init_freeable->native_smp_prepare_cpus() and workqueue_init()
> > > > comes next.
> > > >
> > > > And this makes sense because the splat rIP points to __queue_work() but
> > > > we haven't done that yet.
> > > >
> > > > So that acpi_put_table() is happening too early. Looks like AMD IOMMU
> > > > should not put the table but WTH do I know?!
> > > >
> > > > In any case, commenting out:
> > > >
> > > >         acpi_put_table(ivrs_base);
> > > >         ivrs_base = NULL;
> > > >
> > > > and the end of early_amd_iommu_init() makes the box boot again.
> > > 
> > > So please help to comment out these 2 lines (with descriptions and do not delete them).
> > > Until acpi_os_unmap_memory() is able to handle such an early case.
> > 
> > IMO, synchronize_rcu_expedited() should be improved:
> > If rcu_init() isn't called or there is nothing to synchronize, schedule_work() shouldn't be invoked.

Indeed it should!

Does the (untested) patch below fix things for you?

If so, does this need to go into 4.10?  (My default workflow would get
it into 4.11 or 4.12, so please speak up if you need it.)

							Thanx, Paul

------------------------------------------------------------------------

commit 1b7feb708241f1662cfd529118468c9f9c0b1449
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
