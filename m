From: "majun (Euler7)" <majun258@huawei.com>
Subject: Re: [PATCH v5 13/14] irqchip: mbigen: introduce
 mbigen_of_create_domain()
Date: Mon, 26 Dec 2016 16:59:43 +0800
Message-ID: <5860DBFF.7080109@huawei.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-14-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:59887 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755328AbcLZJAy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Dec 2016 04:00:54 -0500
In-Reply-To: <1482384922-21507-14-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: majun258@huawei.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg KH <gregkh@linuxfoundation.org>, Tomasz Nowicki <tn@semihalf.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Agustin Vega-Frias <agustinv@codeaurora.org>, Sinan Kaya <okaya@codeaurora.org>, Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, huxinwei@huawei.com, yimin@huawei.com, linuxarm@huawei.com, jcm@redhat.com, Hanjun Guo <hanjun.guo@linaro.org>

Hi hanjun£º

ÔÚ 2016/12/22 13:35, Hanjun Guo Ð´µÀ:
> From: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> Introduce mbigen_of_create_domain() to consolidate OF related
> code and prepare for ACPI later, no funtional change.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ma Jun <majun258@huawei.com>
> ---
>  drivers/irqchip/irq-mbigen.c | 42 +++++++++++++++++++++++++++---------------
>  1 file changed, 27 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
> index c01ab41..4e11da5 100644
> --- a/drivers/irqchip/irq-mbigen.c
> +++ b/drivers/irqchip/irq-mbigen.c
> @@ -236,27 +236,15 @@ static int mbigen_irq_domain_alloc(struct irq_domain *domain,
>  	.free		= irq_domain_free_irqs_common,
>  };
>  
> -static int mbigen_device_probe(struct platform_device *pdev)
> +static int mbigen_of_create_domain(struct platform_device *pdev,
> +				   struct mbigen_device *mgn_chip)
>  {
> -	struct mbigen_device *mgn_chip;
> +	struct device *parent;
>  	struct platform_device *child;
>  	struct irq_domain *domain;
>  	struct device_node *np;
> -	struct device *parent;
> -	struct resource *res;
>  	u32 num_pins;
>  
> -	mgn_chip = devm_kzalloc(&pdev->dev, sizeof(*mgn_chip), GFP_KERNEL);
> -	if (!mgn_chip)
> -		return -ENOMEM;
> -
> -	mgn_chip->pdev = pdev;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	mgn_chip->base = devm_ioremap_resource(&pdev->dev, res);
> -	if (IS_ERR(mgn_chip->base))
> -		return PTR_ERR(mgn_chip->base);
> -
>  	for_each_child_of_node(pdev->dev.of_node, np) {
>  		if (!of_property_read_bool(np, "interrupt-controller"))
>  			continue;
> @@ -280,6 +268,30 @@ static int mbigen_device_probe(struct platform_device *pdev)
>  			return -ENOMEM;
>  	}
>  
> +	return 0;
> +}
> +
> +static int mbigen_device_probe(struct platform_device *pdev)
> +{
> +	struct mbigen_device *mgn_chip;
> +	struct resource *res;
> +	int err;
> +
> +	mgn_chip = devm_kzalloc(&pdev->dev, sizeof(*mgn_chip), GFP_KERNEL);
> +	if (!mgn_chip)
> +		return -ENOMEM;
> +
> +	mgn_chip->pdev = pdev;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mgn_chip->base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (IS_ERR(mgn_chip->base))
> +		return PTR_ERR(mgn_chip->base);
> +
> +	err = mbigen_of_create_domain(pdev, mgn_chip);
> +	if (err)
> +		return err;
> +
>  	platform_set_drvdata(pdev, mgn_chip);
>  	return 0;
>  }
> 
Reviewed-by: MaJun <majun258@huawei.com>

