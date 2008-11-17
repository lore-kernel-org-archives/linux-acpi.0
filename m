From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: [Patch 1/3] eeepc-laptop: Add support for extended hotkeys
Date: Mon, 17 Nov 2008 13:35:10 +0000
Message-ID: <20081117133510.GC12303@srcf.ucam.org>
References: <20081117133325.GB12303@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:40822 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbYKQNfU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Nov 2008 08:35:20 -0500
Content-Disposition: inline
In-Reply-To: <20081117133325.GB12303@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corentin Chary <corentin.chary@gmail.com>, ecc@cmu.edu
Cc: linux acpi <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org

Newer Eees have extra hotkeys above the function keys. This patch adds 
support for sending them through the input layer. Some default keycodes 
are added, but these can be remapped by the user.

Signed-off-by: Matthew Garrett <mjg@redhat.com>

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
