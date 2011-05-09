From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH]: Fix PCIe error handling BIOS control message
Date: Mon, 9 May 2011 08:51:15 -0400
Message-ID: <20110509125115.24788.66625.sendpatchset@prarit.bos.redhat.com>
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37283 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752754Ab1EIMvQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 9 May 2011 08:51:16 -0400
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p49CpFYm011522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-acpi@vger.kernel.org>; Mon, 9 May 2011 08:51:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>

Trivial patch ... We've had a few customers who were concerned about this
message.  I thought it was fairly obvious, but I guess it isn't...

P.

---8<---

The implication of this message is that an error occurred and the BIOS handled
it.  Reword the message so that it is clear that the BIOS is taking control
of the handling of PCIe errors.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index f911a2f..ea11224 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -582,7 +582,7 @@ static int __devinit acpi_pci_root_add(struct acpi_device *device)
 		if (pci_aer_available()) {
 			if (aer_acpi_firmware_first())
 				dev_dbg(root->bus->bridge,
-					"PCIe errors handled by BIOS.\n");
+					"BIOS will handle PCIe errors.\n");
 			else
 				flags |= OSC_PCI_EXPRESS_AER_CONTROL;
 		}
