From: Olivier Berger <oberger@ouvaton.org>
Subject: [PATCH] Removing ACPI blacklisting for P4B266 mainboards.
Date: Thu, 21 May 2009 16:07:38 +0200
Message-ID: <87skiyft1x.fsf@olivierberger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp5-g21.free.fr ([212.27.42.5]:44292 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752833AbZEUOHq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 21 May 2009 10:07:46 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id AB86CD48114
	for <linux-acpi@vger.kernel.org>; Thu, 21 May 2009 16:07:41 +0200 (CEST)
Received: from asustour (mag77-1-82-238-14-130.fbx.proxad.net [82.238.14.130])
	by smtp5-g21.free.fr (Postfix) with ESMTP id C5984D4804C
	for <linux-acpi@vger.kernel.org>; Thu, 21 May 2009 16:07:38 +0200 (CEST)
Received: from olivier by asustour with local (Exim 4.69)
	(envelope-from <oberger@ouvaton.org>)
	id 1M78vq-000222-C4
	for linux-acpi@vger.kernel.org; Thu, 21 May 2009 16:07:38 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

>From 6f304fa7c0e0c5bac86fb47c53354889017fceb8 Mon Sep 17 00:00:00 2001

 See http://marc.info/?l=linux-acpi&m=124068823904429&w=2 for discussion

Signed-off-by: Olivier Berger <oberger@ouvaton.org>
---
 arch/x86/kernel/acpi/boot.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 723989d..065b3fa 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1569,14 +1569,6 @@ static struct dmi_system_id __initdata acpi_dmi_table[] = {
 	 },
 	{
 	 .callback = force_acpi_ht,
-	 .ident = "ASUS P4B266",
-	 .matches = {
-		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-		     DMI_MATCH(DMI_BOARD_NAME, "P4B266"),
-		     },
-	 },
-	{
-	 .callback = force_acpi_ht,
 	 .ident = "ASUS P2B-DS",
 	 .matches = {
 		     DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-- 
1.6.2.4


-- 
Olivier BERGER 
(OpenPGP: 1024D/B4C5F37F)
http://www.olivierberger.com/weblog/
