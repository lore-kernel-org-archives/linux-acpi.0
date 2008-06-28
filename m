From: Len Brown <lenb@kernel.org>
Subject: [PATCH 20/84] acer-wmi: Disable device autodetection on Fujitsu
 Siemens Amilo Li2732
Date: Sat, 28 Jun 2008 01:43:24 -0400
Message-ID: <8cc6ff4b840843c13da2c0d1ecc40d75df007053.1214631213.git.len.brown@intel.com>
References: <1214631868-1715-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:50450 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbYF1Fo7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 01:44:59 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K3500H61RYUX304@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 00:44:55 -0500 (CDT)
In-reply-to: <1214631868-1715-1-git-send-email-lenb@kernel.org>
In-reply-to: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
References: <087803d18fb8259cb844c075a35fb27c2d80792e.1214631213.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <len.brown@intel.com>

From: Carlos Corbacho <carlos@strangeworlds.co.uk>

The AMW0 (V1) device detection method doesn't work properly on this laptop,
so disable it, and for other laptops that may have this problem, by
switching on a strange GUID.

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/acer-wmi.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index 5b7c5fc..dd0b8d8 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -88,6 +88,7 @@ struct acer_quirks {
  * Acer ACPI method GUIDs
  */
 #define AMW0_GUID1		"67C3371D-95A3-4C37-BB61-DD47B491DAAB"
+#define AMW0_GUID2		"431F16ED-0C2B-444C-B267-27DEB140CF9C"
 #define WMID_GUID1		"6AF4F258-B401-42fd-BE91-3D4AC2D7C0D3"
 #define WMID_GUID2		"95764E09-FB56-4e83-B31A-37761F60994A"
 
@@ -548,6 +549,15 @@ static acpi_status AMW0_set_capabilities(void)
 	struct acpi_buffer out = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *obj;
 
+	/*
+	 * On laptops with this strange GUID (non Acer), normal probing doesn't
+	 * work.
+	 */
+	if (wmi_has_guid(AMW0_GUID2)) {
+		interface->capability |= ACER_CAP_WIRELESS;
+		return AE_OK;
+	}
+
 	args.eax = ACER_AMW0_WRITE;
 	args.ecx = args.edx = 0;
 
-- 
1.5.6.1.89.gd544

