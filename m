From: akpm@linux-foundation.org
Subject: [patch 3/6] eeepc-laptop: enable Bluetooth for Asus EEE 901
Date: Fri, 09 Jan 2009 12:17:10 -0800
Message-ID: <200901092017.n09KHA3E014942@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39933 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755071AbZAIUSS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 15:18:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, santiago@crfreenet.org, corentincj@iksaif.net, mjg59@srcf.ucam.org

From: Ondrej Zajicek <santiago@crfreenet.org>

eeepc-laptop driver has interface for enabling/disabling Bluetooth, but it
does not work.  This patch fixes it.

Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Corentin Chary <corentincj@iksaif.net>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/eeepc-laptop.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/platform/x86/eeepc-laptop.c~eeepc-laptop-enable-bluetooth-for-asus-eee-901 drivers/platform/x86/eeepc-laptop.c
--- a/drivers/platform/x86/eeepc-laptop.c~eeepc-laptop-enable-bluetooth-for-asus-eee-901
+++ a/drivers/platform/x86/eeepc-laptop.c
@@ -90,7 +90,7 @@ enum {
 };
 
 static const char *cm_getv[] = {
-	"WLDG", NULL, NULL, NULL,
+	"WLDG", "BTHG", NULL, NULL,
 	"CAMG", NULL, NULL, NULL,
 	NULL, "PBLG", NULL, NULL,
 	"CFVG", NULL, NULL, NULL,
@@ -99,7 +99,7 @@ static const char *cm_getv[] = {
 };
 
 static const char *cm_setv[] = {
-	"WLDS", NULL, NULL, NULL,
+	"WLDS", "BTHS", NULL, NULL,
 	"CAMS", NULL, NULL, NULL,
 	"SDSP", "PBLS", "HDPS", NULL,
 	"CFVS", NULL, NULL, NULL,
_
