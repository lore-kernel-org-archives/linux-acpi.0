From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 2/5] thinkpad-acpi: don't fail to load the entire module due to ALSA problems
Date: Sat, 26 Dec 2009 22:52:14 -0200
Message-ID: <1261875137-27565-3-git-send-email-hmh@hmh.eng.br>
References: <1261875137-27565-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53068 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751653AbZL0AwW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Dec 2009 19:52:22 -0500
In-Reply-To: <1261875137-27565-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

If we cannot create the ALSA mixer, it is a good reason to fail to
load the volume subdriver, and not to fail to load the entire module.

While at it, add more debugging messages, as the error paths are being
used a lot more than I'd expect, and it is failing to set up the ALSA
mixer on a number of ThinkPads.

Reported-by: Peter Jordan <usernetwork@gmx.info>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   31 ++++++++++++++++++-------------
 1 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 3311b00..9b7da9c 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -6705,10 +6705,11 @@ static int __init volume_create_alsa_mixer(void)
 
 	rc = snd_card_create(alsa_index, alsa_id, THIS_MODULE,
 			    sizeof(struct tpacpi_alsa_data), &card);
-	if (rc < 0)
-		return rc;
-	if (!card)
-		return -ENOMEM;
+	if (rc < 0 || !card) {
+		printk(TPACPI_ERR
+			"Failed to create ALSA card structures: %d\n", rc);
+		return 1;
+	}
 
 	BUG_ON(!card->private_data);
 	data = card->private_data;
@@ -6741,8 +6742,9 @@ static int __init volume_create_alsa_mixer(void)
 		rc = snd_ctl_add(card, ctl_vol);
 		if (rc < 0) {
 			printk(TPACPI_ERR
-				"Failed to create ALSA volume control\n");
-			goto err_out;
+				"Failed to create ALSA volume control: %d\n",
+				rc);
+			goto err_exit;
 		}
 		data->ctl_vol_id = &ctl_vol->id;
 	}
@@ -6750,22 +6752,25 @@ static int __init volume_create_alsa_mixer(void)
 	ctl_mute = snd_ctl_new1(&volume_alsa_control_mute, NULL);
 	rc = snd_ctl_add(card, ctl_mute);
 	if (rc < 0) {
-		printk(TPACPI_ERR "Failed to create ALSA mute control\n");
-		goto err_out;
+		printk(TPACPI_ERR "Failed to create ALSA mute control: %d\n",
+			rc);
+		goto err_exit;
 	}
 	data->ctl_mute_id = &ctl_mute->id;
 
 	snd_card_set_dev(card, &tpacpi_pdev->dev);
 	rc = snd_card_register(card);
-
-err_out:
 	if (rc < 0) {
-		snd_card_free(card);
-		card = NULL;
+		printk(TPACPI_ERR "Failed to register ALSA card: %d\n", rc);
+		goto err_exit;
 	}
 
 	alsa_card = card;
-	return rc;
+	return 0;
+
+err_exit:
+	snd_card_free(card);
+	return 1;
 }
 
 #define TPACPI_VOL_Q_MUTEONLY	0x0001	/* Mute-only control available */
-- 
1.6.5.7

