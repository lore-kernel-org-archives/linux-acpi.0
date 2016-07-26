From: Rui Wang <rui.y.wang@intel.com>
Subject: [PATCH 0/4] Fixing a set of bugs for ioapic hotplug
Date: Wed, 27 Jul 2016 00:13:13 +0800
Message-ID: <1469549597-19253-1-git-send-email-rui.y.wang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63200 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757201AbcGZQ3e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Jul 2016 12:29:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: helgaas@kernel.org, tglx@linutronix.de, rjw@rjwysocki.net, tony.luck@intel.com
Cc: bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, rui.y.wang@intel.com

Hi all,

The 1st patch has been discussed before Bjorn went on vacation. I've fixed
all the issues. Bjorn, please advise how we'll move forward.

The remaining patches fix newly found bugs while testing ioapic hotplug.

Regards,
Rui

Rui Wang (4):
  x86/ioapic: Support hot-removal of IOAPICs present during boot
  x86/ioapic: Fix setup_res() failing to get resource
  x86/ioapic: Fix lost ioapic resource after hot-removal and hotadd
  x86/ioapic: Fix ioapic failing to request resource

 drivers/acpi/internal.h |  2 --
 drivers/acpi/ioapic.c   | 47 +++++++++++++++++++++++++++--------------------
 drivers/acpi/pci_root.c | 13 ++++++++++++-
 drivers/pci/setup-bus.c |  5 ++++-
 include/linux/acpi.h    |  6 ++++++
 5 files changed, 49 insertions(+), 24 deletions(-)

-- 
1.8.3.1

