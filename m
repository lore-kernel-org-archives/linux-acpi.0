From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/9] ACPI: remove .start() and .stop() methods
Date: Fri, 19 Jun 2009 15:31:34 -0600
Message-ID: <20090619213038.18001.16533.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:22977 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbZFSVbb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Jun 2009 17:31:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

These patches remove several .start() methods (by folding them into
.add() methods) and a .stop() method (by folding it into .remove()).
There are no remaining .stop() methods, so I also removed it from
the driver_ops structure.

This simplifies the ACPI driver structure and will make it easier to
support hotplug in the Linux/ACPI core.

I don't have a way to test most of these changes, unfortunately, so
I'd welcome any feedback or testing reports.

---

Bjorn Helgaas (9):
      ACPI: memory hotplug: remove .start() method
      ACPI: processor: clean up in acpi_processor_start() error exits
      ACPI: processor: emit "online" event in acpi_processor_start()
      ACPI: processor: move acpi_processor_start() after acpi_processor_add()
      ACPI: processor: remove .start() method
      ACPI: EC: move acpi_ec_start() after acpi_ec_add()
      ACPI: EC: remove .start() method
      ACPI: EC: remove .stop() method
      ACPI: remove unused acpi_device_ops .stop method


 drivers/acpi/acpi_memhotplug.c |   40 +++-----
 drivers/acpi/ec.c              |  118 ++++++++--------------
 drivers/acpi/processor_core.c  |  213 ++++++++++++++++++----------------------
 drivers/acpi/scan.c            |    5 -
 include/acpi/acpi_bus.h        |    2 
 5 files changed, 152 insertions(+), 226 deletions(-)

-- 
Bjorn
