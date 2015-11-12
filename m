From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V2] acpi: add support for extended IRQ to PCI link
Date: Thu, 12 Nov 2015 01:14:41 -0500
Message-ID: <1447308882-29634-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53781 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbbKLGOt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Nov 2015 01:14:49 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com
Cc: Sinan Kaya <okaya@codeaurora.org>

The ACPI compiler uses the extended format when used
interrupt numbers are greater than 256. The PCI link code
currently only supports simple interrupt format. The IRQ
numbers are represented using 32 bits when extended IRQ
syntax. This patch changes the interrupt number type to
32 bits and places an upper limit of 1020 as possible
interrupt id.

1020 is the maximum interrupt ID that can be assigned to
an ARM SPI interrupt according to ARM architecture.

Additional checks have been placed to prevent out of bounds
writes.

Changes from V1: (https://lkml.org/lkml/2015/11/8/162)
* change the commit text to include 1020 magic interrupt number
limitation
* cleanup multiple levels of if statements

Sinan Kaya (1):
  acpi: add support for extended IRQ to PCI link

 drivers/acpi/pci_link.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

-- 
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project

