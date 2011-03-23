From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/42] ACPICA: Clarify a couple of error messages
Date: Wed, 23 Mar 2011 02:42:32 -0400
Message-ID: <1b74dfb2f735454031584dc8162f8f27aa5265bf.1300862481.git.len.brown@intel.com>
References: <1300862575-10206-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:33781 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab1CWIHc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Mar 2011 04:07:32 -0400
Received: from localhost.localdomain ([unknown] [74.104.148.74])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LII00IQB3WFAQB4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 23 Mar 2011 03:07:31 -0500 (CDT)
In-reply-to: <1300862575-10206-1-git-send-email-lenb@kernel.org>
In-reply-to: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
References: <073b4964b3b75fd9e19bf3933b26d9c23591c9db.1300862481.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Clarify region error messages with ID= prefix for space id.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/exfldio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index 6c79c29..f915a7f 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -280,13 +280,13 @@ acpi_ex_access_region(union acpi_operand_object *obj_desc,
 	if (ACPI_FAILURE(status)) {
 		if (status == AE_NOT_IMPLEMENTED) {
 			ACPI_ERROR((AE_INFO,
-				    "Region %s(0x%X) not implemented",
+				    "Region %s (ID=%u) not implemented",
 				    acpi_ut_get_region_name(rgn_desc->region.
 							    space_id),
 				    rgn_desc->region.space_id));
 		} else if (status == AE_NOT_EXIST) {
 			ACPI_ERROR((AE_INFO,
-				    "Region %s(0x%X) has no handler",
+				    "Region %s (ID=%u) has no handler",
 				    acpi_ut_get_region_name(rgn_desc->region.
 							    space_id),
 				    rgn_desc->region.space_id));
-- 
1.7.4.1.343.ga91df

