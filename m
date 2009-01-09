From: Len Brown <lenb@kernel.org>
Subject: [PATCH 32/94] ACPICA: Allow multiple backslash prefix in namepaths
Date: Fri, 09 Jan 2009 04:26:34 -0500
Message-ID: <d037c5fd7367548191eab2b376a1d08c4ffaf7ff.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:51580 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbZAIJ2F (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:05 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD700A3R6AQW9K9@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:03 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

In a fully qualified namepath, allow multiple backslash prefixes.
This can happen because of the use of a double-backslash in strings
(since backslash is the escape character) causing confusion.
ACPICA BZ 739 Lin Ming.

http://www.acpica.org/bugzilla/show_bug.cgi?id=739

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nsutils.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/namespace/nsutils.c b/drivers/acpi/namespace/nsutils.c
index b0817e1..337fb04 100644
--- a/drivers/acpi/namespace/nsutils.c
+++ b/drivers/acpi/namespace/nsutils.c
@@ -314,9 +314,15 @@ void acpi_ns_get_internal_name_length(struct acpi_namestring_info *info)
 	 *
 	 * strlen() + 1 covers the first name_seg, which has no path separator
 	 */
-	if (acpi_ns_valid_root_prefix(next_external_char[0])) {
+	if (acpi_ns_valid_root_prefix(*next_external_char)) {
 		info->fully_qualified = TRUE;
 		next_external_char++;
+
+		/* Skip redundant root_prefix, like \\_SB.PCI0.SBRG.EC0 */
+
+		while (acpi_ns_valid_root_prefix(*next_external_char)) {
+			next_external_char++;
+		}
 	} else {
 		/*
 		 * Handle Carat prefixes
-- 
1.5.6.6

