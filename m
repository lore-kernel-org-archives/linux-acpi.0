From: akpm@linux-foundation.org
Subject: [patch 4/8] acerhdf: additional BIOS versions
Date: Fri, 18 Sep 2009 12:41:07 -0700
Message-ID: <200909181941.n8IJf83u002532@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:38617 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751827AbZIRTmm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Sep 2009 15:42:42 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, peter@piie.net, andi@lisas.de, petkovbb@googlemail.com

From: Peter Feuerer <peter@piie.net>

Added BIOS versions:
Acer: AOA110-v0.3307, AOA150-v0.3301, AOA150-v0.3307
Packard Bell: AOA150-v0.3105

Signed-off-by: Peter Feuerer <peter@piie.net>
Cc: Andreas Mohr <andi@lisas.de>
Cc: Borislav Petkov <petkovbb@googlemail.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/acerhdf.c |    4 ++++
 1 file changed, 4 insertions(+)

diff -puN drivers/platform/x86/acerhdf.c~acerhdf-additional-bios-versions drivers/platform/x86/acerhdf.c
--- a/drivers/platform/x86/acerhdf.c~acerhdf-additional-bios-versions
+++ a/drivers/platform/x86/acerhdf.c
@@ -139,13 +139,16 @@ static const struct bios_settings_t bios
 	{"Acer", "AOA110", "v0.3301", 0x55, 0x58, {0xaf, 0x00} },
 	{"Acer", "AOA110", "v0.3304", 0x55, 0x58, {0xaf, 0x00} },
 	{"Acer", "AOA110", "v0.3305", 0x55, 0x58, {0xaf, 0x00} },
+	{"Acer", "AOA110", "v0.3307", 0x55, 0x58, {0xaf, 0x00} },
 	{"Acer", "AOA110", "v0.3308", 0x55, 0x58, {0x21, 0x00} },
 	{"Acer", "AOA110", "v0.3309", 0x55, 0x58, {0x21, 0x00} },
 	{"Acer", "AOA110", "v0.3310", 0x55, 0x58, {0x21, 0x00} },
 	/* AOA150 */
 	{"Acer", "AOA150", "v0.3114", 0x55, 0x58, {0x20, 0x00} },
+	{"Acer", "AOA150", "v0.3301", 0x55, 0x58, {0x20, 0x00} },
 	{"Acer", "AOA150", "v0.3304", 0x55, 0x58, {0x20, 0x00} },
 	{"Acer", "AOA150", "v0.3305", 0x55, 0x58, {0x20, 0x00} },
+	{"Acer", "AOA150", "v0.3307", 0x55, 0x58, {0x20, 0x00} },
 	{"Acer", "AOA150", "v0.3308", 0x55, 0x58, {0x20, 0x00} },
 	{"Acer", "AOA150", "v0.3309", 0x55, 0x58, {0x20, 0x00} },
 	{"Acer", "AOA150", "v0.3310", 0x55, 0x58, {0x20, 0x00} },
@@ -154,6 +157,7 @@ static const struct bios_settings_t bios
 	{"Gateway", "AOA150", "v0.3103", 0x55, 0x58, {0x20, 0x00} },
 	{"Packard Bell", "DOA150", "v0.3104", 0x55, 0x58, {0x21, 0x00} },
 	{"Packard Bell", "AOA110", "v0.3105", 0x55, 0x58, {0x21, 0x00} },
+	{"Packard Bell", "AOA150", "v0.3105", 0x55, 0x58, {0x20, 0x00} },
 	/* pewpew-terminator */
 	{"", "", "", 0, 0, {0, 0} }
 };
_
