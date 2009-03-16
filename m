From: Len Brown <lenb@kernel.org>
Subject: [PATCH 10/14] acer-wmi: double free in acer_rfkill_exit()
Date: Mon, 16 Mar 2009 01:23:56 -0400
Message-ID: <013d67fd4f0da8f6af60a376f1a254266ab658ef.1237181013.git.len.brown@intel.com>
References: <1237181040-24165-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:16324 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbZCPFYL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Mar 2009 01:24:11 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGL0030R3070T38@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 16 Mar 2009 00:24:08 -0500 (CDT)
In-reply-to: <1237181040-24165-1-git-send-email-lenb@kernel.org>
In-reply-to: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
References: <a140449584522c3eea1bb381f746d40939e6f62a.1237181013.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dan Carpenter <error27@gmail.com>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Len Brown <len.brown@intel.com>

From: Dan Carpenter <error27@gmail.com>

This is acer_rfkill_exit() from drivers/platform/x86/acer-wmi.c.

The code frees wireless_rfkill->data again instead of
bluetooth_rfkill->data.

This was found using a code checker (http://repo.or.cz/w/smatch.git/).

Signed-off-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/acer-wmi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 6bcca61..a6a42e8 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1026,7 +1026,7 @@ static void acer_rfkill_exit(void)
 	kfree(wireless_rfkill->data);
 	rfkill_unregister(wireless_rfkill);
 	if (has_cap(ACER_CAP_BLUETOOTH)) {
-		kfree(wireless_rfkill->data);
+		kfree(bluetooth_rfkill->data);
 		rfkill_unregister(bluetooth_rfkill);
 	}
 	return;
-- 
1.5.6.6

