From: Wen Congyang <wency@cn.fujitsu.com>
Subject: Re: [PATCH -next] ACPI: fix missing unlock on error in acpi_memory_remove_memory()
Date: Thu, 08 Nov 2012 09:31:43 +0800
Message-ID: <509B0B7F.3030308@cn.fujitsu.com>
References: <CAPgLHd_=OTwu-3tVXT0o8+x=N_9dZOkQ4A7HFr0SNdUiyAy_yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:26573 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751740Ab2KHBtA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Nov 2012 20:49:00 -0500
In-Reply-To: <CAPgLHd_=OTwu-3tVXT0o8+x=N_9dZOkQ4A7HFr0SNdUiyAy_yw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: lenb@kernel.org, rjw@sisk.pl, yongjun_wei@trendmicro.com.cn, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>

Hi, wei

At 11/07/2012 08:38 PM, Wei Yongjun Wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add the missing mutex_unlock() before return from function
> acpi_memory_remove_memory() in the error handling case.
> 
> Introduce by commit 85fcb3758c10e063a2a30dfad75017097999deed
> 'ACPI / memory-hotplug: introduce a mutex lock to protect the list in acpi_memory_device'
> 
> dpatch engine is used to auto generate this patch.
> (https://github.com/weiyj/dpatch)
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Thanks for your patch.

Dan Carpenter has told me this problem. I fix it, but don't
resend it because it is in test now.

Thanks
Wen Congyang

> ---
>  drivers/acpi/acpi_memhotplug.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index 92c973a..e573e87 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -325,8 +325,10 @@ static int acpi_memory_remove_memory(struct acpi_memory_device *mem_device)
>  	list_for_each_entry_safe(info, n, &mem_device->res_list, list) {
>  		if (info->enabled) {
>  			result = remove_memory(info->start_addr, info->length);
> -			if (result)
> +			if (result) {
> +				mutex_unlock(&mem_device->list_lock);
>  				return result;
> +			}
>  		}
>  
>  		list_del(&info->list);
> 
> 
> 

