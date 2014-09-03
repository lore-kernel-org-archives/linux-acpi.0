From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 13/17] ARM64 / ACPI: Add GICv2 specific ACPI boot support
Date: Wed, 03 Sep 2014 20:42:44 +0200
Message-ID: <2893693.4bZJXXENof@wuerfel>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org> <1409583475-6978-14-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:49764 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbaICSnU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Sep 2014 14:43:20 -0400
In-Reply-To: <1409583475-6978-14-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>, linaro-acpi@lists.linaro.org, Liviu Dudau <Liviu.Dudau@arm.com>, Lv Zheng <lv.zheng@intel.com>, Rob Herring <robh@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, Charles.Garcia-Tobin@arm.com, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Graeme Gregory <graeme.gregory@linaro.org>, Randy Dunlap <rdunlap@infradea>

On Monday 01 September 2014 22:57:51 Hanjun Guo wrote:
> +       /* Collect CPU base addresses */
> +       count = acpi_parse_entries(sizeof(struct acpi_table_madt),
> +                                  gic_acpi_parse_madt_cpu, table,
> +                                  ACPI_MADT_TYPE_GENERIC_INTERRUPT,
> +                                  ACPI_MAX_GIC_CPU_INTERFACE_ENTRIES);
> +       if (count < 0) {
> +               pr_err("Error during GICC entries parsing\n");
> +               return -EFAULT;
> +       } else if (!count) {
> +               /* No GICC entries provided, use address from MADT header */
> +               struct acpi_table_madt *madt = (struct acpi_table_madt *)table;
> +
> +               if (!madt->address)
> +                       return -EFAULT;
> +
> +               cpu_phy_base = (u64)madt->address;
> +       }

After I read through ACPI-5.1 section 5.2.12.14, I wonder if this is the
best way to treat a missing ACPI_MADT_TYPE_GENERIC_INTERRUPT table.

Do we expect to see those in practice? It seems like using the x86 local
APIC address as a fallback for the GIC address is not something we
should do unless we absolutely have to support a system that doesn't
have the GIC table.

	Arnd
