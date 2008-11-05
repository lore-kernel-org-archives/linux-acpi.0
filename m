From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 07/11] ACPI: add CONFIG_ACPI_PCI
Date: Wed, 05 Nov 2008 16:18:08 -0700
Message-ID: <20081105231808.26131.31742.stgit@bob.kio>
References: <20081105231710.26131.3110.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:32591 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622AbYKEXSJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Nov 2008 18:18:09 -0500
In-Reply-To: <20081105231710.26131.3110.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

Add CONFIG_ACPI_PCI.  This makes it possible to omit the PCI-related
ACPI drivers if we build with CONFIG_ACPI=y and CONFIG_PCI=n.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/Kconfig  |    3 +++
 drivers/acpi/Makefile |    2 +-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 768bb07..7962bfc 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -330,6 +330,9 @@ config ACPI_DEBUG_FUNC_TRACE
 	  ACPI Debug Statements slow down ACPI processing. Function trace
 	  is about half of the penalty and is rarely useful.
 
+config ACPI_PCI
+	def_bool y if PCI
+
 config ACPI_PCI_SLOT
 	tristate "PCI slot detection driver"
 	default n
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index fc62231..d0ee4c5 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -46,7 +46,7 @@ obj-$(CONFIG_ACPI_BUTTON)	+= button.o
 obj-$(CONFIG_ACPI_FAN)		+= fan.o
 obj-$(CONFIG_ACPI_DOCK)		+= dock.o
 obj-$(CONFIG_ACPI_VIDEO)	+= video.o
-obj-y				+= pci_root.o pci_link.o pci_irq.o pci_bind.o
+obj-$(CONFIG_ACPI_PCI)		+= pci_root.o pci_link.o pci_irq.o pci_bind.o
 obj-$(CONFIG_ACPI_PCI_SLOT)	+= pci_slot.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI_CONTAINER)	+= container.o

