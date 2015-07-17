From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v3 2/8] ACPI / irqchip: Add self-probe infrastructure to
 initialize IRQ controller
Date: Fri, 17 Jul 2015 18:15:00 -0500
Message-ID: <CAOZdJXWB71tzc=OMm_UH23jc+_wsA5=pC5W9arrEM-URm_sywg@mail.gmail.com>
References: <1436525114-14425-1-git-send-email-hanjun.guo@linaro.org>
	<1436525114-14425-3-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:33943 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbbGQXPC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jul 2015 19:15:02 -0400
In-Reply-To: <1436525114-14425-3-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Jason Cooper <jason@lakedaemon.net>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wei Huang <wei@redhat.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, linaro-acpi@lists.linaro.org, lkml <linux-kernel@vger.kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, Grant Likely <grant.likely@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jul 10, 2015 at 5:45 AM, Hanjun Guo <hanjun.guo@linaro.org> wrote:

> +void __init acpi_irqchip_init(void)
> +{
> +       struct acpi_table_id *id;
> +
> +       if (acpi_disabled)
> +               return;
> +
> +       if (acpi_gic_version_init())
> +               return;
> +
> +       /* scan the irqchip table to match the GIC version and its driver */
> +       for (id = __irqchip_acpi_table; id->id[0]; id++) {
> +               if (gic_version == (u8)id->driver_data)
> +                       acpi_table_parse(id->id,
> +                                        (acpi_tbl_table_handler)id->handler);
> +       }

Should we display an error message if we don't find a matching table?
That can happen if the ACPI tables shows a GIC version number that is
not listed in __irqchip_acpi_table[]?
