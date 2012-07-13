From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH v4 1/3] acpi : cpu hot-remove returns error when
 cpu_down() fails
Date: Fri, 13 Jul 2012 09:20:58 -0600
Message-ID: <1342192858.19100.15.camel@misato.fc.hp.com>
References: <4FFFE0DA.3050806@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0185.atlanta.hp.com ([15.193.32.62]:33964 "EHLO
	g6t0185.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756469Ab2GMPZc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Jul 2012 11:25:32 -0400
In-Reply-To: <4FFFE0DA.3050806@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: srivatsa.bhat@linux.vnet.ibm.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2012-07-13 at 17:48 +0900, Yasuaki Ishimatsu wrote:
> Even if cpu_down() fails, acpi_processor_remove() continues to remove the cpu.
> But in this case, it should return error number since some process may run on
> the cpu. If the cpu has a running process and the cpu is turned the power off,
> the system may not work well.
> 
> Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Thanks for the update.  It looks good.

Reviewed-by: Toshi Kani <toshi.kani@hp.com>


> 
> ---
>  drivers/acpi/processor_driver.c |   18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> Index: linux-3.5-rc6/drivers/acpi/processor_driver.c
> ===================================================================
> --- linux-3.5-rc6.orig/drivers/acpi/processor_driver.c	2012-07-08 09:23:56.000000000 +0900
> +++ linux-3.5-rc6/drivers/acpi/processor_driver.c	2012-07-13 15:11:06.135541317 +0900
> @@ -610,7 +610,7 @@ err_free_pr:
>  static int acpi_processor_remove(struct acpi_device *device, int type)
>  {
>  	struct acpi_processor *pr = NULL;
> -
> +	int ret;
> 
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
> @@ -621,8 +621,9 @@ static int acpi_processor_remove(struct
>  		goto free;
> 
>  	if (type == ACPI_BUS_REMOVAL_EJECT) {
> -		if (acpi_processor_handle_eject(pr))
> -			return -EINVAL;
> +		ret = acpi_processor_handle_eject(pr);
> +		if (ret)
> +			return ret;
>  	}
> 
>  	acpi_processor_power_exit(pr, device);
> @@ -841,12 +842,17 @@ static acpi_status acpi_processor_hotadd
> 
>  static int acpi_processor_handle_eject(struct acpi_processor *pr)
>  {
> -	if (cpu_online(pr->id))
> -		cpu_down(pr->id);
> +	int ret = 0;
> +
> +	if (cpu_online(pr->id)) {
> +		ret = cpu_down(pr->id);
> +		if (ret)
> +			return ret;
> +	}
> 
>  	arch_unregister_cpu(pr->id);
>  	acpi_unmap_lsapic(pr->id);
> -	return (0);
> +	return ret;
>  }
>  #else
>  static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr)
> 


