From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH V9 1/3] ACPI: Generic GSI: Do not attempt to map non-GSI
 IRQs during bus scan
Date: Tue, 17 Jan 2017 20:15:19 +0800
Message-ID: <587E0AD7.40303@huawei.com>
References: <1481753438-3905-1-git-send-email-agustinv@codeaurora.org>
 <1481753438-3905-2-git-send-email-agustinv@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:45590 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750866AbdAQMWl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2017 07:22:41 -0500
In-Reply-To: <1481753438-3905-2-git-send-email-agustinv@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Agustin Vega-Frias <agustinv@codeaurora.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: lorenzo.pieralisi@arm.com, timur@codeaurora.org, cov@codeaurora.org, agross@codeaurora.org, harba@codeaurora.org, jcm@redhat.com, msalter@redhat.com, mlangsdo@redhat.com, ahs3@redhat.com, astone@redhat.com, graeme.gregory@linaro.org, charles.garcia-tobin@arm.com

On 2016/12/15 6:10, Agustin Vega-Frias wrote:
> ACPI extended IRQ resources may contain a Resource Source field to specify
> an alternate interrupt controller, attempting to map them as GSIs is
> incorrect, so just disable the platform resource.
>
> Since this field is currently ignored, we make this change conditional
> on CONFIG_ACPI_GENERIC_GSI to keep the current behavior on x86 platforms,
> in case some existing ACPI tables are using this incorrectly.
>
> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
> ---
>  drivers/acpi/resource.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 56241eb..76ca4e9 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -43,6 +43,18 @@ static inline bool acpi_iospace_resource_valid(struct resource *res)
>  acpi_iospace_resource_valid(struct resource *res) { return true; }
>  #endif
>  
> +#ifdef CONFIG_ACPI_GENERIC_GSI
> +static inline bool is_gsi(struct acpi_resource_extended_irq *ext_irq)
> +{
> +	return ext_irq->resource_source.string_length == 0;

As pointed out by Lorenzo, if the interrupt resource is a Resource Producer,
it's not GSI, so maybe the code needs to be updated as

-   return ext_irq->resource_source.string_length == 0;
+ return ext_irq->resource_source.string_length == 0 &&
+        ext_irq->producer_consumer != ACPI_PRODUCER;

Thanks
Hanjun


