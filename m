From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH V6 7/7] irqchip/gicv3-its: Use MADT ITS subtable to do
 PCI/MSI domain initialization
Date: Wed, 15 Jun 2016 10:03:53 +0100
Message-ID: <20160615100353.4b13a48c@arm.com>
References: <1465828873-23498-1-git-send-email-tn@semihalf.com>
	<1465828873-23498-8-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35508 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277AbcFOJEc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jun 2016 05:04:32 -0400
In-Reply-To: <1465828873-23498-8-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, bhelgaas@google.com, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org, al.stone@linaro.org, mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com, okaya@codeaurora.org, andrea.gallo@linaro.org, linux-pci@vger.kernel.org

On Mon, 13 Jun 2016 16:41:13 +0200
Tomasz Nowicki <tn@semihalf.com> wrote:

> Let ACPI build ITS PCI MSI domain. ACPI is responsible for retrieving
> inner domain token and passing it on to its_pci_msi_init_one generic
> init call.
> 
> We have now full PCI MSI domain stack, thus we can enable ITS initialization
> from GICv3 core driver for ACPI scenario.
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
