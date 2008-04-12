From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/73] ACPICA: Removed extraneous code
Date: Sat, 12 Apr 2008 00:24:51 -0400
Message-ID: <64751fd5899d15404a7edf11ade56d63b229a915.1207973799.git.len.brown@intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:54694 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752260AbYDLE15 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Apr 2008 00:27:57 -0400
In-Reply-To: <1207974356-30687-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
References: <0b76302280f017f219f191ea2c1439ff66cc4b2a.1207973799.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/dispatcher/dsmethod.c |    7 -------
 drivers/acpi/namespace/nswalk.c    |    4 +---
 2 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/dispatcher/dsmethod.c b/drivers/acpi/dispatcher/dsmethod.c
index c50c0cd..3db651c 100644
--- a/drivers/acpi/dispatcher/dsmethod.c
+++ b/drivers/acpi/dispatcher/dsmethod.c
@@ -535,7 +535,6 @@ void
 acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 				 struct acpi_walk_state *walk_state)
 {
-	struct acpi_namespace_node *method_node;
 	acpi_status status;
 
 	ACPI_FUNCTION_TRACE_PTR(ds_terminate_control_method, walk_state);
@@ -575,12 +574,6 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 
 	if (walk_state) {
 		/*
-		 * Delete any objects created by this method during execution.
-		 * The method Node is stored in the walk state
-		 */
-		method_node = walk_state->method_node;
-
-		/*
 		 * Delete any namespace objects created anywhere within
 		 * the namespace by the execution of this method
 		 */
diff --git a/drivers/acpi/namespace/nswalk.c b/drivers/acpi/namespace/nswalk.c
index 280b835..c7b5409 100644
--- a/drivers/acpi/namespace/nswalk.c
+++ b/drivers/acpi/namespace/nswalk.c
@@ -77,9 +77,7 @@ struct acpi_namespace_node *acpi_ns_get_next_node(acpi_object_type type, struct
 
 		/* It's really the parent's _scope_ that we want */
 
-		if (parent_node->child) {
-			next_node = parent_node->child;
-		}
+		next_node = parent_node->child;
 	}
 
 	else {
-- 
1.5.5.29.g7134

