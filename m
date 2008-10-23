From: Len Brown <lenb@kernel.org>
Subject: [PATCH 116/122] ACPICA: Add support for zero-length buffer-to-string
 conversions
Date: Thu, 23 Oct 2008 02:39:30 -0400
Message-ID: <4ca846e9270f305ad19e61f6654664f31459f332.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:38944 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544AbYJWGoL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:44:11 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600KZWIPH3KY1@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:44:09 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Allow zero length strings during interpreter buffer-to-string
conversions. For example, during the ToDecimalString and
ToHexString operaters, as well as implicit conversions. Fiodor
Suietov.  ACPICA BZ 585.

http://www.acpica.org/bugzilla/show_bug.cgi?id=585

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/executer/exconvrt.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/executer/exconvrt.c b/drivers/acpi/executer/exconvrt.c
index 890378e..1d1f35a 100644
--- a/drivers/acpi/executer/exconvrt.c
+++ b/drivers/acpi/executer/exconvrt.c
@@ -512,9 +512,14 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 		/*
 		 * Create a new string object and string buffer
 		 * (-1 because of extra separator included in string_length from above)
+		 * Allow creation of zero-length strings from zero-length buffers.
 		 */
+		if (string_length) {
+			string_length--;
+		}
+
 		return_desc = acpi_ut_create_string_object((acpi_size)
-							   (string_length - 1));
+							   string_length);
 		if (!return_desc) {
 			return_ACPI_STATUS(AE_NO_MEMORY);
 		}
@@ -537,7 +542,9 @@ acpi_ex_convert_to_string(union acpi_operand_object * obj_desc,
 		 * Null terminate the string
 		 * (overwrites final comma/space from above)
 		 */
-		new_buf--;
+		if (obj_desc->buffer.length) {
+			new_buf--;
+		}
 		*new_buf = 0;
 		break;
 
-- 
1.5.5.1

