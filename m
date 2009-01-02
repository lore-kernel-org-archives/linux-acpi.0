From: Michel Lespinasse <walken@zoy.org>
Subject: P1-AH2 suspend ordering patch
Date: Fri, 2 Jan 2009 04:23:50 -0800
Message-ID: <20090102122350.GE24908@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from server.lespinasse.org ([64.142.28.226]:42720 "EHLO
	server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757587AbZABMui (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Jan 2009 07:50:38 -0500
Received: from michel.lespinasse.org (michel.home.lespinasse.org [10.1.0.1])
	by server.lespinasse.org (Postfix) with ESMTP id 4396E2FEE2
	for <linux-acpi@vger.kernel.org>; Fri,  2 Jan 2009 04:23:51 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

The following patch (over 2.6.28) makes suspend/resume work on
ASUS P1-AH2 systems:

Signed-off-by: Michel Lespinasse <walken@zoy.org>
--- drivers/acpi/sleep/main.c.orig	2009-01-02 04:01:19.000000000 -0800
+++ drivers/acpi/sleep/main.c	2009-01-02 04:10:11.000000000 -0800
@@ -363,6 +363,14 @@
 		},
 	},
 	{
+	.callback = init_old_suspend_ordering,
+	.ident = "ASUS P1-AH2",
+	.matches = {
+		DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTek Computer INC."),
+		DMI_MATCH(DMI_BOARD_NAME, "M2N8L"),
+		},
+	},
+	{
 	.callback = init_set_sci_en_on_resume,
 	.ident = "Apple MacBook 1,1",
 	.matches = {


(The M2N8L motherboard is, as far as I know, only found in the P1-AH2
barebones systems. It has a special shape and would not fit in any
standard system anyway).

Please apply into all appropriate trees...

Cheers,

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
