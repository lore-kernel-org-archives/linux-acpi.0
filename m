From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH V6 2/7] PCI/MSI: Setup MSI domain on a per-devices basis
 using IORT ACPI table
Date: Wed, 15 Jun 2016 09:33:03 +0100
Message-ID: <20160615093303.1dd3fee1@arm.com>
References: <1465828873-23498-1-git-send-email-tn@semihalf.com>
	<1465828873-23498-3-git-send-email-tn@semihalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:35187 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429AbcFOIdn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Jun 2016 04:33:43 -0400
In-Reply-To: <1465828873-23498-3-git-send-email-tn@semihalf.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomasz Nowicki <tn@semihalf.com>
Cc: tglx@linutronix.de, jason@lakedaemon.net, rjw@rjwysocki.net, bhelgaas@google.com, lorenzo.pieralisi@arm.com, robert.richter@caviumnetworks.com, shijie.huang@arm.com, Suravee.Suthikulpanit@amd.com, hanjun.guo@linaro.org, al.stone@linaro.org, mw@semihalf.com, graeme.gregory@linaro.org, Catalin.Marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ddaney.cavm@gmail.com, okaya@codeaurora.org, andrea.gallo@linaro.org, linux-pci@vger.kernel.org

On Mon, 13 Jun 2016 16:41:08 +0200
Tomasz Nowicki <tn@semihalf.com> wrote:

> It is possible to provide information about which MSI controller to
> use on a per-device basis for DT. This patch supply this with ACPI support.
> 
> Currently, IORT is the only one ACPI table which can provide such mapping.
> In order to plug IORT into MSI infrastructure we are adding ACPI
> equivalents for finding PCI device domain and its RID translation
> (pci_msi_domain_get_msi_rid and pci_msi_domain_get_msi_rid calls).
> 
> Signed-off-by: Tomasz Nowicki <tn@semihalf.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
