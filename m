From: akpm@linux-foundation.org
Subject: [patch 7/9] acerhdf: limit modalias matching to supported
Date: Mon, 21 Dec 2009 16:20:04 -0800
Message-ID: <200912220020.nBM0K4Xk004758@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36801 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751744AbZLVAUu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Dec 2009 19:20:50 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, stefan.bader@canonical.com, peter@piie.net, petkovbb@gmail.com, stable@kernel.org

From: Stefan Bader <stefan.bader@canonical.com>

BugLink: https://bugs.launchpad.net/ubuntu/+bug/435958

The module alias currently matches any Acer computer but when loaded the
BIOS checks will only succeed on Aspire One models.  This causes a invalid
BIOS warning for all other models (seen on Aspire 4810T).  This is not
fatal but worries users that see this message.  Limiting the moule alias
to models starting with AOA or DOA for Packard Bell.

Signed-off-by: Stefan Bader <stefan.bader@canonical.com>
Acked-by: Borislav Petkov <petkovbb@gmail.com>
Acked-by: Peter Feuerer <peter@piie.net>
Cc: Len Brown <lenb@kernel.org>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/platform/x86/acerhdf.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff -puN drivers/platform/x86/acerhdf.c~acerhdf-limit-modalias-matching-to-supported drivers/platform/x86/acerhdf.c
--- a/drivers/platform/x86/acerhdf.c~acerhdf-limit-modalias-matching-to-supported
+++ a/drivers/platform/x86/acerhdf.c
@@ -640,9 +640,10 @@ static void __exit acerhdf_exit(void)
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Peter Feuerer");
 MODULE_DESCRIPTION("Aspire One temperature and fan driver");
-MODULE_ALIAS("dmi:*:*Acer*:*:");
-MODULE_ALIAS("dmi:*:*Gateway*:*:");
-MODULE_ALIAS("dmi:*:*Packard Bell*:*:");
+MODULE_ALIAS("dmi:*:*Acer*:pnAOA*:");
+MODULE_ALIAS("dmi:*:*Gateway*:pnAOA*:");
+MODULE_ALIAS("dmi:*:*Packard Bell*:pnAOA*:");
+MODULE_ALIAS("dmi:*:*Packard Bell*:pnDOA*:");
 
 module_init(acerhdf_init);
 module_exit(acerhdf_exit);
_
