From: Len Brown <lenb@kernel.org>
Subject: [PATCH 055/103] dell-laptop: add __init to init functions
Date: Wed, 16 Dec 2009 03:36:06 -0500
Message-ID: <4788df4cf44fd14847d37f88daea649f01c01017.1260952472.git.len.brown@intel.com>
References: <1260952614-3152-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41516 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754898AbZLPKFu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 05:05:50 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00A4HPDO02XA@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 04:05:49 -0600 (CST)
In-reply-to: <1260952614-3152-1-git-send-email-lenb@kernel.org>
In-reply-to: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
References: <5f46c2f25cfbb5faca7550738ac42c4d1491ddc8.1260952471.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Acked-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/dell-laptop.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index a4ce642..3780994 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -82,7 +82,7 @@ static const struct dmi_system_id __initdata dell_device_table[] = {
 	{ }
 };
 
-static void parse_da_table(const struct dmi_header *dm)
+static void __init parse_da_table(const struct dmi_header *dm)
 {
 	/* Final token is a terminator, so we don't want to copy it */
 	int tokens = (dm->length-11)/sizeof(struct calling_interface_token)-1;
@@ -111,7 +111,7 @@ static void parse_da_table(const struct dmi_header *dm)
 	da_num_tokens += tokens;
 }
 
-static void find_tokens(const struct dmi_header *dm, void *dummy)
+static void __init find_tokens(const struct dmi_header *dm, void *dummy)
 {
 	switch (dm->type) {
 	case 0xd4: /* Indexed IO */
@@ -214,7 +214,7 @@ static const struct rfkill_ops dell_rfkill_ops = {
 	.query = dell_rfkill_query,
 };
 
-static int dell_setup_rfkill(void)
+static int __init dell_setup_rfkill(void)
 {
 	struct calling_interface_buffer buffer;
 	int status;
-- 
1.6.0.6

