From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/34] fujitu-laptop: fix tests of acpi_evaluate_integer()
 return value
Date: Thu, 24 Dec 2009 01:23:50 -0500
Message-ID: <3b1c37cab3765b87efbd4ed40301ceaf72b9f5c2.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755778AbZLXTbU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:20 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:31:02 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Roel Kluin <roel.kluin@gmail.com>, Len Brown <len.brown@intel.com>

From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Fix tests on return value from acpi_evaluate_integer().  Based on a patch by
Roel Kluin <roel.kluin@gmail.com> and incorporating suggestions from Len
Brown <lenb@kernel.org>.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/fujitsu-laptop.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index bcd4ba8..3c2d038 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -376,8 +376,8 @@ static int get_lcd_level(void)
 
 	status =
 	    acpi_evaluate_integer(fujitsu->acpi_handle, "GBLL", NULL, &state);
-	if (status < 0)
-		return status;
+	if (ACPI_FAILURE(status))
+		return 0;
 
 	fujitsu->brightness_level = state & 0x0fffffff;
 
@@ -398,8 +398,8 @@ static int get_max_brightness(void)
 
 	status =
 	    acpi_evaluate_integer(fujitsu->acpi_handle, "RBLL", NULL, &state);
-	if (status < 0)
-		return status;
+	if (ACPI_FAILURE(status))
+		return -1;
 
 	fujitsu->max_brightness = state;
 
-- 
1.6.0.6

