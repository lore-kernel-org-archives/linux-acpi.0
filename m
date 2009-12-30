From: Len Brown <lenb@kernel.org>
Subject: [PATCH 04/14] thinkpad-acpi: don't fail to load the entire module due
 to ALSA problems
Date: Wed, 30 Dec 2009 02:36:27 -0500
Message-ID: <74c75c1848b618f6717c1be887ad539ffac2e96d.1262158495.git.len.brown@intel.com>
References: <1262158597-9597-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:48773 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752357AbZL3Hgr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2009 02:36:47 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KVG00JKUFT528PL@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 30 Dec 2009 01:36:44 -0600 (CST)
In-reply-to: <1262158597-9597-1-git-send-email-lenb@kernel.org>
In-reply-to: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
References: <51b0f1c2b8c32ee44ff01ef74599a1f17e4fc565.1262158495.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

If we cannot create the ALSA mixer, it is a good reason to fail to
load the volume subdriver, and not to fail to load the entire module.

While at it, add more debugging messages, as the error paths are being
used a lot more than I'd expect, and it is failing to set up the ALSA
mixer on a number of ThinkPads.

Reported-by: Peter Jordan <usernetwork@gmx.info>
Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.6.0.6

