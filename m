From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH V9 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
Date: Tue, 17 Jan 2017 20:47:49 +0800
Message-ID: <587E1275.7030007@huawei.com>
References: <1481753438-3905-1-git-send-email-agustinv@codeaurora.org>
 <1481753438-3905-3-git-send-email-agustinv@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1481753438-3905-3-git-send-email-agustinv@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Agustin Vega-Frias <agustinv@codeaurora.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: harba@codeaurora.org, lorenzo.pieralisi@arm.com, graeme.gregory@linaro.org, jcm@redhat.com, timur@codeaurora.org, msalter@redhat.com, astone@redhat.com, mlangsdo@redhat.com, cov@codeaurora.org, agross@codeaurora.org, ahs3@redhat.com, charles.garcia-tobin@arm.com
List-Id: linux-acpi@vger.kernel.org

On 2016/12/15 6:10, Agustin Vega-Frias wrote:
> ACPI extended IRQ resources may contain a ResourceSource to specify
> an alternate interrupt controller. Introduce acpi_irq_get and use it
> to implement ResourceSource/IRQ domain mapping.
>
> The new API is similar to of_irq_get and allows re-initialization
> of a platform resource from the ACPI extended IRQ resource, and
> provides proper behavior for probe deferral when the domain is not
> yet present when called.
>
> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
> ---
>  drivers/acpi/Makefile         |   2 +-
>  drivers/acpi/{gsi.c => irq.c} | 182 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/base/platform.c       |   9 ++-
>  include/linux/acpi.h          |  10 +++
>  4 files changed, 201 insertions(+), 2 deletions(-)
>  rename drivers/acpi/{gsi.c => irq.c} (32%)
>
[...]
> +/**
> + * acpi_irq_parse_one_cb - Handle the given resource
> + * @ares: resource to handle
> + * @context: context for the walk, contains the lookup index and references
> + *           to the flags and fwspec where the result is returned
> + *
> + * This is called by acpi_walk_resources passing each resource returned by
> + * the _CRS method. We only inspect IRQ resources. Since IRQ resources
> + * might contain multiple interrupts we check if the index is within this
> + * one's interrupt array, otherwise we subtract the current resource IRQ
> + * count from the lookup index to prepare for the next resource.
> + * Once a match is found we call acpi_irq_parse_one_match to populate
> + * the result and end the walk by returning AE_CTRL_TERMINATE.
> + *
> + * Return AE_OK if the walk should continue, AE_CTRL_TERMINATE if a matching
> + * IRQ resource was found.
> + */
> +static acpi_status acpi_irq_parse_one_cb(struct acpi_resource *ares,
> +					 void *context)
> +{
> +	struct acpi_irq_parse_one_ctx *ctx = context;
> +	struct acpi_resource_irq *irq;
> +	struct acpi_resource_extended_irq *eirq;
> +	struct fwnode_handle *fwnode;
> +
> +	switch (ares->type) {
> +	case ACPI_RESOURCE_TYPE_IRQ:
> +		irq = &ares->data.irq;
> +		if (ctx->index >= irq->interrupt_count) {
> +			ctx->index -= irq->interrupt_count;
> +			return AE_OK;
> +		}
> +		fwnode = acpi_gsi_domain_id;
> +		acpi_irq_parse_one_match(fwnode, irq->interrupts[ctx->index],
> +					 irq->triggering, irq->polarity,
> +					 irq->sharable, ctx);
> +		return AE_CTRL_TERMINATE;
> +	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
> +		eirq = &ares->data.extended_irq;

If it's an interrupt producer, I think we don't need to map the interrupts in
any irqdomain, and return AE_CTRL_TERMINATE here.

        case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
                eirq = &ares->data.extended_irq;
+         if (eirq->producer_consumer == ACPI_PRODUCER)
+                 return AE_CTRL_TERMINATE;
                if (ctx->index >= eirq->interrupt_count) {

Thanks
Hanjun
