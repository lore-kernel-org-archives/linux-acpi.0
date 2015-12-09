From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V9 0/2] ACPI, PCI, irq: remove interrupt limitations
Date: Wed,  9 Dec 2015 11:18:26 -0500
Message-ID: <1449677909-12432-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50808 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbbLIQSg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2015 11:18:36 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, helgaas@kernel.org
Cc: Sinan Kaya <okaya@codeaurora.org>

Code currently supports 256 maximum interrupts at this moment. The patch is
reconfiguring the penalty array as a dynamic list to remove this
limitation.

The ACPI compiler uses the extended format when used interrupt numbers
are greater than 15. The extended IRQ is 32 bits according to the ACPI
spec. The code supports parsing the extended interrupt numbers. However,
due to used data structure type; the code silently truncates interrupt
numbers greater than 256.

Changes from V8: (https://lkml.org/lkml/2015/12/3/579)
* split the patch into two as
** ACPI, PCI, irq: remove interrupt count restriction
** ACPI, PCI, irq: remove interrupt number restriction
* add acpi_irq_add_penalty API to simplify code

Sinan Kaya (2):
  ACPI, PCI, irq: remove interrupt count restriction
  ACPI, PCI, irq: remove interrupt number restriction

 drivers/acpi/pci_link.c | 140 +++++++++++++++++++++++++++++++++++-------------
 1 file changed, 104 insertions(+), 36 deletions(-)

-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

