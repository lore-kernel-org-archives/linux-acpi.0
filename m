From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH V7 0/3] irqchip: qcom: Add IRQ combiner driver
Date: Tue, 29 Nov 2016 19:31:44 +0800
Message-ID: <4126fa80-c8da-764f-9ea3-ec9966a19ea9@linaro.org>
References: <1479074375-2629-1-git-send-email-agustinv@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36302 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933597AbcK2Lc1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Nov 2016 06:32:27 -0500
Received: by mail-pf0-f175.google.com with SMTP id 189so31786574pfz.3
        for <linux-acpi@vger.kernel.org>; Tue, 29 Nov 2016 03:32:26 -0800 (PST)
In-Reply-To: <1479074375-2629-1-git-send-email-agustinv@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Agustin Vega-Frias <agustinv@codeaurora.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: timur@codeaurora.org, cov@codeaurora.org, agross@codeaurora.org, harba@codeaurora.org, jcm@redhat.com, msalter@redhat.com, mlangsdo@redhat.com, ahs3@redhat.com, astone@redhat.com, graeme.gregory@linaro.org, guohanjun@huawei.com, charles.garcia-tobin@arm.com

Hi Agustin,

On 2016/11/14 5:59, Agustin Vega-Frias wrote:
> Add support for IRQ combiners in the Top-level Control and Status
> Registers (TCSR) hardware block in Qualcomm Technologies chips.
>
> The first patch fixes IRQ probe deferral by allowing platform_device
> IRQ resources to be re-initialized if the ACPI core failed to find
> the IRQ domain during ACPI bus scan.
>
> The second patch adds support for ResourceSource/IRQ domain mapping
> when using Extended IRQ Resources with a specific ResourceSource.
> These changes are conditional on the ACPI_GENERIC_GSI config.
>
> The third patch takes advantage of the new capabilities to implement
> the driver for the IRQ combiners.
>
> Tested on top of v4.9-rc4.
>
> Changes V6 -> V7:
> * Consolidate changes for ResourceSource/IRQ domain mapping to the same
>   source file implementing the generic GSI support, making it conditional
>   on CONFIG_ACPI_GENERIC_GSI.
> * Eliminate some code duplication by implementing acpi_register_gsi in
>   terms of the new acpi_register_irq API.

I had a test on Hisilicon D03 which needs patch 1 and 2 in this patch
set to enable the mbigen irqchip, and it works pretty good.

Patch 1/3 can remove the device dependency for the irqchip and platform
devices, and I removed my patch (ACPI: irq: introduce interrupt
producer) then add your patch 2/3, devices such as SAS and native
network works fine on my D03.

I will comment on the patches later.

Thanks
Hanjun
