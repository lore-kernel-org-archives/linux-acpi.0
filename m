From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] acpi : cpu hot-remove returns error when cpu_down() fails
Date: Fri, 19 Oct 2012 03:06:19 +0200
Message-ID: <4180255.BSUqs0l2F5@vostro.rjw.lan>
References: <50657D92.3010106@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:54369 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976Ab2JSEJK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Oct 2012 00:09:10 -0400
In-Reply-To: <50657D92.3010106@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: srivatsa.bhat@linux.vnet.ibm.com, toshi.kani@hp.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 28 of September 2012 19:36:02 Yasuaki Ishimatsu wrote:
> Even if cpu_down() fails, acpi_processor_remove() continues to remove the cpu.
> But in this case, it should return error number since some process may run on
> the cpu. If the cpu has a running process and the cpu is turned the power off,
> the system may not work well.
> 
> Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> Reviewed-by: Toshi Kani <toshi.kani@hp.com>
> Signed-off-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
> 
> ---
>  drivers/acpi/processor_driver.c |   18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> Index: linux-3.6-rc7/drivers/acpi/processor_driver.c
> ===================================================================
> --- linux-3.6-rc7.orig/drivers/acpi/processor_driver.c	2012-09-24 10:10:57.000000000 +0900
> +++ linux-3.6-rc7/drivers/acpi/processor_driver.c	2012-09-28 19:16:33.207858261 +0900
> @@ -605,7 +605,7 @@ err_free_pr:
>  static int acpi_processor_remove(struct acpi_device *device, int type)
>  {
>  	struct acpi_processor *pr = NULL;
> -
> +	int ret;
>  
>  	if (!device || !acpi_driver_data(device))
>  		return -EINVAL;
> @@ -616,8 +616,9 @@ static int acpi_processor_remove(struct 
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
> @@ -848,12 +849,17 @@ static acpi_status acpi_processor_hotadd
>  
>  static int acpi_processor_handle_eject(struct acpi_processor *pr)
>  {
> -	if (cpu_online(pr->id))
> -		cpu_down(pr->id);
> +	int ret = 0;
> +
> +	if (cpu_online(pr->id)) {
> +		ret = cpu_down(pr->id);

If you defined ret here ...

> +		if (ret)
> +			return ret;
> +	}
>  
>  	arch_unregister_cpu(pr->id);
>  	acpi_unmap_lsapic(pr->id);
> -	return (0);
> +	return ret;

... this line wouldn't need to be changed.

>  }
>  #else
>  static acpi_status acpi_processor_hotadd_init(struct acpi_processor *pr)

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
