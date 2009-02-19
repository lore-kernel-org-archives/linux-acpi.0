From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 0/3] ACPI: trim acpi_drivers.h
Date: Thu, 19 Feb 2009 12:51:38 -0700
Message-ID: <20090219195009.20619.20334.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:46034 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992AbZBSTvj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Feb 2009 14:51:39 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

The include/acpi/acpi_drivers.h file contains declarations
for several unrelated ACPI drivers, as well as things needed
only within the ACPI core (a.k.a. the "OSPM").

These patches move some of those declarations out into new
driver-specific and OSPM-specific header files where they
aren't visible to the world.

Comments welcome.

Bjorn

---

Bjorn Helgaas (3):
      ACPI: move internal core declarations to private header
      ACPI: processor: make new processor.h header local to driver
      ACPI: pci: make new pci.h header local to driver


 drivers/acpi/bus.c               |    2 ++
 drivers/acpi/ospm.h              |   23 +++++++++++++++++++
 drivers/acpi/pci.h               |   18 +++++++++++++++
 drivers/acpi/pci_bind.c          |    2 ++
 drivers/acpi/pci_irq.c           |    2 ++
 drivers/acpi/pci_root.c          |    2 ++
 drivers/acpi/processor.h         |    5 ++++
 drivers/acpi/processor_core.c    |    2 ++
 drivers/acpi/processor_thermal.c |    2 ++
 drivers/acpi/scan.c              |    2 ++
 drivers/acpi/sleep.c             |    1 +
 drivers/acpi/thermal.c           |    2 ++
 drivers/acpi/wakeup.c            |    1 +
 include/acpi/acpi_drivers.h      |   46 --------------------------------------
 14 files changed, 64 insertions(+), 46 deletions(-)
 create mode 100644 drivers/acpi/ospm.h
 create mode 100644 drivers/acpi/pci.h
 create mode 100644 drivers/acpi/processor.h

-- 
Signature
