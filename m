From: Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH V5 1/2] ACPI: Add support for ResourceSource/IRQ domain
 mapping
Date: Sun, 23 Oct 2016 17:48:18 +0800
Message-ID: <580C8762.7040809@huawei.com>
References: <1476812509-2760-1-git-send-email-agustinv@codeaurora.org>
 <1476812509-2760-2-git-send-email-agustinv@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:5049 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756508AbcJWJtY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Oct 2016 05:49:24 -0400
In-Reply-To: <1476812509-2760-2-git-send-email-agustinv@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Agustin Vega-Frias <agustinv@codeaurora.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, lenb@kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com
Cc: timur@codeaurora.org, cov@codeaurora.org, agross@codeaurora.org, harba@codeaurora.org, jcm@redhat.com, msalter@redhat.com, mlangsdo@redhat.com, ahs3@redhat.com, astone@redhat.com, graeme.gregory@linaro.org, charles.garcia-tobin@arm.com

On 2016/10/19 1:41, Agustin Vega-Frias wrote:
> This allows irqchip drivers to associate an ACPI DSDT device to
> an IRQ domain and provides support for using the ResourceSource
> in Extended IRQ Resources to find the domain and map the IRQs
> specified on that domain.
>
> Signed-off-by: Agustin Vega-Frias <agustinv@codeaurora.org>
> ---
[...]
> +/**
> + * acpi_irq_domain_register_irq() - Register the mapping for an IRQ produced
> + *                                  by the given acpi_resource_source to a
> + *                                  Linux IRQ number
> + * @source: IRQ source
> + * @hwirq: Hardware IRQ number
> + * @trigger: trigger type of the IRQ number to be mapped
> + * @polarity: polarity of the IRQ to be mapped
> + *
> + * Returns: a valid linux IRQ number on success
> + *          -ENODEV if the given acpi_resource_source cannot be found
> + *          -EPROBE_DEFER if the IRQ domain has not been registered
> + *          -EINVAL for all other errors
> + */
> +int acpi_irq_domain_register_irq(const struct acpi_resource_source *source,
> +				 u32 hwirq, int trigger, int polarity)
> +{
> +	struct irq_fwspec fwspec;
> +	struct acpi_device *device;
> +	acpi_handle handle;
> +	acpi_status status;
> +	int ret;
> +
> +	/* An empty acpi_resource_source means it is a GSI */
> +	if (!source->string_length)
> +		return acpi_register_gsi(NULL, hwirq, trigger, polarity);
> +
> +	status = acpi_get_handle(NULL, source->string_ptr, &handle);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	device = acpi_bus_get_acpi_device(handle);
> +	if (!device)
> +		return -ENODEV;
> +
> +	ret = acpi_irq_domain_ensure_probed(device);
> +	if (ret)
> +		goto out_put_device;
> +
> +	fwspec.fwnode = &device->fwnode;
> +	fwspec.param[0] = hwirq;
> +	fwspec.param[1] = acpi_dev_get_irq_type(trigger, polarity);
> +	fwspec.param_count = 2;
> +
> +	ret = irq_create_fwspec_mapping(&fwspec);
> +
> +out_put_device:
> +	acpi_bus_put_acpi_device(device);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(acpi_irq_domain_register_irq);
> +
> +/**
> + * acpi_irq_domain_unregister_irq() - Delete the mapping for an IRQ produced
> + *                                    by the given acpi_resource_source to a
> + *                                    Linux IRQ number
> + * @source: IRQ source
> + * @hwirq: Hardware IRQ number
> + *
> + * Returns: 0 on success
> + *          -ENODEV if the given acpi_resource_source cannot be found
> + *          -EINVAL for all other errors
> + */
> +int acpi_irq_domain_unregister_irq(const struct acpi_resource_source *source,
> +				   u32 hwirq)
> +{
> +	struct irq_domain *domain;
> +	struct acpi_device *device;
> +	acpi_handle handle;
> +	acpi_status status;
> +	int ret = 0;
> +
> +	if (!source->string_length) {
> +		acpi_unregister_gsi(hwirq);
> +		return 0;
> +	}
> +
> +	status = acpi_get_handle(NULL, source->string_ptr, &handle);
> +	if (ACPI_FAILURE(status))
> +		return -ENODEV;
> +
> +	device = acpi_bus_get_acpi_device(handle);
> +	if (!device)
> +		return -ENODEV;
> +
> +	domain = irq_find_matching_fwnode(&device->fwnode, DOMAIN_BUS_ANY);
> +	if (!domain) {
> +		ret = -EINVAL;
> +		goto out_put_device;
> +	}
> +
> +	irq_dispose_mapping(irq_find_mapping(domain, hwirq));
> +
> +out_put_device:
> +	acpi_bus_put_acpi_device(device);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(acpi_irq_domain_unregister_irq);

I think Marc already raised this before, which irqdomain.c is similar to
gsi.c in drivers/acpi/, I prepared another approach [1] which avoid this,
I'm open for comments.

I think it's pretty important to finalize the directions we are going,
then avoid the duplicate work and speedup for upstream, Marc, Rafael,
Lorenzo, could you give us suggestions for this?

Thanks
Hanjun

[1]: https://patchwork.kernel.org/patch/9331771/

