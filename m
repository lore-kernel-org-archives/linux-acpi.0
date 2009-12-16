From: Len Brown <lenb@kernel.org>
Subject: [PATCH 094/103] ACPI: Use the return result of ACPI lid notifier chain
 correctly
Date: Wed, 16 Dec 2009 03:36:45 -0500
Message-ID: <13c199c0d0cf78b27592991129fb8cbcfc5164de.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173013pub.verizon.net ([206.46.173.13]:62407 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761892AbZLPJGP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 04:06:15 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ0055NMLOFSID@vms173013.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 03:05:58 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

On some laptops it will return NOTIFY_OK(non-zero) when calling the ACPI LID
notifier. Then it is used as the result of ACPI LID resume function, which
will complain the following warning message in course of suspend/resume:

     >PM: Device PNP0C0D:00 failed to resume: error 1

This patch is to eliminate the above warning message.

http://bugzilla.kernel.org/show_bug.cgi?id=14782

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/button.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 0c9c6a9..8a95e83 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -282,6 +282,13 @@ static int acpi_lid_send_state(struct acpi_device *device)
 	if (ret == NOTIFY_DONE)
 		ret = blocking_notifier_call_chain(&acpi_lid_notifier, state,
 						   device);
+	if (ret == NOTIFY_DONE || ret == NOTIFY_OK) {
+		/*
+		 * It is also regarded as success if the notifier_chain
+		 * returns NOTIFY_OK or NOTIFY_DONE.
+		 */
+		ret = 0;
+	}
 	return ret;
 }
 
-- 
1.6.0.6

