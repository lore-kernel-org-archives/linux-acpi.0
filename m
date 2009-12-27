From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 1/5] thinkpad-acpi: don't take the first ALSA slot by default
Date: Sat, 26 Dec 2009 22:52:13 -0200
Message-ID: <1261875137-27565-2-git-send-email-hmh@hmh.eng.br>
References: <1261875137-27565-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33685 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751868AbZL0AwX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Dec 2009 19:52:23 -0500
In-Reply-To: <1261875137-27565-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

We don't want to be the first soundcard.  We don't want to shift other
soundcards out of the way either, even if they load much later.

Ask ALSA to (by default) load us in one of the last three slots.  This
can be overriden at will using the "index" parameter.

Reported-by: Whoopie <whoopie79@gmx.net>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 448c8ae..3311b00 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6388,7 +6388,7 @@ static struct ibm_struct brightness_driver_data = {
 #define TPACPI_ALSA_SHRTNAME "ThinkPad Console Audio Control"
 #define TPACPI_ALSA_MIXERNAME TPACPI_ALSA_SHRTNAME
 
-static int alsa_index = SNDRV_DEFAULT_IDX1;
+static int alsa_index = ~((1 << (SNDRV_CARDS - 3)) - 1); /* last three slots */
 static char *alsa_id = "ThinkPadEC";
 static int alsa_enable = SNDRV_DEFAULT_ENABLE1;
 
-- 
1.6.5.7

