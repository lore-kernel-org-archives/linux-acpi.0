From: Len Brown <lenb@kernel.org>
Subject: [PATCH 093/171] flush kacpi_notify_wq before removing notify handler
Date: Tue, 29 Apr 2008 04:44:13 -0400
Message-ID: <2f67a0695dc389247c05041b05d2a2b06fc102a3.1209457069.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:1417 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760632AbYD2IpJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Apr 2008 04:45:09 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>

From: Zhang Rui <rui.zhang@intel.com>

Flush kacpi_notify_wq before notify handler is removed,
this can fix a bug which the deferred notify handler is executed
after the notify_handler has already been removed.
http://bugzilla.kernel.org/show_bug.cgi?id=9772

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index a498a6c..235a138 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -742,6 +742,7 @@ EXPORT_SYMBOL(acpi_os_execute);
 void acpi_os_wait_events_complete(void *context)
 {
 	flush_workqueue(kacpid_wq);
+	flush_workqueue(kacpi_notify_wq);
 }
 
 EXPORT_SYMBOL(acpi_os_wait_events_complete);
-- 
1.5.5.1.99.gf0ec4

