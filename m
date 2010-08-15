From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/20] ACPI: Add the check of ADR flag in course of finding
 ACPI handle for PCI device
Date: Sun, 15 Aug 2010 01:23:10 -0400
Message-ID: <108029ff84fcad8f9199d2d2e2583ae2747d45a4.1281849737.git.len.brown@intel.com>
References: <1281849804-7455-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:39439 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab0HOFXc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Aug 2010 01:23:32 -0400
Received: from localhost.localdomain ([unknown] [64.140.212.33])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L7600E35HN6VLC3@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Aug 2010 00:23:32 -0500 (CDT)
In-reply-to: <1281849804-7455-1-git-send-email-lenb@kernel.org>
In-reply-to: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
References: <e96c4b081df0991a57b244f68c3955a9ea00bd0a.1281849737.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

The _ADR object is used to provide OSPM with the address of one device on its
parent bus. In course of finding ACPI handle for the corresponding PCI device,
we will firstly evaluate the _ADR object and then compare the two addresses to
see whether it is the target ACPI device. But for one PCI device(0000:00:00.0)
under the PCI root bridge, the corresponding address will be constructed as
zero.In such case maybe the ACPI device without _ADR object will be misdetected
and then be used to create the relationship between PCI device and ACPI device.

https://bugzilla.kernel.org/show_bug.cgi?id=16422

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/glue.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
index 4af6301..78b0164 100644
--- a/drivers/acpi/glue.c
+++ b/drivers/acpi/glue.c
@@ -100,7 +100,8 @@ do_acpi_find_child(acpi_handle handle, u32 lvl, void *context, void **rv)
 
 	status = acpi_get_object_info(handle, &info);
 	if (ACPI_SUCCESS(status)) {
-		if (info->address == find->address)
+		if ((info->address == find->address)
+			&& (info->valid & ACPI_VALID_ADR))
 			find->handle = handle;
 		kfree(info);
 	}
-- 
1.7.2.1.95.g3d045

