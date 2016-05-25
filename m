From: agustinv@codeaurora.org
Subject: Re: [PATCH V3 0/2] irqchip: qcom: Add IRQ combiner driver
Date: Wed, 25 May 2016 10:37:36 -0400
Message-ID: <a7f49bb9ecfb9181d9d9f76cc45d6dbf@codeaurora.org>
References: <1463156203-10970-1-git-send-email-agustinv@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:55148 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbcEYOhi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2016 10:37:38 -0400
In-Reply-To: <1463156203-10970-1-git-send-email-agustinv@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
Cc: timur@codeaurora.org, cov@codeaurora.org, agross@codeaurora.org, harba@codeaurora.org, jcm@redhat.com, msalter@redhat.com, mlangsdo@redhat.com, ahs3@redhat.com, astone@redhat.com, graeme.gregory@linaro.org, guohanjun@huawei.com, charles.garcia-tobin@arm.com

Adding linux-arm-kernel and linux-acpi

On 2016-05-13 12:16, Agustin Vega-Frias wrote:
> Add support for IRQ combiners in the Top-level Control and Status
> Registers (TCSR) hardware block in Qualcomm Technologies chips.
> 
> The first patch adds support for ResourceSource/IRQ domain mapping
> when using Extended IRQ Resources with a specific ResourceSource.
> The core ACPI resource management code has been changed to lookup
> the IRQ domain when an IRQ resource indicates a ResourceSource,
> and register the IRQ on that domain, instead of a GSI.
> 
> The second patch takes advantage of the new capabilities to implement
> the driver for the IRQ combiners.
> 
> Changes V1 -> V2:
> * Remove use of GPIO library for the combiner
> * Refactor to use fwnode/ResourceSource to IRQ domain mapping
>   introduced in ACPI core
> 
> Changes V2 -> V3:
> * Removed parsing of _PRS to find IRQs
> * Removed acpi_irq_domain_create and acpi_irq_domain_remove
> 
> Agustin Vega-Frias (2):
>   ACPI: Add support for ResourceSource/IRQ domain mapping
>   irqchip: qcom: Add IRQ combiner driver
> 
>  drivers/acpi/Makefile               |   1 +
>  drivers/acpi/irqdomain.c            | 108 +++++++++++
>  drivers/acpi/resource.c             |  23 ++-
>  drivers/irqchip/Kconfig             |   8 +
>  drivers/irqchip/Makefile            |   1 +
>  drivers/irqchip/qcom-irq-combiner.c | 344 
> ++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h                |   6 +
>  7 files changed, 483 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/acpi/irqdomain.c
>  create mode 100644 drivers/irqchip/qcom-irq-combiner.c
> 
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
> Forum,
> a Linux Foundation Collaborative Project.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project.
