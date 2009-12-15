From: yakui.zhao@intel.com
Subject: [PATCH] acpi: Use the return result of ACPI lid notifier chain correctly
Date: Tue, 15 Dec 2009 22:01:57 +0800
Message-ID: <1260885717-16098-1-git-send-email-yakui.zhao@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:24706 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754004AbZLOODu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Dec 2009 09:03:50 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

On some laptops it will return NOTIFY_OK(non-zero) when calling the ACPI LID
notifier. Then it is used as the result of ACPI LID resume function, which
will complain the following warning message in course of suspend/resume:

     >PM: Device PNP0C0D:00 failed to resume: error 1

This patch is to eliminate the above warning message.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
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
1.5.4.5

