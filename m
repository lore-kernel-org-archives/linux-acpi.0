From: Len Brown <lenb@kernel.org>
Subject: [PATCH 02/60] ACPICA: Fix acpi_os_read_pci_configuration prototype
Date: Mon, 25 Oct 2010 02:20:10 -0400
Message-ID: <c5f0231ee6b0441e4c45f461f2b6652b10195494.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:33851 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176Ab0JYGVg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 02:21:36 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00AN41NKGQP0@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 01:21:27 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Prototype in acpiosxf.h had the output value pointer as a (u32 *).
Should be a (u64 *).

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exregion.c |    4 +---
 drivers/acpi/osl.c             |    8 +++++---
 include/acpi/acpiosxf.h        |    2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/exregion.c b/drivers/acpi/acpica/exregion.c
index 8819d2a..de17e10 100644
--- a/drivers/acpi/acpica/exregion.c
+++ b/drivers/acpi/acpica/exregion.c
@@ -353,7 +353,6 @@ acpi_ex_pci_config_space_handler(u32 function,
 	acpi_status status = AE_OK;
 	struct acpi_pci_id *pci_id;
 	u16 pci_register;
-	u32 value32;
 
 	ACPI_FUNCTION_TRACE(ex_pci_config_space_handler);
 
@@ -381,8 +380,7 @@ acpi_ex_pci_config_space_handler(u32 function,
 	case ACPI_READ:
 
 		status = acpi_os_read_pci_configuration(pci_id, pci_register,
-							&value32, bit_width);
-		*value = value32;
+							value, bit_width);
 		break;
 
 	case ACPI_WRITE:
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 65b25a3..a351291 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -547,9 +547,10 @@ acpi_os_write_memory(acpi_physical_address phys_addr, u32 value, u32 width)
 
 acpi_status
 acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
-			       u32 *value, u32 width)
+			       u64 *value, u32 width)
 {
 	int result, size;
+	u32 value32;
 
 	if (!value)
 		return AE_BAD_PARAMETER;
@@ -570,7 +571,8 @@ acpi_os_read_pci_configuration(struct acpi_pci_id * pci_id, u32 reg,
 
 	result = raw_pci_read(pci_id->segment, pci_id->bus,
 				PCI_DEVFN(pci_id->device, pci_id->function),
-				reg, size, value);
+				reg, size, &value32);
+	*value = value32;
 
 	return (result ? AE_ERROR : AE_OK);
 }
@@ -626,7 +628,7 @@ static void acpi_os_derive_pci_id_2(acpi_handle rhandle,	/* upper bound  */
 		status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL,
 					  &temp);
 		if (ACPI_SUCCESS(status)) {
-			u32 val;
+			u64 val;
 			pci_id->device = ACPI_HIWORD(ACPI_LODWORD(temp));
 			pci_id->function = ACPI_LOWORD(ACPI_LODWORD(temp));
 
diff --git a/include/acpi/acpiosxf.h b/include/acpi/acpiosxf.h
index 29bf945..5e22577 100644
--- a/include/acpi/acpiosxf.h
+++ b/include/acpi/acpiosxf.h
@@ -223,7 +223,7 @@ acpi_os_write_memory(acpi_physical_address address, u32 value, u32 width);
  */
 acpi_status
 acpi_os_read_pci_configuration(struct acpi_pci_id *pci_id,
-			       u32 reg, u32 *value, u32 width);
+			       u32 reg, u64 *value, u32 width);
 
 acpi_status
 acpi_os_write_pci_configuration(struct acpi_pci_id *pci_id,
-- 
1.7.3.2.90.gd4c43

