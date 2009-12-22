From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] fujitus-laptop: fix tests of acpi_evaluate_integer() return value
Date: Wed, 23 Dec 2009 09:19:42 +1030 (CST)
Message-ID: <200912222249.nBMMngkl002406@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:56689 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751730AbZLVWua (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Dec 2009 17:50:30 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, roel.kluin@gmail.com, lenb@kernel.org
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Fix tests on return value from acpi_evaluate_integer().  Based on a patch by
Roel Kluin <roel.kluin@gmail.com> and incorporating suggestions from Len
Brown <lenb@kernel.org>.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Signed-off-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>


--- a/drivers/platform/x86/fujitsu-laptop.c	2009-12-23 09:11:23.599497331 +1030
+++ b/drivers/platform/x86/fujitsu-laptop.c	2009-12-23 09:12:12.754405304 +1030
@@ -376,8 +376,8 @@ static int get_lcd_level(void)
 
 	status =
 	    acpi_evaluate_integer(fujitsu->acpi_handle, "GBLL", NULL, &state);
-	if (status < 0)
-		return status;
+	if (ACPI_FAILURE(status))
+		return 0;
 
 	fujitsu->brightness_level = state & 0x0fffffff;
 
@@ -398,8 +398,8 @@ static int get_max_brightness(void)
 
 	status =
 	    acpi_evaluate_integer(fujitsu->acpi_handle, "RBLL", NULL, &state);
-	if (status < 0)
-		return status;
+	if (ACPI_FAILURE(status))
+		return -1;
 
 	fujitsu->max_brightness = state;
 
