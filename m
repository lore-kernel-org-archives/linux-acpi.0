From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/4] ACPI: add WARN_ON(acpi_disabled)
Date: Tue, 24 Jun 2008 23:07:43 -0400
Message-ID: <9693ff3767d06ac894642a857370a5ea9a299fdf.1214362900.git.len.brown@intel.com>
References: <20080620135639.GA5073@damson.getinternet.no>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:61809 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753360AbYFYDH6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jun 2008 23:07:58 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K30001YO0P07RM2@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 24 Jun 2008 22:07:49 -0500 (CDT)
In-reply-to: <20080620135639.GA5073@damson.getinternet.no>
In-reply-to: <27587d0c4b2f6aecf5c54d943c1dc8deebcfcc1a.1214362900.git.len.brown@intel.com>
References: <27587d0c4b2f6aecf5c54d943c1dc8deebcfcc1a.1214362900.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernrel@vger.kernrel.org
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
1.5.6.56.g29b0d

