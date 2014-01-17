From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 09/20] ARM64 / ACPI: Implement core functions for parsing MADT table
Date: Fri, 17 Jan 2014 15:12:42 +0100
Message-ID: <201401171512.42850.arnd@arndb.de>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org> <1389961514-13562-10-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:52421 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752538AbaAQOMw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 17 Jan 2014 09:12:52 -0500
In-Reply-To: <1389961514-13562-10-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Charles.Garcia-Tobin@arm.com

On Friday 17 January 2014, Hanjun Guo wrote:
>  
> +/*
> + * Local interrupt controller address,
> + * GIC cpu interface base address on ARM/ARM64
> + */
> +static u64 acpi_lapic_addr __initdata;

If it's cpu local, don't you need more than one address to support SMP?
Also, the variable appears to be write-only.

> +#define BAD_MADT_ENTRY(entry, end) (					\
> +	(!entry) || (unsigned long)entry + sizeof(*entry) > end ||	\
> +	((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
> +

Better make this an inline function.

> +static int __init
> +acpi_parse_gic(struct acpi_subtable_header *header, const unsigned long end)
> +{
> +	struct acpi_madt_generic_interrupt *processor = NULL;
> +
> +	processor = (struct acpi_madt_generic_interrupt *)header;

You don't need the initialization in the first line when you write to the
variable before reading it. Same in the other functions.

	Arnd
