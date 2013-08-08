From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 0/2] ACPI: return error in acpi_pci_irq_enable when there is no irq
Date: Thu,  8 Aug 2013 15:35:12 +0300
Message-ID: <1375965314-24232-1-git-send-email-heikki.krogerus@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:28171 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964794Ab3HHMcB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 8 Aug 2013 08:32:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Prarit Bhargava <prarit@redhat.com>, linux-acpi@vger.kernel.org

Hi,

This is the fix for the Dell PowerEdge 840 issue where nothing
allocated an irq for it's PCH if I understood correctly. The issue was
reported by Prarit Bhargava.

The second patch is just a minor cleanup.

Thanks,


Heikki Krogerus (2):
  ACPI / PCI: don't allow PCI devices without irq to be enabled
  ACPI / PCI: remove an extra check from acpi_pci_irq_enable()

 drivers/acpi/pci_irq.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
1.8.3.2

