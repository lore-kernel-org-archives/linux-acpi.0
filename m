From: Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 0/2] ACPI / PCI: Fix _PRT lookup for ARI enabled devices
Date: Tue, 26 May 2015 11:53:55 -0600
Message-ID: <20150526174611.31963.91186.stgit@gimli.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49503 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752589AbbEZRyB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 May 2015 13:54:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, lenb@kernel.org

In most cases we only use ARI with SR-IOV VFs, which do not support
INTx and therefore never hit this problem.  However, some non-SR-IOV
implementations create multiple PFs, extending beyond the standard
3-bit function numbers with ARI, and do support INTx for those
additional functions.  This can happen with Solarflare SFC9120
adapters.  The host driver typically doesn't use INTx, so we also
haven't noticed this problem on bare metal, but when we attempt to
assign the device to a VM using vfio-pci, we fail trying to setup
default INTx signaling.  Thanks,

Alex

---

Alex Williamson (2):
      PCI: Move pci_ari_enabled() to global header
      ACPI / PCI: Account for ARI in _PRT lookups


 drivers/acpi/pci_irq.c |    4 ++--
 drivers/pci/pci.h      |   11 -----------
 include/linux/pci.h    |   11 +++++++++++
 3 files changed, 13 insertions(+), 13 deletions(-)
