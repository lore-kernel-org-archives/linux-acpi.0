From: Sinan Kaya <okaya@codeaurora.org>
Subject: [PATCH V2] ACPI / IPMI: allow ACPI_IPMI with IPMI_SSIF
Date: Thu, 23 Mar 2017 12:03:15 -0400
Message-ID: <1490284995-28556-1-git-send-email-okaya@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, timur@codeaurora.org, sulrich@codeaurora.org
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sinan Kaya <okaya@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

ACPI_IPMI driver currently depends on IPMI System Interface (IPMI_SI)
driver to be enabled. IPMI_SI driver only handles KCS, SMIC and BT BMC
interfaces.

IPMI_SSIF is an alternative BMC communication method. It allows BMC to
be accessed over an I2C bus instead of a standard interface.

Enabling ACPI_IPMI over IPMI_SSIF with this change.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 83e5f7e..dc22c8a 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -256,7 +256,7 @@ config ACPI_PROCESSOR
 
 config ACPI_IPMI
 	tristate "IPMI"
-	depends on IPMI_SI
+	depends on IPMI_SI || IPMI_SSIF
 	default n
 	help
 	  This driver enables the ACPI to access the BMC controller. And it
-- 
1.9.1
