From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/3] acpi : cpu hot-remove returns error when cpu_down()
 fails
Date: Thu, 12 Jul 2012 18:02:39 +0530
Message-ID: <4FFEC3E7.1030606@linux.vnet.ibm.com>
References: <4FFEB35A.6030500@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e23smtp09.au.ibm.com ([202.81.31.142]:39640 "EHLO
	e23smtp09.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab2GLMds (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Jul 2012 08:33:48 -0400
Received: from /spool/local
	by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-acpi@vger.kernel.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
	Thu, 12 Jul 2012 13:20:16 +1000
In-Reply-To: <4FFEB35A.6030500@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org, toshi.kani@hp.com

On 07/12/2012 04:52 PM, Yasuaki Ishimatsu wrote:
> Even if cpu_down() fails, acpi_processor_remove() continues to remove the cpu.
> But in this case, it should return error number since some process may run on
> the cpu. If the cpu has a running process and the cpu is turned the power off,
> the system may not work well.
> 
> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> 

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat

> ---
>  drivers/acpi/processor_driver.c |   18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> Index: linux-3.5-rc4/drivers/acpi/processor_driver.c
> ===================================================================
> --- linux-3.5-rc4.orig/drivers/acpi/processor_driver.c	2012-06-25 04:53:04.000000000 +0900
> +++ linux-3.5-rc4/drivers/acpi/processor_driver.c	2012-07-05 21:02:58.711285382 +0900
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
> +	int ret;
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

