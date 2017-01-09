From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] ACPI / OSL: Fix rcu synchronization logic
Date: Mon, 9 Jan 2017 11:14:29 +0100
Message-ID: <20170109101428.liv4d5bkcn36czdv@pd.tnic>
References: <1483955769-9579-1-git-send-email-lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1483955769-9579-1-git-send-email-lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Huang Ying <ying.huang@intel.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 09, 2017 at 05:56:09PM +0800, Lv Zheng wrote:
> The rcu synchronization logic is originally provided to protect
> apei_read()/apei_write() as in the APEI drivers, there is NMI event source
> requiring non spinlock based synchronization mechanism.
> 
> After that, ACPI developers think FADT registers may also require same
> facility, so they moved the RCU stuffs to generic ACPI layer.
> 
> So now non-task-context ACPI map lookup is only protected by RCU.
> 
> This triggers problem as acpi_os_map_memory()/acpi_os_unmap_memory() can be
> used to map/unmap tables as long as to map/unmap ACPI registers. When it is
> used for the ACPI tables, the caller could invoke this very early. When it
> is invoked earlier than workqueue_init() and later than
> check_early_ioremp_leak(), invoking synchronize_rcu_expedited() can cause a
> kernel hang.
> 
> Actually this facility is only used to protect non-task-context ACPI map
> lookup, and such mappings are only introduced by
> acpi_os_map_generic_address(). So before it is invoked, there is no need to
> invoke synchronize_rcu_expedited().
> 
> Suggested-by: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>

Whatever we end up applying, I'd like to have this thing tagged properly
- I didn't bisect for 2 days for nothing:

Reported-and-tested-by: Borislav Petkov <bp@suse.de>

Also, below's the other patch, I think you should copy the detailed
explanation about what happens from its commit message so that we have
it somewhere.

Also, to your patch add:

Fixes: 174cc7187e6f ("ACPICA: Tables: Back port acpi_get_table_with_size() and early_acpi_os_unmap_memory() from Linux kernel")
Link: https://lkml.kernel.org/r/4034dde8-ffc1-18e2-f40c-00cf37471793@intel.com

(I've added the link to the second mail in the thread because my first
one didn't end up on lkml due to attachment size, most likely).

> ---
>  drivers/acpi/osl.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index a404ff4..3d93633 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -77,6 +77,7 @@ static int (*__acpi_os_prepare_extended_sleep)(u8 sleep_state, u32 val_a,
>  static bool acpi_os_initialized;
>  unsigned int acpi_sci_irq = INVALID_ACPI_IRQ;
>  bool acpi_permanent_mmap = false;
> +bool acpi_synchronize_rcu = false;

ERROR: do not initialise globals to false
#54: FILE: drivers/acpi/osl.c:80:
+bool acpi_synchronize_rcu = false;

>  /*
>   * This list of permanent mappings is for memory that may be accessed from
> @@ -378,7 +379,8 @@ static void acpi_os_drop_map_ref(struct acpi_ioremap *map)
>  static void acpi_os_map_cleanup(struct acpi_ioremap *map)
>  {
>  	if (!map->refcount) {
> -		synchronize_rcu_expedited();
> +		if (acpi_synchronize_rcu)
> +			synchronize_rcu_expedited();
>  		acpi_unmap(map->phys, map->virt);
>  		kfree(map);
>  	}
> @@ -444,6 +446,7 @@ int acpi_os_map_generic_address(struct acpi_generic_address *gas)
>  	if (!virt)
>  		return -EIO;
>  
> +	acpi_synchronize_rcu = true;
>  	return 0;
>  }
>  EXPORT_SYMBOL(acpi_os_map_generic_address);
> -- 

---
From: Borislav Petkov <bp@suse.de>
Date: Mon, 9 Jan 2017 10:54:21 +0100
Subject: [PATCH] iommu/amd: Comment out acpi_put_table() for now
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We're calling this too early and we land in RCU which is uninitialized
yet:

  early_amd_iommu_init()
  |-> acpi_put_table(ivrs_base);
  |-> acpi_tb_put_table(table_desc);
  |-> acpi_tb_invalidate_table(table_desc);
  |-> acpi_tb_release_table(...)
  |-> acpi_os_unmap_memory
  |-> acpi_os_unmap_iomem
  |-> acpi_os_map_cleanup
  |-> synchronize_rcu_expedited   <-- the kernel/rcu/tree_exp.h version with CONFIG_PREEMPT_RCU=y

Now that function goes and sends IPIs, i.e., schedule_work() but this is
too early - we haven't even done workqueue_init().

Actually, from looking at the callstack, we do
kernel_init_freeable()->native_smp_prepare_cpus() and workqueue_init()
comes next.

So let's choose the lesser of two evils - leak a little ACPI memory -
instead of freezing early at boot. Took me a while to bisect this :-\

Signed-off-by: Borislav Petkov <bp@suse.de>
Fixes: 6b11d1d67713 ("ACPI / osl: Remove acpi_get_table_with_size()/early_acpi_os_unmap_memory() users")
Cc: Bob Moore <robert.moore@intel.com>
Cc: Jörg Rödel <joro@8bytes.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Lv Zheng <lv.zheng@intel.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 drivers/iommu/amd_iommu_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index 6799cf9713f7..b7c228002ec7 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -2337,8 +2337,14 @@ static int __init early_amd_iommu_init(void)
 
 out:
 	/* Don't leak any ACPI memory */
+
+	/*
+	 * Temporarily avoid doing that because we're called too early and
+	 * acpi_put_table() ends up in RCU (see acpi_os_map_cleanup()) which is
+	 * not initialized yet.
 	acpi_put_table(ivrs_base);
 	ivrs_base = NULL;
+	*/
 
 	return ret;
 }
-- 
2.11.0


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
