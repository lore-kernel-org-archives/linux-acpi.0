From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 07/10] eeepc-laptop: Add support for extended hotkeys
Date: Tue, 20 Jan 2009 16:17:46 +0100
Message-ID: <1232464669-29619-8-git-send-email-corentincj@iksaif.net>
References: <1232464669-29619-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:59564 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757217AbZATPR5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jan 2009 10:17:57 -0500
In-Reply-To: <1232464669-29619-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Garrett <mjg@redhat.com>, Corentin Chary <corentincj@iksaif.net>

From: Matthew Garrett <mjg59@srcf.ucam.org>

Newer Eees have extra hotkeys above the function keys. This patch adds support
for sending them through the input layer.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/eeepc-laptop.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 66d611b..d153871 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
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
1.6.1

