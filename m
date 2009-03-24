From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 10/10] ACPI: tidy up makefile
Date: Tue, 24 Mar 2009 16:50:24 -0600
Message-ID: <20090324225024.1262.43760.stgit@bob.kio>
References: <20090324224834.1262.65260.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0028.austin.hp.com ([15.216.28.35]:35858 "EHLO
	g1t0028.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835AbZCXWuZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2009 18:50:25 -0400
In-Reply-To: <20090324224834.1262.65260.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>Li Shaohua <shaohua.li@intel.com>, Zhao Yakui <yakui.zhao@intel.com>

This patch removes the suggestion that ec.o link order is important,
because it doesn't matter since acpi_ec_init() is no longer an initcall.
And it puts together most of the core modules that are not configurable.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/Makefile |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index b130ea0..61675e2 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -32,10 +32,8 @@ ifdef CONFIG_CPU_FREQ
 processor-objs	+= processor_perflib.o
 endif
 
-obj-y				+= bus.o glue.o
-obj-y				+= scan.o
-# Keep EC driver first. Initialization of others depend on it.
-obj-y				+= ec.o
+obj-y				+= bus.o glue.o scan.o ec.o \
+					power.o system.o event.o
 obj-$(CONFIG_ACPI_AC) 		+= ac.o
 obj-$(CONFIG_ACPI_BATTERY)	+= battery.o
 obj-$(CONFIG_ACPI_BUTTON)	+= button.o
@@ -51,8 +49,6 @@ obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI_CONTAINER)	+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
-obj-y				+= power.o
-obj-y				+= system.o event.o
 obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o

