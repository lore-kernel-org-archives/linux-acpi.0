From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] cpuidle / ACPI: fix potential NULL pointer dereference
Date: Mon, 08 Oct 2012 22:51:55 -0400
Message-ID: <5073914B.3050606@kernel.org>
References: <CAPgLHd-8SzCJHbi8sknFvBe11taoXS5z3MOkM=Jet-VD5z14tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:40741 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296Ab2JICv5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Oct 2012 22:51:57 -0400
Received: by mail-qc0-f180.google.com with SMTP id v28so3600872qcm.11
        for <linux-acpi@vger.kernel.org>; Mon, 08 Oct 2012 19:51:57 -0700 (PDT)
In-Reply-To: <CAPgLHd-8SzCJHbi8sknFvBe11taoXS5z3MOkM=Jet-VD5z14tw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: yongjun_wei@trendmicro.com.cn, linux-acpi@vger.kernel.org

Applied.

thanks,
Len Brown, Intel Open Source Technology Center

On 10/07/2012 08:40 PM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> The dereference should be moved below the NULL test.
> 
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  drivers/acpi/processor_idle.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 3655ab9..e8086c7 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -1132,7 +1132,7 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
>  int acpi_processor_hotplug(struct acpi_processor *pr)
>  {
>  	int ret = 0;
> -	struct cpuidle_device *dev = per_cpu(acpi_cpuidle_device, pr->id);
> +	struct cpuidle_device *dev;
>  
>  	if (disabled_by_idle_boot_param())
>  		return 0;
> @@ -1147,6 +1147,7 @@ int acpi_processor_hotplug(struct acpi_processor *pr)
>  	if (!pr->flags.power_setup_done)
>  		return -ENODEV;
>  
> +	dev = per_cpu(acpi_cpuidle_device, pr->id);
>  	cpuidle_pause_and_lock();
>  	cpuidle_disable_device(dev);
>  	acpi_processor_get_power_info(pr);
> 

