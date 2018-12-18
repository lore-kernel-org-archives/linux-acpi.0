From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v11 7/7] ACPI: Make PCI slot detection driver depend on PCI
Date: Tue, 18 Dec 2018 02:56:06 +0000
Message-ID: <20181218025606.32668-8-okaya@kernel.org>
References: <20181218025606.32668-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218025606.32668-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Since this is ACPI PCI slot detection driver for PCI, it doesn't make sense
to compile this without PCI support in place.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index a0abcb3bd673..8b6ff80a69cd 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -369,7 +369,7 @@ config ACPI_DEBUG
 
 config ACPI_PCI_SLOT
 	bool "PCI slot detection driver"
-	depends on SYSFS
+	depends on SYSFS && PCI
 	help
 	  This driver creates entries in /sys/bus/pci/slots/ for all PCI
 	  slots in the system.  This can help correlate PCI bus addresses,
-- 
2.19.0
