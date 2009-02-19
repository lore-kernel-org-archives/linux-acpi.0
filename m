From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 1/2] ACPI: remove CONFIG_ACPI_SYSTEM
Date: Thu, 19 Feb 2009 12:56:16 -0700
Message-ID: <20090219195616.20757.42079.stgit@bob.kio>
References: <20090219195548.20757.53184.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:12883 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753497AbZBST4R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Feb 2009 14:56:17 -0500
In-Reply-To: <20090219195548.20757.53184.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Remove CONFIG_ACPI_SYSTEM.  It was always set the same as CONFIG_ACPI,
and it had no menu label, so there was no way to set it to anything
other than "y".

Some things under CONFIG_ACPI_SYSTEM (acpi_irq_handled, acpi_os_gpe_count(),
event_is_open, register_acpi_notifier(), etc.) are used unconditionally
by the CA, the OSPM, and drivers, so we depend on them always being
present.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/Kconfig  |    7 -------
 drivers/acpi/Makefile |    2 +-
 2 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index a7799a9..8a851d0 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -254,13 +254,6 @@ config ACPI_PCI_SLOT
 	  help you correlate PCI bus addresses with the physical geography
 	  of your slots. If you are unsure, say N.
 
-config ACPI_SYSTEM
-	bool
-	default y
-	help
-	  This driver will enable your system to shut down using ACPI, and
-	  dump your ACPI DSDT table using /proc/acpi/dsdt.
-
 config X86_PM_TIMER
 	bool "Power Management Timer Support" if EMBEDDED
 	depends on X86
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 65d90c7..b130ea0 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -52,7 +52,7 @@ obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI_CONTAINER)	+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
 obj-y				+= power.o
-obj-$(CONFIG_ACPI_SYSTEM)	+= system.o event.o
+obj-y				+= system.o event.o
 obj-$(CONFIG_ACPI_DEBUG)	+= debug.o
 obj-$(CONFIG_ACPI_NUMA)		+= numa.o
 obj-$(CONFIG_ACPI_HOTPLUG_MEMORY)	+= acpi_memhotplug.o

