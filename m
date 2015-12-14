From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v7 1/4] acpi: pci: Setup MSI domain for ACPI based pci
 devices
Date: Mon, 14 Dec 2015 15:13:48 +0000
Message-ID: <566EDCAC.1080401@arm.com>
References: <1449766530-16935-1-git-send-email-Suravee.Suthikulpanit@amd.com> <1449766530-16935-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43523 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103AbbLNPNx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 Dec 2015 10:13:53 -0500
In-Reply-To: <1449766530-16935-2-git-send-email-Suravee.Suthikulpanit@amd.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, bhelgaas@google.com
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, hanjun.guo@linaro.org, tomasz.nowicki@linaro.org, graeme.gregory@linaro.org, dhdang@apm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org

On 10/12/15 16:55, Suravee Suthikulpanit wrote:
> This patch introduces pci_msi_register_fwnode_provider() for irqchip
> to register a callback, to provide a way to determine appropriate MSI
> domain for a pci device.
> 
> It also introduces pci_host_bridge_acpi_msi_domain(), which returns
> the MSI domain of the specified PCI host bridge with DOMAIN_BUS_PCI_MSI
> bus token. Then, it is assigned to pci device.
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Bjorn, Rafael,

Do you have any comment on this?

I was hoping to queue this work (and the 3 patches that depend on it)
for 4.5, but if you don't have the bandwidth to review it, I'll postpone
it to the following merge window.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
