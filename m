From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 12/13] PCI: Preserve MPS and MRRS when applying _HPX
 settings
Date: Fri, 12 Sep 2014 12:04:09 -0600
Message-ID: <20140912180409.1630.66534.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20140912180141.1630.17120.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:54376 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbaILSEL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Sep 2014 14:04:11 -0400
Received: by mail-ig0-f176.google.com with SMTP id hn15so957915igb.3
        for <linux-acpi@vger.kernel.org>; Fri, 12 Sep 2014 11:04:11 -0700 (PDT)
In-Reply-To: <20140912180141.1630.17120.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: Rajat Jain <rajatxjain@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>

Linux manages MPS and MRRS settings to keep them consistent across the PCIe
fabric.  BIOS doesn't participate in Linux scheme, so ignore that part of
any _HPX settings it supplies.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/probe.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 1ff2105ba401..cb411fbb6435 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1301,6 +1301,16 @@ static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp)
 		return;
 	}
 
+	/*
+	 * Don't allow _HPX to change MPS or MRRS settings.  We manage
+	 * those to make sure they're consistent with the rest of the
+	 * platform.
+	 */
+	hpp->pci_exp_devctl_and |= PCI_EXP_DEVCTL_PAYLOAD |
+				    PCI_EXP_DEVCTL_READRQ;
+	hpp->pci_exp_devctl_or &= ~(PCI_EXP_DEVCTL_PAYLOAD |
+				    PCI_EXP_DEVCTL_READRQ);
+
 	/* Initialize Device Control Register */
 	pcie_capability_clear_and_set_word(dev, PCI_EXP_DEVCTL,
 			~hpp->pci_exp_devctl_and, hpp->pci_exp_devctl_or);

