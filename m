From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V11 1/3] ACPI: Generic GSI: Do not attempt to map non-GSI
 IRQs during bus scan
Date: Thu, 26 Jan 2017 02:47:09 +0200
Message-ID: <CAHp75VdTnjupjzWyc27JPi_wUsd=+q-4FuzRV=WvjfSe1HdoKQ@mail.gmail.com>
References: <1484879660-1960-1-git-send-email-agustinv@codeaurora.org> <1484879660-1960-2-git-send-email-agustinv@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35723 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbdAZArK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2017 19:47:10 -0500
In-Reply-To: <1484879660-1960-2-git-send-email-agustinv@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Timur Tabi <timur@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Andy Gross <agross@codeaurora.org>, harba@codeaurora.org, Jon Masters <jcm@redhat.com>, msalter@redhat.com, mlangsdo@redhat.com, Al Stone <ahs3@redhat.com>, astone@redhat.com, Graeme Gregory <graeme.gregory@linaro.org>, guohanjun@huawei.com, Charles Garcia-Tobin <charles.gar>

On Fri, Jan 20, 2017 at 4:34 AM, Agustin Vega-Frias
<agustinv@codeaurora.org> wrote:
> ACPI extended IRQ resources may contain a Resource Source field to specify
> an alternate interrupt controller, attempting to map them as GSIs is
> incorrect, so just disable the platform resource.
>
> Since this field is currently ignored, we make this change conditional
> on CONFIG_ACPI_GENERIC_GSI to keep the current behavior on x86 platforms,
> in case some existing ACPI tables are using this incorrectly.

> @@ -43,6 +43,19 @@ static inline bool acpi_iospace_resource_valid(struct resource *res)
>  acpi_iospace_resource_valid(struct resource *res) { return true; }
>  #endif
>
> +#ifdef CONFIG_ACPI_GENERIC_GSI

#if IS_ENABLED() ?

> +static inline bool is_gsi(struct acpi_resource_extended_irq *ext_irq)
> +{
> +       return ext_irq->resource_source.string_length == 0 &&
> +              ext_irq->producer_consumer == ACPI_CONSUMER;
> +}
> +#else
> +static inline bool is_gsi(struct acpi_resource_extended_irq *ext_irq)
> +{
> +       return true;
> +}
> +#endif
> +
>  static bool acpi_dev_resource_len_valid(u64 start, u64 end, u64 len, bool io)
>  {
>         u64 reslen = end - start + 1;
> @@ -470,9 +483,12 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>                         acpi_dev_irqresource_disabled(res, 0);
>                         return false;
>                 }
> -               acpi_dev_get_irqresource(res, ext_irq->interrupts[index],

> +               if (is_gsi(ext_irq))
> +                       acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
>                                          ext_irq->triggering, ext_irq->polarity,
>                                          ext_irq->sharable, false);
> +               else
> +                       acpi_dev_irqresource_disabled(res, 0);

And why not to create a helper called acpi_dev_get_gsi_irqresource()
instead of that one?

-- 
With Best Regards,
Andy Shevchenko
