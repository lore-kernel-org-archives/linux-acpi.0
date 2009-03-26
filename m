From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 11/14] sony-laptop: Add FW specific hotkey events and DMI
Date: Thu, 26 Mar 2009 21:58:22 +0900
Message-ID: <1238072305-8085-12-git-send-email-malattia@linux.it>
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
 <1238072305-8085-11-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:53424
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756780AbZCZM6b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Mar 2009 08:58:31 -0400
In-Reply-To: <1238072305-8085-11-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Anton Veretenenko <anton@veretenenko.ru>, Mattia Dongili <malattia@linux.it>

From: Anton Veretenenko <anton@veretenenko.ru>

Signed-off-by: Anton Veretenenko <anton@veretenenko.ru>
Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/platform/x86/sony-laptop.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/platform/x86/sony-laptop.c b/drivers/platform/x86/sony-laptop.c
index 74df723..3575a2d 100644
--- a/drivers/platform/x86/sony-laptop.c
+++ b/drivers/platform/x86/sony-laptop.c
@@ -870,6 +870,12 @@ static struct sony_nc_event sony_100_events[] = {
 	{ 0x11, SONYPI_EVENT_ANYBUTTON_RELEASED },
 	{ 0x81, SONYPI_EVENT_FNKEY_F1 },
 	{ 0x01, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x82, SONYPI_EVENT_FNKEY_F2 },
+	{ 0x02, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x83, SONYPI_EVENT_FNKEY_F3 },
+	{ 0x03, SONYPI_EVENT_FNKEY_RELEASED },
+	{ 0x84, SONYPI_EVENT_FNKEY_F4 },
+	{ 0x04, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x85, SONYPI_EVENT_FNKEY_F5 },
 	{ 0x05, SONYPI_EVENT_FNKEY_RELEASED },
 	{ 0x86, SONYPI_EVENT_FNKEY_F6 },
-- 
1.6.2

