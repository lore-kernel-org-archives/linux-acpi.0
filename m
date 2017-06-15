From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 1/2] ARM64/irqchip: Update ACPI_IORT symbol selection
 logic
Date: Thu, 15 Jun 2017 08:28:33 +0100
Message-ID: <8d9f0454-2fd0-7b88-5f07-77a3d063515a@arm.com>
References: <20170614163713.14574-1-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:42444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750861AbdFOH2g (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Jun 2017 03:28:36 -0400
In-Reply-To: <20170614163713.14574-1-lorenzo.pieralisi@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-acpi@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On 14/06/17 17:37, Lorenzo Pieralisi wrote:
> ACPI IORT is an ACPI addendum to describe the connection topology of
> devices with IOMMUs and interrupt controllers on ARM64 ACPI systems.
> 
> Currently the ACPI IORT Kbuild symbol is selected whenever the Kbuild
> symbol ARM_GIC_V3_ITS is enabled, which in turn is selected by ARM64
> Kbuild defaults. This makes the logic behind ACPI_IORT selection a bit
> twisted and not easy to follow. On ARM64 systems enabling ACPI the
> kbuild symbol ACPI_IORT should always be selected in that it is a kernel
> layer provided to the ARM64 arch code to parse and enable ACPI firmware
> bindings.
> 
> Make the ACPI_IORT selection explicit in ARM64 Kbuild and remove the
> selection from ARM_GIC_V3_ITS entry, making the ACPI_IORT selection
> logic clearer to follow.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
