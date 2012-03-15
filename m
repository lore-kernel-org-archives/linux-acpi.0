From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] drivers/acpi/processor_driver.c: add missing kfree
Date: Thu, 15 Mar 2012 14:37:13 +0530
Message-ID: <4F61B141.9000106@linux.vnet.ibm.com>
References: <1331800325-14251-1-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:58571 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760542Ab2COJg5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Mar 2012 05:36:57 -0400
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 15 Mar 2012 14:39:47 +0530
In-Reply-To: <1331800325-14251-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Len Brown <lenb@kernel.org>, deepthi@linux.vnet.ibm.com, venki@google.com, trenn@suse.de, bhelgaas@google.com, kernel-janitors@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 03/15/2012 02:02 PM, Julia Lawall wrote:

> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> The function acpi_processor_add is stored in the ops.add field of a
> acpi_driver structure.  This function is then called in
> acpi_bus_driver_init.  On failure, this function clears the field
> device->driver_data, but does not free its contents.  Thus the free has to
> be done by the add function.  In acpi_processor_add, the corresponding
> value is pr.  This value is currently freed on failure before storing it in
> device->driver_data, but not after.  This free is added in the error
> handling code at the end of the function.  The per_cpu variable
> processors is also cleared so that it does not refer to a dangling pointer.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>


See a minor nitpick below.. Other than that, everything looks great!

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

 > ---

>  drivers/acpi/processor_driver.c |   13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
> index 2801b41..98c3648 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -536,8 +536,8 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
>  		return -ENOMEM;
> 
>  	if (!zalloc_cpumask_var(&pr->throttling.shared_cpu_map, GFP_KERNEL)) {
> -		kfree(pr);
> -		return -ENOMEM;
> +		result = -ENOMEM;
> +		goto err_free_pr;
>  	}
> 
>  	pr->handle = device->handle;
> @@ -577,7 +577,7 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
>  	dev = get_cpu_device(pr->id);
>  	if (sysfs_create_link(&device->dev.kobj, &dev->kobj, "sysdev")) {
>  		result = -EFAULT;
> -		goto err_free_cpumask;
> +		goto err_clear_processor;
>  	}
> 
>  	/*
> @@ -595,9 +595,14 @@ static int __cpuinit acpi_processor_add(struct acpi_device *device)
> 
>  err_remove_sysfs:
>  	sysfs_remove_link(&device->dev.kobj, "sysdev");
> +err_clear_processor:
> +	/* processor_device_array is not cleared to allow checks for buggy
> +	   BIOSes */


Multi-line comments in the kernel are generally written like:

/*
 * blah blah blah
 * blah blah ....
 */

> +	per_cpu(processors, pr->id) = NULL;
>  err_free_cpumask:
>  	free_cpumask_var(pr->throttling.shared_cpu_map);
> -
> +err_free_pr:
> +	kfree(pr);
>  	return result;
>  }
> 






