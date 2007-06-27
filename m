From: Stephen Hemminger <shemminger@linux-foundation.org>
Subject: [PATCH] remove leftover documentation of acpi_generic_hotkey
Date: Tue, 26 Jun 2007 22:03:04 -0400
Message-ID: <20070626220304.7bc5472e@oldman>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:40242 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753793AbXF0CDY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Jun 2007 22:03:24 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-acpi@vger.kernel.org

This looks leftover text  in the kernel parameter in documentation.

Signed-off-by: Stephen Hemminger <shemminger@linux-foundation.org>

--- a/Documentation/kernel-parameters.txt	2007-06-26 16:46:57.000000000 -0400
+++ b/Documentation/kernel-parameters.txt	2007-06-26 16:47:07.000000000 -0400
@@ -223,11 +223,6 @@ and is between 256 and 4096 characters. 
 
 	acpi_fake_ecdt	[HW,ACPI] Workaround failure due to BIOS lacking ECDT
 
-	acpi_generic_hotkey [HW,ACPI]
-			Allow consolidated generic hotkey driver to
-			override platform specific driver.
-			See also Documentation/acpi-hotkey.txt.
-
 	acpi_pm_good	[IA-32,X86-64]
 			Override the pmtimer bug detection: force the kernel
 			to assume that this machine's pmtimer latches its value
