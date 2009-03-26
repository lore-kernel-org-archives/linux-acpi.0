From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 10/14] sony-laptop: notify the hardware of a state change in wwanpower
Date: Thu, 26 Mar 2009 21:58:21 +0900
Message-ID: <1238072305-8085-11-git-send-email-malattia@linux.it>
References: <1238072305-8085-1-git-send-email-malattia@linux.it>
 <1238072305-8085-2-git-send-email-malattia@linux.it>
 <1238072305-8085-3-git-send-email-malattia@linux.it>
 <1238072305-8085-4-git-send-email-malattia@linux.it>
 <1238072305-8085-5-git-send-email-malattia@linux.it>
 <1238072305-8085-6-git-send-email-malattia@linux.it>
 <1238072305-8085-7-git-send-email-malattia@linux.it>
 <1238072305-8085-8-git-send-email-malattia@linux.it>
 <1238072305-8085-9-git-send-email-malattia@linux.it>
 <1238072305-8085-10-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:53434
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756964AbZCZM6g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Mar 2009 08:58:36 -0400
In-Reply-To: <1238072305-8085-10-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Sergey Yanovich <ynvich@gmail.com>, Mattia Dongili <malattia@linux.it>

From: Sergey Yanovich <ynvich@gmail.com>

Signed-off-by: Sergey Yanovich <ynvich@gmail.com>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 5030f99..74df723 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -2004,6 +2004,7 @@ static void sony_pic_set_wwanpower(u8 state)
 		return;
 	}
 	sony_pic_call2(0xB0, state);
+	sony_pic_call1(0x82);
 	spic_dev.wwan_power = state;
 	mutex_unlock(&spic_dev.lock);
 }
-- 
1.6.2

