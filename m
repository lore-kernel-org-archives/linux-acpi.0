From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/9 v2] ACPI: remove .start() and .stop() methods
Date: Mon, 22 Jun 2009 14:40:59 -0600
Message-ID: <20090622204016.32761.47464.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:43162 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757415AbZFVUk6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2009 16:40:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

From: Bjorn Helgaas <bjorn.helgaas@hp.com>

These patches remove several .start() methods (by folding them into
.add() methods) and a .stop() method (by folding it into .remove()).
There are no remaining .stop() methods, so I also removed it from
the driver_ops structure.

This simplifies the ACPI driver structure and will make it easier to
support hotplug in the Linux/ACPI core.

They also remove the KOBJ_ONLINE and KOBJ_OFFLINE events generated
by the processor driver for CPU hotplug events.  As far as I know,
these events are unused.

I don't have a way to test most of these changes, unfortunately, so
I'd welcome any feedback or testing reports.

These apply to the acpi-test branch.

---

Bjorn Helgaas (9):
      ACPI: processor: remove KOBJ_ONLINE/KOBJ_OFFLINE events
      ACPI: processor: clean up in acpi_processor_start() error exits
      ACPI: processor: move acpi_processor_start() after acpi_processor_add()
      ACPI: processor: remove .start() method
      ACPI: memory hotplug: remove .start() method
      ACPI: EC: move acpi_ec_start() after acpi_ec_add()
      ACPI: EC: remove .start() method
      ACPI: EC: remove .stop() method
      ACPI: remove unused acpi_device_ops .stop method


 drivers/acpi/acpi_memhotplug.c |   40 +++----
 drivers/acpi/ec.c              |  118 ++++++++--------------
 drivers/acpi/processor_core.c  |  219 +++++++++++++++++-----------------------
 drivers/acpi/scan.c            |    5 -
 include/acpi/acpi_bus.h        |    2 
 5 files changed, 153 insertions(+), 231 deletions(-)

-- 
Bjorn
