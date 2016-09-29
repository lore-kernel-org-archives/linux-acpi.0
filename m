From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: 4.7 regression: ACPI: No IRQ available for PCI Interrupt Link
 [LNKD]. Try pci=noacpi or acpi=off
Date: Thu, 29 Sep 2016 10:35:13 -0400
Message-ID: <5f6956d8-c752-41ea-8ec3-9e49f128eba4@codeaurora.org>
References: <201609251512.05657.linux@rainbow-software.org>
 <201609291110.50176.linux@rainbow-software.org>
 <131b4220b509ed95dfbb35a441ccbc2c@codeaurora.org>
 <201609291549.07784.linux@rainbow-software.org>
 <e90fb01a-77e3-a094-9631-0b703972c750@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45686 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932255AbcI2OfR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Sep 2016 10:35:17 -0400
In-Reply-To: <e90fb01a-77e3-a094-9631-0b703972c750@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ondrej Zary <linux@rainbow-software.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, wim@djo.tudelft.nl, ravikanth.nalla@hpe.com

On 9/29/2016 10:28 AM, Sinan Kaya wrote:
> +		if (irq < ACPI_MAX_ISA_IRQS)

BTW, can you change this line to

	if (link->irq.active < ACPI_MAX_ISA_IRQS)

after applying.

> +			acpi_isa_irq_penalty[link->irq.active] +=
> +				PIRQ_PENALTY_PCI_USING;

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
