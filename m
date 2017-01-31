From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V11 1/3] ACPI: Generic GSI: Do not attempt to map non-GSI
 IRQs during bus scan
Date: Tue, 31 Jan 2017 23:00:54 +0100
Message-ID: <CAJZ5v0iGWo8hEPYWEibc7YukdjqZSr9Xzf1+t_wa2Jw3Yht8WQ@mail.gmail.com>
References: <1484879660-1960-1-git-send-email-agustinv@codeaurora.org> <1484879660-1960-2-git-send-email-agustinv@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1484879660-1960-2-git-send-email-agustinv@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Timur Tabi <timur@codeaurora.org>, Christopher Covington <cov@codeaurora.org>, Andy Gross <agross@codeaurora.org>, harba@codeaurora.org, Jon Masters <jcm@redhat.com>, Mark Salter <msalter@redhat.com>, Mark Langsdorf <mlangsdo@redhat.com>, Al Stone <ahs3@redhat.com>, astone@redhat.com, Graeme
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 20, 2017 at 3:34 AM, Agustin Vega-Frias
<agustinv@codeaurora.org> wrote:
> ACPI extended IRQ resources may contain a Resource Source field to specify
> an alternate interrupt controller, attempting to map them as GSIs is
> incorrect, so just disable the platform resource.
>
> Since this field is currently ignored, we make this change conditional
> on CONFIG_ACPI_GENERIC_GSI to keep the current behavior on x86 platforms,
> in case some existing ACPI tables are using this incorrectly.
>
> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>

This one is fine by me, so feel free to add my ACK to it.

Or if you want me to apply it, please let me know.

> ---
>  drivers/acpi/resource.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index cb57962..69cd430 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -43,6 +43,19 @@ static inline bool acpi_iospace_resource_valid(struct resource *res)
>  acpi_iospace_resource_valid(struct resource *res) { return true; }
>  #endif
>
> +#ifdef CONFIG_ACPI_GENERIC_GSI
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
>                 break;
>         default:
>                 res->flags = 0;
> --

Thanks,
Rafael
