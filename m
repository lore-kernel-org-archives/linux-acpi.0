From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2.6.32.stable] ACPI: Use the return result of ACPI lid notifier
 chain correctly
Date: Wed, 16 Dec 2009 22:46:35 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912162243440.10371@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:42197 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758360AbZLQDqj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 22:46:39 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUS000GW2HP22Y6@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 21:46:38 -0600 (CST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@kernel.org
Cc: linux-acpi@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>

>From 13c199c0d0cf78b27592991129fb8cbcfc5164de Mon Sep 17 00:00:00 2001
From: Zhao Yakui <yakui.zhao@intel.com>
Date: Tue, 15 Dec 2009 22:01:57 +0800

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
1.6.6.rc2.5.g49666

