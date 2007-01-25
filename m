From: "Gordon Stanton" <fixacpi@gmail.com>
Subject: [PATCH] Add Micro-Star as a PCI VENDOR
Date: Thu, 25 Jan 2007 12:15:51 +1100
Message-ID: <c1cd85210701241715p29fb437dy9400e74afaf8bbf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:60883 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbXAYBPx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jan 2007 20:15:53 -0500
Received: by wr-out-0506.google.com with SMTP id i22so292515wra
        for <linux-acpi@vger.kernel.org>; Wed, 24 Jan 2007 17:15:52 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, lm-sensors@lm-sensors.org, s270-linux@mail.0pointer.de, linux-pci@atrey.karlin.mff.cuni.cz

Hi,
I noticed that a common motherboard manufacturer Micro-Star was
missing it's PCI_VENDOR_ID and so I have sent this patch in.
Later on I will send a patch to pci/quirks.c to unhide the SMBus on
the M510C laptop once I have investigated it a bit more. It hides the
SMBus the same as ASUS (and a couple of others) laptops.
This is definately the correct ID, see
http://www.pcidatabase.com/vendor_details.php?id=705

I would also be happy with PCI_VENDOR_ID_MICRO_STAR instead, what do you think?

Signed-off-by: Gordon Stanton <fixacpi@gmail.com>

---

--- linux-2.6.20-rc5/include/linux/pci_ids.h	2007-01-13 05:54:26.000000000 +1100
+++ linux/include/linux/pci_ids.h	2007-01-25 11:43:30.478249500 +1100
@@ -1875,6 +1875,8 @@

 #define PCI_VENDOR_ID_SAMSUNG		0x144d

+#define PCI_VENDOR_ID_MICROSTAR		0x1462
+
 #define PCI_VENDOR_ID_MYRICOM		0x14c1

 #define PCI_VENDOR_ID_TITAN		0x14D2
