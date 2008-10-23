From: Len Brown <lenb@kernel.org>
Subject: [PATCH 069/122] ACPI: replace AE_BAD_ADDRESS exception code with
 AE_ERROR
Date: Thu, 23 Oct 2008 02:38:43 -0400
Message-ID: <08237974af22a97da59869979ef1a515524d5cc3.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:51267 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755469AbYJWGki (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:38 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K96006BWIIV39R1@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:08 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Andi Kleen <ak@linux.intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

The AE_BAD_ADDRESS exception code is now unused in ACPICA.
For linux, it's only used at wmi.c and acer-wmi.c.
I checked both wmi.c and acer-wmi.c, the AE_BAD_ADDRESS exception code
has no special meaning. The parent functions just call AE_SUCCESS() or
AE_FAILURE() to check the return status.
So it's safe to replace AE_BAD_ADDRESS with AE_ERROR.

Signed-off-by Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/wmi.c      |   10 +++++-----
 drivers/misc/acer-wmi.c |   10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/wmi.c b/drivers/acpi/wmi.c
index cfe2c83..5b94be3 100644
--- a/drivers/acpi/wmi.c
+++ b/drivers/acpi/wmi.c
@@ -242,7 +242,7 @@ u32 method_id, const struct acpi_buffer *in, struct acpi_buffer *out)
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
index d8b0d32..a67aef5 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -476,7 +476,7 @@ struct wmi_interface *iface)
 		}
 		break;
 	default:
-		return AE_BAD_ADDRESS;
+		return AE_ERROR;
 	}
 	return AE_OK;
 }
@@ -514,7 +514,7 @@ static acpi_status AMW0_set_u32(u32 value, u32 cap, struct wmi_interface *iface)
 			break;
 		}
 	default:
-		return AE_BAD_ADDRESS;
+		return AE_ERROR;
 	}
 
 	/* Actually do the set */
@@ -689,7 +689,7 @@ struct wmi_interface *iface)
 			return 0;
 		}
 	default:
-		return AE_BAD_ADDRESS;
+		return AE_ERROR;
 	}
 	status = WMI_execute_u32(method_id, 0, &result);
 
@@ -735,7 +735,7 @@ static acpi_status WMID_set_u32(u32 value, u32 cap, struct wmi_interface *iface)
 		}
 		break;
 	default:
-		return AE_BAD_ADDRESS;
+		return AE_ERROR;
 	}
 	return WMI_execute_u32(method_id, (u32)value, NULL);
 }
@@ -785,7 +785,7 @@ static struct wmi_interface wmid_interface = {
 
 static acpi_status get_u32(u32 *value, u32 cap)
 {
-	acpi_status status = AE_BAD_ADDRESS;
+	acpi_status status = AE_ERROR;
 
 	switch (interface->type) {
 	case ACER_AMW0:
-- 
1.5.5.1

