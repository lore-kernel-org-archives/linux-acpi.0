From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/5] PCI root bridge: get bus info from _CRS
Date: Thu, 18 Jun 2009 14:46:42 -0600
Message-ID: <20090618203916.15850.7977.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:14144 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbZFRUqj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jun 2009 16:46:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

The main patch in this series changes the way we discover the downstream bus
number of PCI root bridges.  The end result should be the same as the current
code (as far as I know, this doesn't fix any bugs).  But I believe this
follows the intent of the spec better, makes Linux work more like Windows,
and removes false accusations Linux makes against the BIOS.

---

Bjorn Helgaas (5):
      ACPI: pci_root: remove unused dev/fn information
      ACPI: pci_root: simplify list traversals
      ACPI: pci_root: use driver data rather than list lookup
      ACPI: pci_root: simplify acpi_pci_root_add() control flow
      ACPI: pci_root: check _CRS, then _BBN for downstream bus number

 drivers/acpi/pci_root.c |  185 ++++++++++++++---------------------------------
 1 files changed, 57 insertions(+), 128 deletions(-)
