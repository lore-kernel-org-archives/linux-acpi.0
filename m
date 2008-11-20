From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [PATCH v2 1/3] eeepc-laptop: Add support for extended hotkeys
Date: Thu, 20 Nov 2008 15:36:28 +0000
Message-ID: <a26244bd6e7cae264155edca7f3c22f8f319b239.1227194932.git.mjg@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55942 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339AbYKTPgd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Nov 2008 10:36:33 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Corentin Chary <corentin.chary@gmail.com>, ecc@cmu.edu, linux acpi <linux-acpi@vger.kernel.org>

Newer Eees have extra hotkeys above the function keys. This patch adds support
for sending them through the input layer.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/misc/eeepc-laptop.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/eeepc-laptop.c b/drivers/misc/eeepc-laptop.c
index 9ef98b2..e81ef18 100644
--- a/drivers/misc/eeepc-laptop.c
+++ b/drivers/misc/eeepc-laptop.c
@@ -161,6 +161,10 @@ static struct key_entry eeepc_keymap[] = {
 	{KE_KEY, 0x13, KEY_MUTE },
 	{KE_KEY, 0x14, KEY_VOLUMEDOWN },
 	{KE_KEY, 0x15, KEY_VOLUMEUP },
+	{KE_KEY, 0x1a, KEY_COFFEE },
+	{KE_KEY, 0x1b, KEY_ZOOM },
+	{KE_KEY, 0x1c, KEY_PROG2 },
+	{KE_KEY, 0x1d, KEY_PROG3 },
 	{KE_KEY, 0x30, KEY_SWITCHVIDEOMODE },
 	{KE_KEY, 0x31, KEY_SWITCHVIDEOMODE },
 	{KE_KEY, 0x32, KEY_SWITCHVIDEOMODE },

-- 
Matthew Garrett | mjg59@srcf.ucam.org
