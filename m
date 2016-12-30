From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: Re: [PATCH v5 11/14] msi: platform: make
 platform_msi_create_device_domain() ACPI aware
Date: Fri, 30 Dec 2016 16:58:40 +0800
Message-ID: <586621C0.10108@hisilicon.com>
References: <1482384922-21507-1-git-send-email-guohanjun@huawei.com>
 <1482384922-21507-12-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:4111 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753742AbcL3JtQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Dec 2016 04:49:16 -0500
In-Reply-To: <1482384922-21507-12-git-send-email-guohanjun@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <guohanjun@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Charles Garcia-Tobin <charles.garcia-tobin@arm.com>, jcm@redhat.com, yimin@huawei.com, Tomasz Nowicki <tn@semihalf.com>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Agustin Vega-Frias <agustinv@codeaurora.org>, linux-arm-kernel@lists.infradead.org

On 2016/12/22 13:35, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
>
> With the platform msi domain created for ITS, irqchip such as
> mbi-gen connecting ITS, which needs ctreate its own irqdomain.
>
> Fortunately with the platform msi support upstreamed by Marc,
> we just need to add minor code to make it run properly.
>
> platform_msi_create_device_domain() is almost ready for ACPI use
> except of_node_to_fwnode() is for dt only, make it ACPI aware then
> things will work in both DTS and ACPI.
>
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> ---
>   drivers/base/platform-msi.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> index be6a599..035ca3b 100644
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -345,8 +345,7 @@ struct irq_domain *
>   
>   	data->host_data = host_data;
>   	domain = irq_domain_create_hierarchy(dev->msi_domain, 0, nvec,
> -					     of_node_to_fwnode(dev->of_node),
> -					     ops, data);
> +					     dev->fwnode, ops, data);
>   	if (!domain)
>   		goto free_priv;
>   
Tested-by:  Xinwei Kong <kong.kongxinwei@hisilicon.com>

