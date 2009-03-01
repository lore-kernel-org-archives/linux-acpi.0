From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 6/9] [sony-laptop] notify the hardware of a state change in wwanpower
Date: Sun,  1 Mar 2009 13:40:42 +0900
Message-ID: <1235882445-2404-7-git-send-email-malattia@linux.it>
References: <1235882445-2404-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:48656
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756492AbZCAEuU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Feb 2009 23:50:20 -0500
In-Reply-To: <1235882445-2404-1-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Sergey Yanovich <ynvich@gmail.com>, Mattia Dongili <malattia@linux.it>

From: Sergey Yanovich <ynvich@gmail.com>

From: Sergey Yanovich <ynvich@gmail.com>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index f3bd13a..8568d1e 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -1785,6 +1785,7 @@ static void sony_pic_set_wwanpower(u8 state)
 		return;
 	}
 	sony_pic_call2(0xB0, state);
+	sony_pic_call1(0x82);
 	spic_dev.wwan_power = state;
 	mutex_unlock(&spic_dev.lock);
 }
-- 
1.6.1.3

