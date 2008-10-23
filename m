From: Len Brown <lenb@kernel.org>
Subject: [PATCH 111/122] ACPICA: Fix possible memory leak, error exit path
Date: Thu, 23 Oct 2008 02:39:25 -0400
Message-ID: <cf058bd1c84df9921ecc517d8a8a413f4d6b5b45.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:37959 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441AbYJWGk1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:27 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600ESUIJ8Q4G7@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:21 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Fixed two possible memory leaks in the error exit paths of
acpi_ut_update_objerct_reference() and
acpi_ut_walk_package_tree()
These functions are similar in that they use a stack of state objects in
order to eliminate recursion. The stack must be fully deallocated
if an error occurs.

http://www.acpica.org/bugzilla/show_bug.cgi?id=383

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utdelete.c |    7 +++++++
 drivers/acpi/utilities/utmisc.c   |    9 +++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/utilities/utdelete.c b/drivers/acpi/utilities/utdelete.c
index 5c21975..d197c6b 100644
--- a/drivers/acpi/utilities/utdelete.c
+++ b/drivers/acpi/utilities/utdelete.c
@@ -585,6 +585,13 @@ acpi_ut_update_object_reference(union acpi_operand_object *object, u16 action)
 	ACPI_EXCEPTION((AE_INFO, status,
 			"Could not update object reference count"));
 
+	/* Free any stacked Update State objects */
+
+	while (state_list) {
+		state = acpi_ut_pop_generic_state(&state_list);
+		acpi_ut_delete_generic_state(state);
+	}
+
 	return_ACPI_STATUS(status);
 }
 
diff --git a/drivers/acpi/utilities/utmisc.c b/drivers/acpi/utilities/utmisc.c
index f34be67..9089a15 100644
--- a/drivers/acpi/utilities/utmisc.c
+++ b/drivers/acpi/utilities/utmisc.c
@@ -995,6 +995,15 @@ acpi_ut_walk_package_tree(union acpi_operand_object * source_object,
 							 state->pkg.
 							 this_target_obj, 0);
 			if (!state) {
+
+				/* Free any stacked Update State objects */
+
+				while (state_list) {
+					state =
+					    acpi_ut_pop_generic_state
+					    (&state_list);
+					acpi_ut_delete_generic_state(state);
+				}
 				return_ACPI_STATUS(AE_NO_MEMORY);
 			}
 		}
-- 
1.5.5.1

