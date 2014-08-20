From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 0/4] usb: dwc3: ACPI support
Date: Wed, 20 Aug 2014 14:55:24 +0300
Message-ID: <1408535728-10518-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1224 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286AbaHTLzd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Aug 2014 07:55:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

And Intel Braswell PCI ID


Alan Cox (1):
  usb: dwc3: pci: Add PCI ID for Intel Braswell

Heikki Krogerus (3):
  ACPI / platform: provide default DMA mask
  usb: dwc3: core: only setting the dma_mask when needed
  usb: dwc3: add ACPI support

 drivers/acpi/acpi_platform.c |  2 ++
 drivers/usb/dwc3/core.c      | 18 +++++++++++++++---
 drivers/usb/dwc3/dwc3-pci.c  |  2 ++
 3 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.1.0

