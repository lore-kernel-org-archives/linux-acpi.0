From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [PATCH V4 3/7] irqchip, GICv3, ITS: Refator ITS DT init code to
 prepare for ACPI.
Date: Tue, 12 Apr 2016 12:18:21 +0200
Message-ID: <570CCB6D.30706@semihalf.com>
References: <1459759975-24097-1-git-send-email-tn@semihalf.com>
 <1459759975-24097-4-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35551 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932492AbcDLKSm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Apr 2016 06:18:42 -0400
Received: by mail-wm0-f48.google.com with SMTP id a140so47304778wma.0
        for <linux-acpi@vger.kernel.org>; Tue, 12 Apr 2016 03:18:42 -0700 (PDT)
In-Reply-To: <1459759975-24097-4-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org
Cc: al.stone@linaro.org, mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com, okaya@codeaurora.org

On 04.04.2016 10:52, Tomasz Nowicki wrote:
> diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
> index d5d798b..a40ed7d 100644
> --- a/include/linux/irqchip/arm-gic-v3.h
> +++ b/include/linux/irqchip/arm-gic-v3.h
> @@ -332,7 +332,7 @@ struct rdists {
>   struct irq_domain;
>   struct device_node;

I forgot to add this to avoid compilation warning:
-struct device_node;
+struct fwnode_handle;

>   int its_cpu_init(void);
> -int its_init(struct device_node *node, struct rdists *rdists,
> +int its_init(struct fwnode_handle *handle, struct rdists *rdists,
>   	     struct irq_domain *domain);
>
>   static inline bool gic_enable_sre(void)

Thanks,
Tomasz
