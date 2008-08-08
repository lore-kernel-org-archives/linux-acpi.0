From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH] acpi: replace AE_BAD_ADDRESS exception code with AE_ERROR
Date: Fri, 08 Aug 2008 11:57:11 +0800
Message-ID: <1218167831.4978.11.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11006 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750695AbYHHD4r (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 7 Aug 2008 23:56:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ak@linux.intel.com
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>

Hi, Andi

The AE_BAD_ADDRESS exception code is now unused in ACPICA.
For linux, it's only used at wmi.c and acer-wmi.c.
I checked both wmi.c and acer-wmi.c, the AE_BAD_ADDRESS exception code
has no special meaning. The parent functions just call AE_SUCCESS() or
AE_FAILURE() to check the return status.
So it's safe to replace AE_BAD_ADDRESS with AE_ERROR.

Signed-off-by Lin Ming <ming.m.lin@intel.com>
---
 drivers/acpi/wmi.c      |   10 +++++-----
 drivers/misc/acer-wmi.c |   10 +++++-----
 include/acpi/acexcep.h  |   14 ++++++--------
 3 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
index c33b1c6..0621768 100644
--- a/drivers/acpi/wmi.c
+++ b/drivers/acpi/wmi.c
@@ -242,7 +242,7 @@ u32 method_id, const struct acpi_buffer *in, struct
acpi_buffer *out)
 	char method[4] = "WM";
 
 	if (!find_guid(guid_string, &wblock))
-		return AE_BAD_ADDRESS;
+		return AE_ERROR;
 
 	block = &wblock->gblock;
 	handle = wblock->handle;
@@ -304,7 +304,7 @@ struct acpi_buffer *out)
 		return AE_BAD_PARAMETER;
 
 	if (!find_guid(guid_string, &wblock))
-		return AE_BAD_ADDRESS;
+		return AE_ERROR;
 
 	block = &wblock->gblock;
 	handle = wblock->handle;
@@ -314,7 +314,7 @@ struct acpi_buffer *out)
 
 	/* Check GUID is a data block */
 	if (block->flags & (ACPI_WMI_EVENT | ACPI_WMI_METHOD))
-		return AE_BAD_ADDRESS;
+		return AE_ERROR;
 
 	input.count = 1;
 	input.pointer = wq_params;
@@ -385,7 +385,7 @@ const struct acpi_buffer *in)
 		return AE_BAD_DATA;
 
 	if (!find_guid(guid_string, &wblock))
-		return AE_BAD_ADDRESS;
+		return AE_ERROR;
 
 	block = &wblock->gblock;
 	handle = wblock->handle;
@@ -395,7 +395,7 @@ const struct acpi_buffer *in)
 
 	/* Check GUID is a data block */
 	if (block->flags & (ACPI_WMI_EVENT | ACPI_WMI_METHOD))
-		return AE_BAD_ADDRESS;
+		return AE_ERROR;
 
 	input.count = 2;
 	input.pointer = params;
diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index e7a3fe5..fc502de 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -473,7 +473,7 @@ struct wmi_interface *iface)
 		}
 		break;
 	default:
-		return AE_BAD_ADDRESS;
+		return AE_ERROR;
 	}
 	return AE_OK;
 }
@@ -511,7 +511,7 @@ static acpi_status AMW0_set_u32(u32 value, u32 cap,
struct wmi_interface *iface)
 			break;
 		}
 	default:
-		return AE_BAD_ADDRESS;
+		return AE_ERROR;
 	}
 
 	/* Actually do the set */
@@ -686,7 +686,7 @@ struct wmi_interface *iface)
 			return 0;
 		}
 	default:
-		return AE_BAD_ADDRESS;
+		return AE_ERROR;
 	}
 	status = WMI_execute_u32(method_id, 0, &result);
 
@@ -732,7 +732,7 @@ static acpi_status WMID_set_u32(u32 value, u32 cap,
struct wmi_interface *iface)
 		}
 		break;
 	default:
-		return AE_BAD_ADDRESS;
+		return AE_ERROR;
 	}
 	return WMI_execute_u32(method_id, (u32)value, NULL);
 }
@@ -782,7 +782,7 @@ static struct wmi_interface wmid_interface = {
 
 static acpi_status get_u32(u32 *value, u32 cap)
 {
-	acpi_status status = AE_BAD_ADDRESS;
+	acpi_status status = AE_ERROR;
 
 	switch (interface->type) {
 	case ACER_AMW0:
diff --git a/include/acpi/acexcep.h b/include/acpi/acexcep.h
index e5a890f..c73371c 100644
--- a/include/acpi/acexcep.h
+++ b/include/acpi/acexcep.h
@@ -103,14 +103,13 @@
 #define AE_BAD_CHARACTER                (acpi_status) (0x0002 |
AE_CODE_PROGRAMMER)
 #define AE_BAD_PATHNAME                 (acpi_status) (0x0003 |
AE_CODE_PROGRAMMER)
 #define AE_BAD_DATA                     (acpi_status) (0x0004 |
AE_CODE_PROGRAMMER)
-#define AE_BAD_ADDRESS                  (acpi_status) (0x0005 |
AE_CODE_PROGRAMMER)
-#define AE_ALIGNMENT                    (acpi_status) (0x0006 |
AE_CODE_PROGRAMMER)
-#define AE_BAD_HEX_CONSTANT             (acpi_status) (0x0007 |
AE_CODE_PROGRAMMER)
-#define AE_BAD_OCTAL_CONSTANT           (acpi_status) (0x0008 |
AE_CODE_PROGRAMMER)
-#define AE_BAD_DECIMAL_CONSTANT         (acpi_status) (0x0009 |
AE_CODE_PROGRAMMER)
-#define AE_MISSING_ARGUMENTS		(acpi_status) (0x000A |
AE_CODE_PROGRAMMER)
+#define AE_ALIGNMENT                    (acpi_status) (0x0005 |
AE_CODE_PROGRAMMER)
+#define AE_BAD_HEX_CONSTANT             (acpi_status) (0x0006 |
AE_CODE_PROGRAMMER)
+#define AE_BAD_OCTAL_CONSTANT           (acpi_status) (0x0007 |
AE_CODE_PROGRAMMER)
+#define AE_BAD_DECIMAL_CONSTANT         (acpi_status) (0x0008 |
AE_CODE_PROGRAMMER)
+#define AE_MISSING_ARGUMENTS		(acpi_status) (0x0009 |
AE_CODE_PROGRAMMER)
 
-#define AE_CODE_PGM_MAX 		0x000A
+#define AE_CODE_PGM_MAX 		0x0009
 
 /*
  * Acpi table exceptions
@@ -231,7 +230,6 @@ char const *acpi_gbl_exception_names_pgm[] = {
 	"AE_BAD_CHARACTER",
 	"AE_BAD_PATHNAME",
 	"AE_BAD_DATA",
-	"AE_BAD_ADDRESS",
 	"AE_ALIGNMENT",
 	"AE_BAD_HEX_CONSTANT",
 	"AE_BAD_OCTAL_CONSTANT",

