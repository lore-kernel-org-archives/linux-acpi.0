From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/48] IPMI: Add the document description of ipmi_get_smi_info
Date: Wed, 12 Jan 2011 05:19:06 -0500
Message-ID: <37bf501bdda1d5d6ea73ce29d4b00d291b6f3811.1294827492.git.len.brown@intel.com>
References: <1294827582-4620-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:64394 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab1ALRAX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 12:00:23 -0500
Received: from localhost.localdomain ([unknown] [108.7.58.61])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LEX001MR5WB77F2@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 12 Jan 2011 11:00:13 -0600 (CST)
In-reply-to: <1294827582-4620-1-git-send-email-lenb@kernel.org>
In-reply-to: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
References: <803711afdbea5c6a6dd2b46eca76097f6d50fb53.1294827492.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Corey Minyard <cminyard@mvista.com>, Len Brown <len.brown@intel.com>

From: Zhao Yakui <yakui.zhao@intel.com>

Add the document description about how to use ipmi_get_smi_info.

Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/IPMI.txt |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/Documentation/IPMI.txt b/Documentation/IPMI.txt
index 69dd29e..b2bea15 100644
--- a/Documentation/IPMI.txt
+++ b/Documentation/IPMI.txt
@@ -533,6 +533,33 @@ completion during sending a panic event.
 Other Pieces
 ------------
 
+Get the detailed info related with the IPMI device
+--------------------------------------------------
+
+Some users need more detailed information about a device, like where
+the address came from or the raw base device for the IPMI interface.
+You can use the IPMI smi_watcher to catch the IPMI interfaces as they
+come or go, and to grab the information, you can use the function
+ipmi_get_smi_info(), which returns the following structure:
+
+struct ipmi_smi_info {
+	enum ipmi_addr_src addr_src;
+	struct device *dev;
+	union {
+		struct {
+			void *acpi_handle;
+		} acpi_info;
+	} addr_info;
+};
+
+Currently special info for only for SI_ACPI address sources is
+returned.  Others may be added as necessary.
+
+Note that the dev pointer is included in the above structure, and
+assuming ipmi_smi_get_info returns success, you must call put_device
+on the dev pointer.
+
+
 Watchdog
 --------
 
-- 
1.7.4.rc1.7.g2cf08

