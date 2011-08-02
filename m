From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/27] ACPI print OSI(Linux) warning only once
Date: Tue, 02 Aug 2011 16:53:24 -0400
Message-ID: <8997621bb2daaf19a4e9d82f118224159d8054e2.1312318300.git.len.brown@intel.com>
References: <1312318409-29363-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:41222 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755421Ab1HBVwA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Aug 2011 17:52:00 -0400
Received: from localhost.localdomain ([unknown] [65.175.195.226])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LPB00IROM2GJRGL@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 02 Aug 2011 16:51:57 -0500 (CDT)
In-reply-to: <1312318409-29363-1-git-send-email-lenb@kernel.org>
In-reply-to: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
References: <c8cefe307d79c57b32ca1d4c9ebff528f8dd914c.1312318300.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

This message gets repeated on some machines:
https://bugzilla.kernel.org/show_bug.cgi?id=29292

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 52ca964..3765980 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -155,7 +155,7 @@ static u32 acpi_osi_handler(acpi_string interface, u32 supported)
 {
 	if (!strcmp("Linux", interface)) {
 
-		printk(KERN_NOTICE FW_BUG PREFIX
+		printk_once(KERN_NOTICE FW_BUG PREFIX
 			"BIOS _OSI(Linux) query %s%s\n",
 			osi_linux.enable ? "honored" : "ignored",
 			osi_linux.cmdline ? " via cmdline" :
-- 
1.7.6.396.ge0613

