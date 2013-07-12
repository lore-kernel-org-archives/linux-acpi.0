From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Subject: Re: [PATCH] ACPI / memhotplug: Fix a stale pointer in error path
Date: Fri, 12 Jul 2013 09:24:22 +0900
Message-ID: <51DF4CB6.4060903@jp.fujitsu.com>
References: <1373474833-14047-1-git-send-email-toshi.kani@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1373474833-14047-1-git-send-email-toshi.kani@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: rjw@sisk.pl, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

(2013/07/11 1:47), Toshi Kani wrote:
> device->driver_data needs to be cleared when releasing its data,
> mem_device, in an error path of acpi_memory_device_add().
> 
> Signed-off-by: Toshi Kani <toshi.kani@hp.com>
> ---

Reviewed-by: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Thanks,
Yasuaki Ishimatsu

>   drivers/acpi/acpi_memhotplug.c |    1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index c711d11..999adb5 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -323,6 +323,7 @@ static int acpi_memory_device_add(struct acpi_device *device,
>   	/* Get the range from the _CRS */
>   	result = acpi_memory_get_device_resources(mem_device);
>   	if (result) {
> +		device->driver_data = NULL;
>   		kfree(mem_device);
>   		return result;
>   	}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
