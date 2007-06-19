From: "Andreas Herrmann" <andreas.herrmann3@amd.com>
Subject: [PATCH 3/12] acpi: fix compile error with ACPI && !ACPI_POWER
Date: Wed, 20 Jun 2007 00:48:58 +0200
Message-ID: <20070619224858.GE5193@alberich.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760131AbXFSWth@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Fix compile error with ACPI && !ACPI_POWER as bus.c
depends on power.c

Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 drivers/acpi/Kconfig  |    4 ----
 drivers/acpi/Makefile |    2 +-
 2 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 139f41f..9d6baab 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -288,10 +288,6 @@ config ACPI_EC
 	  the battery and thermal drivers.  If you are compiling for a 
 	  mobile system, say Y.
 
-config ACPI_POWER
-	bool
-	default y
-
 config ACPI_SYSTEM
 	bool
 	default y
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d4336f1..9485cc3 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -48,7 +48,7 @@ obj-$(CONFIG_ACPI_DOCK)		+= dock.o
 obj-$(CONFIG_ACPI_BAY)		+= bay.o
 obj-$(CONFIG_ACPI_VIDEO)	+= video.o
 obj-y				+= pci_root.o pci_link.o pci_irq.o pci_bind.o
-obj-$(CONFIG_ACPI_POWER)	+= power.o
+obj-y				+= power.o
 obj-$(CONFIG_ACPI_PROCESSOR)	+= processor.o
 obj-$(CONFIG_ACPI_CONTAINER)	+= container.o
 obj-$(CONFIG_ACPI_THERMAL)	+= thermal.o
-- 
1.5.0.7
