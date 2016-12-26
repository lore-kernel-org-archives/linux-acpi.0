From: "majun (Euler7)" <majun258@huawei.com>
Subject: Re: [PATCH v5 12/14] irqchip: mbigen: drop module owner
Date: Mon, 26 Dec 2016 16:59:19 +0800
Message-ID: <5860DBE7.8090806@huawei.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-13-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:13504 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755328AbcLZJAs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Dec 2016 04:00:48 -0500
In-Reply-To: <1482384922-21507-13-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: majun258@huawei.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, huxinwei@huawei.com, yimin@huawei.com, linuxarm@huawei.com, jcm@redhat.com, Hanjun Guo <hanjun.guo@linaro.org>

Hi hanjun£º

ÔÚ 2016/12/22 13:35, Hanjun Guo Ð´µÀ:
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
>  drivers/irqchip/irq-mbigen.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index 03b79b0..c01ab41 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -293,7 +293,6 @@ static int mbigen_device_probe(struct platform_device *pdev)
>  static struct platform_driver mbigen_platform_driver = {
>  	.driver = {
>  		.name		= "Hisilicon MBIGEN-V2",
> -		.owner		= THIS_MODULE,
>  		.of_match_table	= mbigen_of_match,
>  	},
>  	.probe			= mbigen_device_probe,
> 

Reviewed-by: MaJun <majun258@huawei.com>

