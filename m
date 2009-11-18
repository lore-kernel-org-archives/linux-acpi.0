From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v1 0/5] IPMI devices from ACPI namespace
Date: Tue, 17 Nov 2009 17:05:09 -0700
Message-ID: <20091118000427.14214.14043.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:14018 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbZKRAFE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Nov 2009 19:05:04 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Corey Minyard <minyard@acm.org>, Bela Lubkin <blubkin@vmware.com>, linux-acpi@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>, openipmi-developer@lists.sourceforge.net, Len Brown <lenb@kernel.org>

Here's a sample of how I think the ACPI namespace device detection should
be done.  I think this is almost functionally equivalent to your "Locate
the IPMI system interface in ACPI namespace" patch.

The difference I'm aware of is that your patch doesn't call acpi_register_gsi()
for IRQs from the device _CRS, so I don't think those interrupts would work.
(I can't test this because I don't have a box that reports an IRQ in _CRS.)
PNPACPI takes care of this GSI registration for us.

Patches 3 & 4 are not really related to the main point here, but I left
them in because without 4, we'll report both SPMI and ACPI namespace
devices as being from "ACPI".

---

Bjorn Helgaas (5):
      PNPACPI: save struct acpi_device, not just acpi_handle
      PNP: add interface to retrieve ACPI device from a PNPACPI device
      ipmi: remove unused PCI probe code
      ipmi: refer to table as "SPMI", not "ACPI"
      ipmi: add PNP discovery (ACPI namespace via PNPACPI)


 drivers/char/ipmi/ipmi_si_intf.c |  118 +++++++++++++++++++++++++++++++++++---
 drivers/pnp/pnpacpi/core.c       |   19 ++++--
 drivers/pnp/pnpacpi/rsparser.c   |    9 ++-
 include/linux/pnp.h              |   13 ++++
 4 files changed, 141 insertions(+), 18 deletions(-)

-- 
Bjorn
