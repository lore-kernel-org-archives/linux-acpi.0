From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v5 5/5] ACPI / OSL: Remove PCI bits from ACPICA when CONFIG_PCI is unset
Date: Wed, 12 Dec 2018 05:28:45 +0000
Message-ID: <20181212052846.32370-6-okaya@kernel.org>
References: <20181212052846.32370-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212052846.32370-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, "open list:ACPI COMPONENT ARCHITECTURE ACPICA" <devel@acpica.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Now that we allow CONFIG_PCI to be unset, remove useless code from ACPICA
too.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/acpica/Makefile | 2 +-
 drivers/acpi/osl.c           | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index b14621da5413..59700433a96e 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -77,13 +77,13 @@ acpi-y +=		\
 	hwacpi.o	\
 	hwesleep.o	\
 	hwgpe.o		\
-	hwpci.o		\
 	hwregs.o	\
 	hwsleep.o	\
 	hwvalid.o	\
 	hwxface.o	\
 	hwxfsleep.o
 
+acpi-$(CONFIG_PCI) += hwpci.o
 acpi-$(ACPI_FUTURE_USAGE) += hwtimer.o
 
 acpi-y +=		\
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 7b1e58f93f37..8b8eb17df3f2 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1837,3 +1837,12 @@ acpi_status acpi_os_enter_sleep(u8 sleep_state,
 					       reg_a_value, reg_b_value);
 	return status;
 }
+
+#ifndef CONFIG_PCI
+acpi_status acpi_hw_derive_pci_id(struct acpi_pci_id *pci_id,
+		      acpi_handle root_pci_device, acpi_handle pci_region)
+{
+	return AE_SUPPORT;
+}
+#endif
+
-- 
2.19.0
