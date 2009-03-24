From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/3] ACPI: remove unused driver ops and flags
Date: Tue, 24 Mar 2009 10:55:17 -0600
Message-ID: <20090324165420.25119.78955.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:1293 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762656AbZCXQzV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 12:55:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Rajesh Shah <rajesh.shah@intel.com>

These patches remove a few unused driver ops and flags.

Comments welcome.

Bjorn Helgaas (3):
      ACPI: remove unused acpi_bus_ops flags
      ACPI: remove unused acpi_device_ops .shutdown method
      ACPI: remove unused acpi_device_ops .lock and .scan methods

 drivers/acpi/scan.c     |   12 ------------
 include/acpi/acpi_bus.h |   16 ----------------
 2 files changed, 0 insertions(+), 28 deletions(-)
