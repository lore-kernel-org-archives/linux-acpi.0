From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: bind workqueues to CPU 0 to avoid SMI corruption
Date: Thu, 30 Jul 2009 08:59:59 +0800
Message-ID: <1248915599.2670.151.camel@rzhang-dt>
References: <20090729215425.23674.80263.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:29397 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754875AbZG3BAB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Jul 2009 21:00:01 -0400
In-Reply-To: <20090729215425.23674.80263.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Thu, 2009-07-30 at 05:54 +0800, Bjorn Helgaas wrote:
> On some machines, a software-initiated SMI causes corruption unless the
> SMI runs on CPU 0.  An SMI can be initiated by any AML, but typically it's
> done in GPE-related methods that are run via workqueues, so we can avoid
> the known corruption cases by binding the workqueues to CPU 0.
> 
> References:
>     http://bugzilla.kernel.org/show_bug.cgi?id=13751
>     https://bugs.launchpad.net/bugs/157171
>     https://bugs.launchpad.net/bugs/157691
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Acked-by: Zhang Rui <rui.zhang@intel.com>

> ---
>  drivers/acpi/osl.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 7167071..5691f16 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -189,11 +189,36 @@ acpi_status __init acpi_os_initialize(void)
>  	return AE_OK;
>  }
>  
> +static void bind_to_cpu0(struct work_struct *work)
> +{
> +	set_cpus_allowed(current, cpumask_of_cpu(0));
> +	kfree(work);
> +}
> +
> +static void bind_workqueue(struct workqueue_struct *wq)
> +{
> +	struct work_struct *work;
> +
> +	work = kzalloc(sizeof(struct work_struct), GFP_KERNEL);
> +	INIT_WORK(work, bind_to_cpu0);
> +	queue_work(wq, work);
> +}
> +
>  acpi_status acpi_os_initialize1(void)
>  {
> +	/*
> +	 * On some machines, a software-initiated SMI causes corruption unless
> +	 * the SMI runs on CPU 0.  An SMI can be initiated by any AML, but
> +	 * typically it's done in GPE-related methods that are run via
> +	 * workqueues, so we can avoid the known corruption cases by binding
> +	 * the workqueues to CPU 0.
> +	 */
>  	kacpid_wq = create_singlethread_workqueue("kacpid");
> +	bind_workqueue(kacpid_wq);
>  	kacpi_notify_wq = create_singlethread_workqueue("kacpi_notify");
> +	bind_workqueue(kacpi_notify_wq);
>  	kacpi_hotplug_wq = create_singlethread_workqueue("kacpi_hotplug");
> +	bind_workqueue(kacpi_hotplug_wq);
>  	BUG_ON(!kacpid_wq);
>  	BUG_ON(!kacpi_notify_wq);
>  	BUG_ON(!kacpi_hotplug_wq);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

