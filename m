From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH] ACPI: avoid section mismatch warning
Date: Tue, 07 Dec 2010 15:03:03 +0000
Message-ID: <4CFE5AB70200007800026720@vpn.id2.novell.com>
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
 drivers/acpi/osl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.37-rc5/drivers/acpi/osl.c
+++ 2.6.37-rc5-acpi-osl-sections/drivers/acpi/osl.c
@@ -1530,7 +1530,7 @@ acpi_status __init acpi_os_initialize(vo
 	return AE_OK;
 }
 
-acpi_status acpi_os_initialize1(void)
+acpi_status __init acpi_os_initialize1(void)
 {
 	kacpid_wq = create_workqueue("kacpid");
 	kacpi_notify_wq = create_workqueue("kacpi_notify");



