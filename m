From: Len Brown <lenb@kernel.org>
Subject: [PATCH 12/29] sony-laptop: SNC 127 Initialization Fix
Date: Thu, 23 Apr 2009 02:23:34 -0400
Message-ID: <3e41d2cbc6afd231637f09ad5d07326066a2c203.1240467664.git.len.brown@intel.com>
References: <1240467831-32613-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:45066 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbZDWGYD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 02:24:03 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KIJ00LI6J413VE1@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Apr 2009 01:24:02 -0500 (CDT)
In-reply-to: <1240467831-32613-1-git-send-email-lenb@kernel.org>
In-reply-to: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
References: <50a4da890102a455e5cd3dd358c38650d07178d3.1240467664.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Almer S. Tigelaar" <almer@gnome.org>, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Almer S. Tigelaar <almer@gnome.org>

Fixes additional special key initialization for SNC 127 key events.
Verified / tested on a Sony VAIO SR model.

Signed-off-by: Almer S. Tigelaar <almer@gnome.org>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/sony-laptop.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 87080d0..4ff41a7 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1003,6 +1003,7 @@ static int sony_nc_function_setup(struct acpi_device *device)
 	sony_call_snc_handle(0x0100, 0, &result);
 	sony_call_snc_handle(0x0101, 0, &result);
 	sony_call_snc_handle(0x0102, 0x100, &result);
+	sony_call_snc_handle(0x0127, 0, &result);
 
 	return 0;
 }
-- 
1.6.0.6

