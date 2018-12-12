From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v5 3/5] ACPI / OSL: Stub out acpi_os_write_pci_configuration when CONFIG_PCI is unset
Date: Wed, 12 Dec 2018 05:28:43 +0000
Message-ID: <20181212052846.32370-4-okaya@kernel.org>
References: <20181212052846.32370-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212052846.32370-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

Getting ready to allow PCI to be disabled with ACPI enabled. Stub out
acpi_os_write_pci_configuration function that depend on PCI.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/osl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3e82b50ba811..7b1e58f93f37 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -809,6 +809,7 @@ acpi_status
 acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 				u64 value, u32 width)
 {
+#ifdef CONFIG_PCI
 	int result, size;
 
 	switch (width) {
@@ -830,6 +831,9 @@ acpi_os_write_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 				reg, size, value);
 
 	return (result ? AE_ERROR : AE_OK);
+#else
+	return pr_warn_once("CONFIG_PCI is disabled\n") ? AE_SUPPORT : AE_OK;
+#endif
 }
 
 static void acpi_os_execute_deferred(struct work_struct *work)
-- 
2.19.0
