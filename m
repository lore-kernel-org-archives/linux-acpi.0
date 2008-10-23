From: Len Brown <lenb@kernel.org>
Subject: [PATCH 107/122] ACPICA: Fix possible memory leak in
 acpi_ns_get_external_pathname
Date: Thu, 23 Oct 2008 02:39:21 -0400
Message-ID: <393a75d6b7bae59221b2122634eb4cb905e84208.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:55856 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755471AbYJWGki (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:38 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600FVLIJ79LY3@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:20 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

Fixes a memory leak in the error exit path.

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/namespace/nsnames.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/namespace/nsnames.c b/drivers/acpi/namespace/nsnames.c
index bd57738..9c587bd 100644
--- a/drivers/acpi/namespace/nsnames.c
+++ b/drivers/acpi/namespace/nsnames.c
@@ -142,7 +142,7 @@ char *acpi_ns_get_external_pathname(struct acpi_namespace_node *node)
 
 	size = acpi_ns_get_pathname_length(node);
 	if (!size) {
-		return (NULL);
+		return_PTR(NULL);
 	}
 
 	/* Allocate a buffer to be returned to caller */
@@ -157,7 +157,8 @@ char *acpi_ns_get_external_pathname(struct acpi_namespace_node *node)
 
 	status = acpi_ns_build_external_path(node, size, name_buffer);
 	if (ACPI_FAILURE(status)) {
-		return (NULL);
+		ACPI_FREE(name_buffer);
+		return_PTR(NULL);
 	}
 
 	return_PTR(name_buffer);
-- 
1.5.5.1

