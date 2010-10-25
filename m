From: Len Brown <lenb@kernel.org>
Subject: [PATCH 22/60] ACPI: add FW_BUG to OSI(Linux) message
Date: Mon, 25 Oct 2010 02:20:30 -0400
Message-ID: <3af283e1141474925b33383425bbe038e75fd03a.1287987547.git.len.brown@intel.com>
References: <1287987668-17584-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:50524 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753151Ab0JYHLC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Oct 2010 03:11:02 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAU00FPR3YCZ7J4@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 25 Oct 2010 02:11:01 -0500 (CDT)
In-reply-to: <1287987668-17584-1-git-send-email-lenb@kernel.org>
In-reply-to: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
References: <a210080195c95ebca2a517ee3057d71607aa65e0.1287987547.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Linux-2.6.22 initiated a dmesg complaint when it saw BIOS that invoked
OSI(Linux).  Linux-2.6.23 continued that complaint and started our
policy of ignoring the bogus BIOS request.

Past-time for Linux to label that complaint with FW_BUG.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/osl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 90a8e86..d3bed21 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -144,7 +144,7 @@ static u32 acpi_osi_handler(acpi_string interface, u32 supported)
 {
 	if (!strcmp("Linux", interface)) {
 
-		printk(KERN_NOTICE PREFIX
+		printk(KERN_NOTICE FW_BUG PREFIX
 			"BIOS _OSI(Linux) query %s%s\n",
 			osi_linux.enable ? "honored" : "ignored",
 			osi_linux.cmdline ? " via cmdline" :
-- 
1.7.3.2.90.gd4c43

