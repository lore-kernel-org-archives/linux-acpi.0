From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [RFC PATCH v2 11/11] irqchip: mbigen: promote mbigen init
Date: Thu, 15 Sep 2016 16:24:31 +0100
Message-ID: <57DABD2F.1030606@arm.com>
References: <1473862879-7769-1-git-send-email-guohanjun@huawei.com>
 <1473862879-7769-12-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39680 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751519AbcIOPZD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Sep 2016 11:25:03 -0400
In-Reply-To: <1473862879-7769-12-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Ma Jun <majun258@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, linuxarm@huawei.com, Hanjun Guo <hanjun.guo@linaro.org>

On 14/09/16 15:21, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> mbigen is an irqchip and it needs to be probed before
> devices, same logic is used for SMMU and etc., let's
> use arch_initcall instead of platform init for mbigen.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ma Jun <majun258@huawei.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/irqchip/irq-mbigen.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index ca6add1..3a33de6 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -374,7 +374,11 @@ static struct platform_driver mbigen_platform_driver = {
>  	.probe			= mbigen_device_probe,
>  };
>  
> -module_platform_driver(mbigen_platform_driver);
> +static __init int mbigen_init(void)
> +{
> +	return platform_driver_register(&mbigen_platform_driver);
> +}
> +arch_initcall(mbigen_init);
>  
>  MODULE_AUTHOR("Jun Ma <majun258@huawei.com>");
>  MODULE_AUTHOR("Yun Wu <wuyun.wu@huawei.com>");
> 

I've already NACKed such a patch in the past, and I will carry on
NACKing it until all the other avenues (like properly tracking device
dependencies) have been explored and have been proven not to be fit for
purpose.

Rafael had proposed something around this subject last year, and I've
been repeatedly advising you to work with him and others to make it
happen. You can choose to ignore this advise, but that doesn't make this
patch an acceptable approach.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
