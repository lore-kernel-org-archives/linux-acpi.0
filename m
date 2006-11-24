From: Len Brown <len.brown@intel.com>
Subject: [PATCH 55/65] ACPICA: Abort downward walk on temporary node detection.
Date: Fri, 24 Nov 2006 02:19:05 -0500
Message-ID: <11643528161204-git-send-email-len.brown@intel.com>
References: <1164352755500-git-send-email-len.brown@intel.com> <11643527561399-git-send-email-len.brown@intel.com> <11643527572123-git-send-email-len.brown@intel.com> <11643527582206-git-send-email-len.brown@intel.com> <11643527591227-git-send-email-len.brown@intel.com> <11643527604195-git-send-email-len.brown@intel.com> <1164352761941-git-send-email-len.brown@intel.com> <1164352762703-git-send-email-len.brown@intel.com> <11643527631929-git-send-email-len.brown@intel.com> <11643527633954-git-send-email-len.brown@intel.com> <11643527641142-git-send-email-len.brown@intel.com> <11643527654192-git-send-email-len.brown@intel.com> <11643527703526-git-send-email-len.brown@intel.com> <11643527731111-git-send-email-len.brown@intel.com> <11643527743390-git-send-email-len.brown@intel.com> <11643527752251-git-send-email-len.brown@intel.com> <1164352776767-git-send-email-len.brown@intel.com> <1164352
 7782767-git-send-email-len.brown@intel.com> <11643527804057-git-send-email-len.brown@intel.com> <11643527812144-git-send-email-len.brown@intel.com> <11643527821346-git-send-email-len.brown@intel.com> <11643527832869-git-send-email-len.brown@intel.com> <11643527843465-git-send-email-len.brown@intel.com> <11643527853403-git-send-email-len.brown@intel.com> <1164352786236-git-send-email-len.brown@intel.com> <11643527871558-git-send-email-len.brown@intel.com> <1164352787694-git-send-email-len.brown@intel.com> <1164352788512-git-send-email-len.brown@intel.com> <11643527891947-git-send-email-len.brown@intel.com> <1164352791852-git-send-email-len.brown@intel.com> <1164352792447-git-send-email-len.brown@intel.com> <11643527931850-git-send-email-len.brown@intel.com> <11643527943385-git-send-email-len.brown@intel.com> <11643527951196-git-send-email-len.brown@intel.com> <1164352796746-git-send-ema
 il-len.brown@intel.com> <11643527973892-git-send-email-len.brown@intel.com> <11643527982269-git-send-email-len.brown@intel.com> <11643527993578-git-send-email-len.brown@intel.com> <11643527992802-git-send-email-len.brown@intel.com> <11643528001078-git-send-email-len.brown@intel.com> <11643528013509-git-send-email-len.brown@intel.com> <11643528022585-git-send-email-len.brown@intel.com> <11643528032291-git-send-email-len.brown@intel.com> <11643528042439-git-send-email-len.brown@intel.com> <11643528053298-git-send-email-len.brown@intel.com> <11643528062723-git-send-email-len.brown@intel.com> <1164352807227-git-send-email-len.brown@intel.com> <11643528083991-git-send-email-len.brown@intel.com> <1164352808199-git-send-email-len.brown@intel.com> <11643528091601-git-send-email-len.brown@intel.com> <11643528111088-git-send-email-len.brown@intel.com> <11643528124177-git-send-email-len.brown@int
 el.com> <11643528134106-git-send-email-len.brown@intel.com> <11643528141248-git-send-email-len.brown@intel.com> <11643528153363-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:11149 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S934500AbWKXHQS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 24 Nov 2006 02:16:18 -0500
In-Reply-To: <11643528153363-git-send-email-len.brown@intel.com>
Message-Id: <8bb9f81e2a6196b3fd4f1c72edb3ca1e5d4d0d80.1164352294.git.len.brown@intel.com>
In-Reply-To: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
References: <410c2f0190f74c35505beda6ff3f2da7819f8bac.1164352285.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Robert Moore <robert.moore@intel.com>, Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>, Len Brown <len.brown@intel.com>

From: Robert Moore <robert.moore@intel.com>

Enhancement to code that ignores temporary  namespace nodes

Signed-off-by: Alexey Starikovskiy <alexey.y.starikovskiy@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nswalk.c |   26 +++++++++++++++-----------
 1 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/namespace/nswalk.c b/drivers/acpi/namespace/nswalk.c
index c6619d8..bccf27d 100644
--- a/drivers/acpi/namespace/nswalk.c
+++ b/drivers/acpi/namespace/nswalk.c
@@ -194,24 +194,28 @@ acpi_ns_walk_namespace(acpi_object_type
 					  child_node);
 		if (child_node) {
 
-			/* Found node, Get the type if we are not searching for ANY */
+			/* Found next child, get the type if we are not searching for ANY */
 
 			if (type != ACPI_TYPE_ANY) {
 				child_type = child_node->type;
 			}
 
 			/*
-			 * 1) Type must match
-			 * 2) Permanent namespace nodes are OK
-			 * 3) Ignore temporary nodes unless told otherwise. Typically,
-			 *    the temporary nodes can cause a race condition where they can
-			 *    be deleted during the execution of the user function. Only the
-			 *    debugger namespace dump will examine the temporary nodes.
+			 * Ignore all temporary namespace nodes (created during control
+			 * method execution) unless told otherwise. These temporary nodes
+			 * can cause a race condition because they can be deleted during the
+			 * execution of the user function (if the namespace is unlocked before
+			 * invocation of the user function.) Only the debugger namespace dump
+			 * will examine the temporary nodes.
 			 */
-			if ((child_type == type) &&
-			    (!(child_node->flags & ANOBJ_TEMPORARY) ||
-			     (child_node->flags & ANOBJ_TEMPORARY)
-			     && (flags & ACPI_NS_WALK_TEMP_NODES))) {
+			if ((child_node->flags & ANOBJ_TEMPORARY) &&
+			    !(flags & ACPI_NS_WALK_TEMP_NODES)) {
+				status = AE_CTRL_DEPTH;
+			}
+
+			/* Type must match requested type */
+
+			else if (child_type == type) {
 				/*
 				 * Found a matching node, invoke the user callback function.
 				 * Unlock the namespace if flag is set.
-- 
1.4.4.1
