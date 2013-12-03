From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC part1 PATCH 3/7] ACPI / processor_core: Rework _PDC
 related stuff to make it more arch-independent
Date: Tue, 3 Dec 2013 16:46:23 +0000
Message-ID: <20131203164623.GB13447@srcf.ucam.org>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <1386088611-2801-4-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:33803 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412Ab3LCQq0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Dec 2013 11:46:26 -0500
Content-Disposition: inline
In-Reply-To: <1386088611-2801-4-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Olof Johansson <olof@lixom.net>, Linus Walleij <linus.walleij@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <rob.herring@calxeda.com>, Mark Rutland <mark.rutland@arm.com>, Jon Masters <jonathan@jonmasters.org>, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, linaro-acpi@lists.linaro.org, Graeme Gregory <graeme.gregory@linaro.org>

On Wed, Dec 04, 2013 at 12:36:47AM +0800, Hanjun Guo wrote:

> +#if defined(CONFIG_X86) || defined(CONFIG_IA64)
>  	/* Enable coordination with firmware's _TSD info */
>  	buf[2] = ACPI_PDC_SMP_T_SWCOORD;
> +	if (boot_option_idle_override == IDLE_NOMWAIT) {
> +		/*
> +		 * If mwait is disabled for CPU C-states, the C2C3_FFH access
> +		 * mode will be disabled in the parameter of _PDC object.
> +		 * Of course C1_FFH access mode will also be disabled.
> +		 */
> +		buf[2] &= ~(ACPI_PDC_C_C2C3_FFH | ACPI_PDC_C_C1_FFH);
> +
> +	}
> +#endif

This is (fairly) arch-specific, so why not move it to 
arch_acpi_set_pdc_bits()?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
