From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: Re: [PATCH v5 12/14] irqchip: mbigen: drop module owner
Date: Fri, 30 Dec 2016 16:58:51 +0800
Message-ID: <586621CB.50307@hisilicon.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-13-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:34828 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbcL3I7o (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Dec 2016 03:59:44 -0500
In-Reply-To: <1482384922-21507-13-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, jcm@redhat.com, yimin@huawei.com, Tomasz Nowicki <tn@semihalf.com>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Agustin Vega-Frias <agustinv@codeaurora.org>, linux-arm-kernel@lists.infradead.org

On 2016/12/22 13:35, Hanjun Guo wrote:
> From: Kefeng Wang <wangkefeng.wang@huawei.com>
>
> Module owner will be set by driver core, so drop it.
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ma Jun <majun258@huawei.com>
> ---
>   drivers/irqchip/irq-mbigen.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index 03b79b0..c01ab41 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -293,7 +293,6 @@ static int mbigen_device_probe(struct platform_device *pdev)
>   static struct platform_driver mbigen_platform_driver = {
>   	.driver = {
>   		.name		= "Hisilicon MBIGEN-V2",
> -		.owner		= THIS_MODULE,
>   		.of_match_table	= mbigen_of_match,
>   	},
>   	.probe			= mbigen_device_probe,
Tested-by:  Xinwei Kong <kong.kongxinwei@hisilicon.com>

