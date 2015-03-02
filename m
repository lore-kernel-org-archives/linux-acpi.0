From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: [Debug 0/2] Debug PCI root resource parsing failure
Date: Mon,  2 Mar 2015 12:33:19 +0800
Message-ID: <1425270801-20270-1-git-send-email-jiang.liu@linux.intel.com>
References: <alpine.LSU.2.11.1502281100540.15780@er-systems.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:7512 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752235AbbCBEan (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 1 Mar 2015 23:30:43 -0500
In-Reply-To: <alpine.LSU.2.11.1502281100540.15780@er-systems.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Voegtle <tv@lio96.de>
Cc: Jiang Liu <jiang.liu@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Dave Airlie <airlied@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Lv Zheng <lv.zheng@intel.com>

Hi Thomas,
	I still can't figure out why the last resource entry "pci_bus
0000:00: root bus resource [mem 0x80000000-0xd0716ffe]" gets ignored
by new code. Could you please help to apply these two patches and send
me back dmesg?
Thanks!
Gerry

Jiang Liu (2):
  x86/PCI/ACPI: Ignore resources consumed by host bridge itself
  x86/PCI/ACPI: Gather debug info

 arch/x86/pci/acpi.c     |   13 ++++++++++---
 drivers/acpi/resource.c |    2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
1.7.10.4

