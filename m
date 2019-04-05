From: Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH v2] extcon: axp288: Add a depends on ACPI to the Kconfig
 entry
Date: Fri, 5 Apr 2019 11:06:09 +0530
Message-ID: <9903c0fc-3016-49ea-0120-bab4eb857cf4@codeaurora.org>
References: <20190404104222.23900-1-yuehaibing@huawei.com>
 <20190404141748.27048-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404141748.27048-1-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yue Haibing <yuehaibing@huawei.com>, myungjoo.ham@samsung.com, cw00.choi@samsung.com, wens@csie.org, hdegoede@redhat.com, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


On 4/4/2019 7:47 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> As Hans de Goede pointed, using this driver without ACPI
> makes little sense, so add ACPI dependency to Kconfig entry
> to fix a build error while CONFIG_ACPI is not set.
>
> drivers/extcon/extcon-axp288.c: In function 'axp288_extcon_probe':
> drivers/extcon/extcon-axp288.c:363:20: error: dereferencing pointer to incomplete type
>      put_device(&adev->dev);
>
> Fixes: 0cf064db948a ("extcon: axp288: Convert to use acpi_dev_get_first_match_dev()")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

This looks good too.
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
> v2: rework patch
> ---
>   drivers/extcon/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
> index 1ed4b45..de06faf 100644
> --- a/drivers/extcon/Kconfig
> +++ b/drivers/extcon/Kconfig
> @@ -30,7 +30,7 @@ config EXTCON_ARIZONA
>   
>   config EXTCON_AXP288
>   	tristate "X-Power AXP288 EXTCON support"
> -	depends on MFD_AXP20X && USB_SUPPORT && X86
> +	depends on MFD_AXP20X && USB_SUPPORT && X86 && ACPI
>   	select USB_ROLE_SWITCH
>   	help
>   	  Say Y here to enable support for USB peripheral detection
