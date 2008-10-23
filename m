From: Len Brown <lenb@kernel.org>
Subject: [PATCH 029/122] ACPI: toshiba_acpi.c fix sparse signedness mismatch
 warnings
Date: Thu, 23 Oct 2008 02:38:03 -0400
Message-ID: <9e113e0014204bfb44a2baa29b2a141ede41b074.1224743916.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:40876 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754263AbYJWGjx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:39:53 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K96000WVIIGXXG2@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:39:52 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Harvey Harrison <harvey.harrison@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Harvey Harrison <harvey.harrison@gmail.com>

set_bit expects unsigned int, and we start with a u32 anyway.
drivers/acpi/toshiba_acpi.c:397:14: warning: incorrect type in argument 1 (different signedness)
drivers/acpi/toshiba_acpi.c:397:14:    expected unsigned int [usertype] *word
drivers/acpi/toshiba_acpi.c:397:14:    got int *<noident>
drivers/acpi/toshiba_acpi.c:399:14: warning: incorrect type in argument 1 (different signedness)
drivers/acpi/toshiba_acpi.c:399:14:    expected unsigned int [usertype] *word
drivers/acpi/toshiba_acpi.c:399:14:    got int *<noident>
drivers/acpi/toshiba_acpi.c:401:14: warning: incorrect type in argument 1 (different signedness)
drivers/acpi/toshiba_acpi.c:401:14:    expected unsigned int [usertype] *word
drivers/acpi/toshiba_acpi.c:401:14:    got int *<noident>

Signed-off-by: Harvey Harrison <harvey.harrison@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/toshiba_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/toshiba_acpi.c b/drivers/acpi/toshiba_acpi.c
index 0a43c8e..4172d29 100644
--- a/drivers/acpi/toshiba_acpi.c
+++ b/drivers/acpi/toshiba_acpi.c
@@ -392,7 +392,7 @@ static unsigned long write_video(const char *buffer, unsigned long count)
 
 	hci_read1(HCI_VIDEO_OUT, &video_out, &hci_result);
 	if (hci_result == HCI_SUCCESS) {
-		int new_video_out = video_out;
+		unsigned int new_video_out = video_out;
 		if (lcd_out != -1)
 			_set_bit(&new_video_out, HCI_VIDEO_OUT_LCD, lcd_out);
 		if (crt_out != -1)
-- 
1.5.5.1

