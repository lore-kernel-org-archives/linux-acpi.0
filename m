From: Len Brown <lenb@kernel.org>
Subject: [PATCH 31/94] ACPICA: Fix to allow aliases within ASL namepaths
Date: Fri, 09 Jan 2009 04:26:33 -0500
Message-ID: <5572a9859fa55216597b8226717691956d3e53e3.1231492609.git.len.brown@intel.com>
References: <1231493256-11678-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:56420 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbZAIJ2T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 04:28:19 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KD700EGP6AQOO13@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 03:28:03 -0600 (CST)
In-reply-to: <1231493256-11678-1-git-send-email-lenb@kernel.org>
In-reply-to: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
References: <c5279dee26c0e8d7c4200993bfc4b540d2469598.1231492606.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixes a problem where the use of an alias within a namepath
would result in a not found error or cause the compiler to fault.
Also now allows forward references from the Alias operator itself.
ACPICA BZ 738.

http://www.acpica.org/bugzilla/show_bug.cgi?id=738

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nsaccess.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/namespace/nsaccess.c b/drivers/acpi/namespace/nsaccess.c
index 29c7c27..35b0e46 100644
--- a/drivers/acpi/namespace/nsaccess.c
+++ b/drivers/acpi/namespace/nsaccess.c
@@ -588,6 +588,10 @@ acpi_ns_lookup(union acpi_generic_state *scope_info,
 			 * segments).
 			 */
 			if (this_node->type == ACPI_TYPE_LOCAL_ALIAS) {
+				if (!this_node->object) {
+					return_ACPI_STATUS(AE_NOT_EXIST);
+				}
+
 				if (acpi_ns_opens_scope
 				    (((struct acpi_namespace_node *)this_node->
 				      object)->type)) {
-- 
1.5.6.6

