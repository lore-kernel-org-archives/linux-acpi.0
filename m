From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: Re: [PATCH v2] acpi: apei: Add SEI notification type support for
 ARMv8
Date: Tue, 26 Sep 2017 13:23:35 -0600
Message-ID: <88a71a70-0704-6e47-de09-6f67b91967b6@codeaurora.org>
References: <1505373743-7780-1-git-send-email-gengdongjiu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33942 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754465AbdIZTXx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Sep 2017 15:23:53 -0400
In-Reply-To: <1505373743-7780-1-git-send-email-gengdongjiu@huawei.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dongjiu Geng <gengdongjiu@huawei.com>, will.deacon@arm.com, zjzhang@codeaurora.org, catalin.marinas@arm.com, bp@suse.de, james.morse@arm.com, geliangtang@gmail.com, andriy.shevchenko@linux.intel.com, tony.luck@intel.com, austinwc@codeaurora.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com, john.garry@huawei.com, shiju.jose@huawei.com, zhengqiang10@huawei.com, wangxiongfeng2@huawei.com, Stephen Boyd <sboyd@codeaurora.org>
Cc: huangshaoyu@huawei.com, wuquanming@huawei.com

On 9/14/2017 1:22 AM, Dongjiu Geng wrote:
> ARMv8.2 requires implementation of the RAS extension, in
> this extension it adds SEI(SError Interrupt) notification
> type, this patch adds new GHES error source SEI handling
> functions. Because this error source parsing and handling
> methods are similar with the SEA. so share some SEA handling
> functions with the SEI
>
> Expose one API ghes_notify_abort() to external users. External
> modules can call this exposed API to parse and handling the
> SEA or SEI.
>
> Note: For the SEI(SError Interrupt), because it is asynchronous
> external abort, the error address is not accurate, so EL3 firmware
> should identify the address to a invalid value.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

Tested this functionality using SEA support.

++Stephen,

Something to be aware of, this patch will conflict with 
https://lkml.org/lkml/2017/9/14/663
It may make sense to just remove the conditions for the NMI configs as 
part of this patch or in a series with this patch to avoid merge conflicts.

Thanks,
Tyler
> ---
>   arch/arm64/Kconfig        |  4 ++--
>   arch/arm64/mm/fault.c     |  4 ++--
>   drivers/acpi/apei/Kconfig | 15 +++++++++++++
>   drivers/acpi/apei/ghes.c  | 56 +++++++++++++++++++++++++++++++++++------------
>   include/acpi/ghes.h       |  2 +-
>   5 files changed, 62 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 4d87aa963d83..9989ecce9a72 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -21,7 +21,7 @@ config ARM64
>   	select ARCH_HAS_STRICT_KERNEL_RWX
>   	select ARCH_HAS_STRICT_MODULE_RWX
>   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> -	select ARCH_HAVE_NMI_SAFE_CMPXCHG if ACPI_APEI_SEA
> +	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (ACPI_APEI_SEA || ACPI_APEI_SEI)
>   	select ARCH_USE_CMPXCHG_LOCKREF
>   	select ARCH_SUPPORTS_MEMORY_FAILURE
>   	select ARCH_SUPPORTS_ATOMIC_RMW
> @@ -97,7 +97,7 @@ config ARM64
>   	select HAVE_IRQ_TIME_ACCOUNTING
>   	select HAVE_MEMBLOCK
>   	select HAVE_MEMBLOCK_NODE_MAP if NUMA
> -	select HAVE_NMI if ACPI_APEI_SEA
> +	select HAVE_NMI if (ACPI_APEI_SEA || ACPI_APEI_SEI)
>   	select HAVE_PATA_PLATFORM
>   	select HAVE_PERF_EVENTS
>   	select HAVE_PERF_REGS
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 2509e4fe6992..c98c1b30aab5 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -585,7 +585,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>   		if (interrupts_enabled(regs))
>   			nmi_enter();
>   
> -		ret = ghes_notify_sea();
> +		ret = ghes_notify_abort(ACPI_HEST_NOTIFY_SEA);
>   
>   		if (interrupts_enabled(regs))
>   			nmi_exit();
> @@ -682,7 +682,7 @@ int handle_guest_sea(phys_addr_t addr, unsigned int esr)
>   	int ret = -ENOENT;
>   
>   	if (IS_ENABLED(CONFIG_ACPI_APEI_SEA))
> -		ret = ghes_notify_sea();
> +		ret = ghes_notify_abort(ACPI_HEST_NOTIFY_SEA);
>   
>   	return ret;
>   }
> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> index de14d49a5c90..47fcb0c82e1e 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -54,6 +54,21 @@ config ACPI_APEI_SEA
>   	  option allows the OS to look for such hardware error record, and
>   	  take appropriate action.
>   
> +config ACPI_APEI_SEI
> +	bool "APEI Asynchronous SError Interrupt logging/recovering support"
> +	depends on ARM64 && ACPI_APEI_GHES
> +	default y
> +	help
> +	  This option should be enabled if the system supports
> +	  firmware first handling of SEI (asynchronous SError interrupt).
> +
> +	  SEI happens with asynchronous external abort for errors on device
> +	  memory reads on ARMv8 systems. If a system supports firmware first
> +	  handling of SEI, the platform analyzes and handles hardware error
> +	  notifications from SEI, and it may then form a HW error record for
> +	  the OS to parse and handle. This option allows the OS to look for
> +	  such hardware error record, and take appropriate action.
> +
>   config ACPI_APEI_MEMORY_FAILURE
>   	bool "APEI memory error recovering support"
>   	depends on ACPI_APEI && MEMORY_FAILURE
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index c15a08db2c7c..47be1841f9fe 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -814,33 +814,52 @@ static struct notifier_block ghes_notifier_hed = {
>   };
>   
>   static LIST_HEAD(ghes_sea);
> +static LIST_HEAD(ghes_sei);
>   
>   /*
> - * Return 0 only if one of the SEA error sources successfully reported an error
> + * Return 0 only if one of the SEA or SEI error sources successfully reported an error
>    * record sent from the firmware.
>    */
> -int ghes_notify_sea(void)
> +int ghes_notify_abort(u8 type)
>   {
>   	struct ghes *ghes;
> +	struct list_head *head = NULL;
>   	int ret = -ENOENT;
>   
> -	rcu_read_lock();
> -	list_for_each_entry_rcu(ghes, &ghes_sea, list) {
> -		if (!ghes_proc(ghes))
> -			ret = 0;
> +	if (type == ACPI_HEST_NOTIFY_SEA)
> +		head = &ghes_sea;
> +	else if (type == ACPI_HEST_NOTIFY_SEI)
> +		head = &ghes_sei;
> +
> +	if (head) {
> +		rcu_read_lock();
> +		list_for_each_entry_rcu(ghes, head, list) {
> +			if (!ghes_proc(ghes))
> +				ret = 0;
> +		}
> +		rcu_read_unlock();
>   	}
> -	rcu_read_unlock();
>   	return ret;
>   }
>   
> -static void ghes_sea_add(struct ghes *ghes)
> +static void ghes_abort_add(struct ghes *ghes)
>   {
> -	mutex_lock(&ghes_list_mutex);
> -	list_add_rcu(&ghes->list, &ghes_sea);
> -	mutex_unlock(&ghes_list_mutex);
> +	struct list_head *head = NULL;
> +	u8 notify_type = ghes->generic->notify.type;
> +
> +	if (notify_type == ACPI_HEST_NOTIFY_SEA)
> +		head = &ghes_sea;
> +	else if (notify_type == ACPI_HEST_NOTIFY_SEI)
> +		head = &ghes_sei;
> +
> +	if (head) {
> +		mutex_lock(&ghes_list_mutex);
> +		list_add_rcu(&ghes->list, head);
> +		mutex_unlock(&ghes_list_mutex);
> +	}
>   }
>   
> -static void ghes_sea_remove(struct ghes *ghes)
> +static void ghes_abort_remove(struct ghes *ghes)
>   {
>   	mutex_lock(&ghes_list_mutex);
>   	list_del_rcu(&ghes->list);
> @@ -1093,6 +1112,13 @@ static int ghes_probe(struct platform_device *ghes_dev)
>   			goto err;
>   		}
>   		break;
> +	case ACPI_HEST_NOTIFY_SEI:
> +		if (!IS_ENABLED(CONFIG_ACPI_APEI_SEI)) {
> +			pr_warn(GHES_PFX "Generic hardware error source: %d notified via SEI is not supported!\n",
> +				generic->header.source_id);
> +		goto err;
> +	}
> +	break;
>   	case ACPI_HEST_NOTIFY_NMI:
>   		if (!IS_ENABLED(CONFIG_HAVE_ACPI_APEI_NMI)) {
>   			pr_warn(GHES_PFX "Generic hardware error source: %d notified via NMI interrupt is not supported!\n",
> @@ -1162,7 +1188,8 @@ static int ghes_probe(struct platform_device *ghes_dev)
>   		break;
>   
>   	case ACPI_HEST_NOTIFY_SEA:
> -		ghes_sea_add(ghes);
> +	case ACPI_HEST_NOTIFY_SEI:
> +		ghes_abort_add(ghes);
>   		break;
>   	case ACPI_HEST_NOTIFY_NMI:
>   		ghes_nmi_add(ghes);
> @@ -1215,7 +1242,8 @@ static int ghes_remove(struct platform_device *ghes_dev)
>   		break;
>   
>   	case ACPI_HEST_NOTIFY_SEA:
> -		ghes_sea_remove(ghes);
> +	case ACPI_HEST_NOTIFY_SEI:
> +		ghes_abort_remove(ghes);
>   		break;
>   	case ACPI_HEST_NOTIFY_NMI:
>   		ghes_nmi_remove(ghes);
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index 9061c5c743b3..ec6f4bab1d1b 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -118,6 +118,6 @@ static inline void *acpi_hest_get_next(struct acpi_hest_generic_data *gdata)
>   	     (void *)section - (void *)(estatus + 1) < estatus->data_length; \
>   	     section = acpi_hest_get_next(section))
>   
> -int ghes_notify_sea(void);
> +int ghes_notify_abort(u8 type);
>   
>   #endif /* GHES_H */

