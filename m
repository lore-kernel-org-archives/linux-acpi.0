From: Myron Stowe <myron.stowe@hp.com>
Subject: [PATCH 0/4] ipmi: remove SPMI and update core driver with dev_printk
Date: Wed, 03 Mar 2010 20:44:05 -0700
Message-ID: <20100304033146.30205.68689.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:40827 "EHLO
	g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728Ab0CDDoH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Mar 2010 22:44:07 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: minyard@acm.org
Cc: linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net, lenb@kernel.org

These patches remove the SPMI based IPMI device discovery mechanism and
update the driver's core to use dev_printk() and its constructs.

As part of this patch series I wanted to remove the 'PFX' argument from
ipmi_of_probe()'s dev_printk constructs as I believe it produces redundant
output but I do not have a PPC platform to test against.

Ultimately, I would like to see if it is possible to also remove IPMI's
SMBIOS based device discovery mechanism.

---

Myron Stowe (4):
      ipmi: Raise precedence of PNP based discovery mechanisms (ACPI, PCI)
      ipmi: Remove SPMI table based device discovery method
      ipmi: Convert tracking of the ACPI device pointer to a PNP device
      ipmi: Update driver to use 'dev_printk()' and its constructs


 drivers/char/ipmi/ipmi_bt_sm.c      |    2 
 drivers/char/ipmi/ipmi_msghandler.c |   11 +
 drivers/char/ipmi/ipmi_si_intf.c    |  277 +++++++----------------------------
 3 files changed, 60 insertions(+), 230 deletions(-)

