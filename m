From: Len Brown <lenb@kernel.org>
Subject: [PATCH 03/18] ACPICA: Add error msg for unsupported I/O requests (not
 8/16/32 bit length)
Date: Sun, 11 Dec 2011 12:45:34 -0500
Message-ID: <fcaba095efdbd278c4cfa037119dcf98501340c2.1323625426.git.len.brown@intel.com>
References: <1323625549-10775-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:51888 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988Ab1LKRqN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 11 Dec 2011 12:46:13 -0500
Received: from localhost.localdomain ([unknown] [74.104.158.190])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LW1005VWW0KVH40@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 11 Dec 2011 11:46:03 -0600 (CST)
In-reply-to: <1323625549-10775-1-git-send-email-lenb@kernel.org>
In-reply-to: <d40ba5ad56e98f9ff96c110a0fd4e8382b82229d.1323625426.git.len.brown@intel.com>
References: <d40ba5ad56e98f9ff96c110a0fd4e8382b82229d.1323625426.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Found during ACPICA debugging.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/hwvalid.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
index 5f16058..f8fbea9 100644
--- a/drivers/acpi/acpica/hwvalid.c
+++ b/drivers/acpi/acpica/hwvalid.c
@@ -134,6 +134,8 @@ acpi_hw_validate_io_request(acpi_io_address address, u32 bit_width)
 	/* Supported widths are 8/16/32 */
 
 	if ((bit_width != 8) && (bit_width != 16) && (bit_width != 32)) {
+		ACPI_ERROR((AE_INFO,
+			    "Bad BitWidth parameter: %8.8X", bit_width));
 		return AE_BAD_PARAMETER;
 	}
 
-- 
1.7.7.rc0.72.g4b5ea

