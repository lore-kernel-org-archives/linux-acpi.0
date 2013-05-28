From: <jeff.wu@amd.com>
Subject: [PATCH v2] ACPI:add _STA evaluating at do_acpi_find_child()
Date: Tue, 28 May 2013 11:22:17 +0800
Message-ID: <1369711337-2410-1-git-send-email-jeff.wu@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-db8lp0184.outbound.messaging.microsoft.com ([213.199.154.184]:53898
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758735Ab3E1DX2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 May 2013 23:23:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, lenb@kernel.org, lantianyu1986@gmail.com, linux-acpi@vger.kernel.org
Cc: zlinuxkernel@gmail.com, shane.huang@amd.com, aaron.lwe@gmail.com, lekensteyn@gmail.com, dagobertstaler@gmail.com

From: Jeff Wu <zlinuxkernel@gmail.com>

v2:
1).If it's only one matching device, whether the deivce status is enabled or disabled,
   do_acpi_find_child() return its' handle
2).If it's more than one matching devices, do_acpi_find_child() return the first 
   enabled device handle
The idea mail thread:
http://wwww.spinics.net/lists/linux-acpi/msg43481.html

v1:
Once do_acpi_find_child() found the first matching handle, it makes the acpi_get_child()
loop stop and return the matching handle. But, at some of the platforms, a "_ADR" is
with the multiple devices, and if one is enabled, the others will be disabled.
Just like a case:
Address : 0x1FFFF ; handle : SB_PCI0.SATA.DEV0
Address : 0x1FFFF ; handle : SB_PCI0.SATA.DEV1
Address : 0x1FFFF ; handle : SB_PCI0.SATA.DEV2

If DEV0 and DEV1 are disabled and DEV2 is enabled, the target is to get DEV2 handle, but
actually it always return the first disabled device DEV0 handle. So add a _STA evaluating
at do_acpi_find_child() to check the device status. If the object exists, but it is disabled,
acpi_get_child() will continue looping to get the correct handle that the object exists and
is enabled.
 

Signed-off-by: Jeff Wu <zlinuxkernel@gmail.com>
---
 drivers/acpi/glue.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 40a84cc..51ca764 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -81,13 +81,15 @@ static struct acpi_bus_type *acpi_get_bus_type(struct device *dev)
 static acpi_status do_acpi_find_child(acpi_handle handle, u32 lvl_not_used,
 				      void *addr_p, void **ret_p)
 {
-	unsigned long long addr;
+	unsigned long long addr, sta;
 	acpi_status status;
 
 	status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, &addr);
 	if (ACPI_SUCCESS(status) && addr == *((u64 *)addr_p)) {
 		*ret_p = handle;
-		return AE_CTRL_TERMINATE;
+		status = acpi_bus_get_status_handle(handle, &sta);
+		if (ACPI_SUCCESS(status) && (sta & ACPI_STA_DEVICE_ENABLED))
+			return AE_CTRL_TERMINATE;
 	}
 	return AE_OK;
 }
-- 
1.8.1.2


