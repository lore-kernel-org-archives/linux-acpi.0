From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 7/7] [sony-laptop] notify the hardware of a state change in wwanpower
Date: Mon,  3 Nov 2008 18:41:20 +0900
Message-ID: <1225705280-12775-8-git-send-email-malattia@linux.it>
References: <1225705280-12775-1-git-send-email-malattia@linux.it>
 <1225705280-12775-2-git-send-email-malattia@linux.it>
 <1225705280-12775-3-git-send-email-malattia@linux.it>
 <1225705280-12775-4-git-send-email-malattia@linux.it>
 <1225705280-12775-5-git-send-email-malattia@linux.it>
 <1225705280-12775-6-git-send-email-malattia@linux.it>
 <1225705280-12775-7-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:48105
	"EHLO tadamune.kami.home" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754940AbYKCJlY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 04:41:24 -0500
In-Reply-To: <1225705280-12775-7-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Sergey Yanovich <ynvich@gmail.com>, Mattia Dongili <malattia@linux.it>

From: Sergey Yanovich <ynvich@gmail.com>

From: Sergey Yanovich <ynvich@gmail.com>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/misc/sony-laptop.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/sony-laptop.c b/drivers/misc/sony-laptop.c
index 77fe584..1c65e42 100644
--- a/drivers/misc/sony-laptop.c
+++ b/drivers/misc/sony-laptop.c
@@ -1779,6 +1779,7 @@ static void sony_pic_set_wwanpower(u8 state)
 		return;
 	}
 	sony_pic_call2(0xB0, state);
+	sony_pic_call1(0x82);
 	spic_dev.wwan_power = state;
 	mutex_unlock(&spic_dev.lock);
 }
-- 
1.5.6.5

