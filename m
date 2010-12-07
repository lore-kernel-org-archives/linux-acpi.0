From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH] ACPI/PNP: avoid section mismatch warning
Date: Tue, 07 Dec 2010 15:05:49 +0000
Message-ID: <4CFE5B5D0200007800026730@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Signed-off-by: Jan Beulich <jbeulich@novell.com>

---
 drivers/pnp/pnpacpi/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.37-rc5/drivers/pnp/pnpacpi/core.c
+++ 2.6.37-rc5-pnpacpi-sections/drivers/pnp/pnpacpi/core.c
@@ -180,7 +180,7 @@ struct pnp_protocol pnpacpi_protocol = {
 };
 EXPORT_SYMBOL(pnpacpi_protocol);
 
-static char *pnpacpi_get_id(struct acpi_device *device)
+static char *__init pnpacpi_get_id(struct acpi_device *device)
 {
 	struct acpi_hardware_id *id;
 



