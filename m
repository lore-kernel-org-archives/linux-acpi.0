From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2] ACPI: add WARN_ON(acpi_disabled)
Date: Sat, 28 Jun 2008 02:06:36 -0400
Message-ID: <beda7788389c03279ae772f5423ff9baaa1b514c.1214633028.git.len.brown@intel.com>
References: <1214633197-3344-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms044pub.verizon.net ([206.46.252.44]:45162 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753755AbYF1GGl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Jun 2008 02:06:41 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms044.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K350037ZSZ3WJTD@vms044.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 28 Jun 2008 01:06:40 -0500 (CDT)
In-reply-to: <1214633197-3344-1-git-send-email-lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernrel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

We should not get to acpi_walk_namespace and
acpi_install_fixed_event_handler when acpi is disabled.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/events/evxface.c     |    2 ++
 drivers/acpi/namespace/nsxfeval.c |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/events/evxface.c b/drivers/acpi/events/evxface.c
index 94a6efe..fcf0fb9 100644
--- a/drivers/acpi/events/evxface.c
+++ b/drivers/acpi/events/evxface.c
@@ -114,6 +114,8 @@ acpi_install_fixed_event_handler(u32 event,
 
 	ACPI_FUNCTION_TRACE(acpi_install_fixed_event_handler);
 
+	WARN_ON(acpi_disabled);
+
 	/* Parameter validation */
 
 	if (event > ACPI_EVENT_MAX) {
diff --git a/drivers/acpi/namespace/nsxfeval.c b/drivers/acpi/namespace/nsxfeval.c
index a8d5491..934c8fc 100644
--- a/drivers/acpi/namespace/nsxfeval.c
+++ b/drivers/acpi/namespace/nsxfeval.c
@@ -391,6 +391,8 @@ acpi_walk_namespace(acpi_object_type type,
 
 	ACPI_FUNCTION_TRACE(acpi_walk_namespace);
 
+	WARN_ON(acpi_disabled);
+
 	/* Parameter validation */
 
 	if ((type > ACPI_TYPE_LOCAL_MAX) || (!max_depth) || (!user_function)) {
-- 
1.5.6.1.89.gd544

