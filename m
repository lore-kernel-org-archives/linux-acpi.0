From: Stefan Bader <stefan.bader@canonical.com>
Subject: [PATCH][RESEND] acerhdf: Limit modalias matching to supported boards
Date: Thu, 22 Oct 2009 08:12:39 -0400
Message-ID: <4AE04C37.8080709@canonical.com>
References: <4AC9E0F3.5030605@canonical.com> <4AC9E122.8050609@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000808030503020104070703"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:52154 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225AbZJVMMj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Oct 2009 08:12:39 -0400
In-Reply-To: <4AC9E122.8050609@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Borislav Petkov <petkovbb@gmail.com>, Peter Feuerer <peter@piie.net>

This is a multi-part message in MIME format.
--------------000808030503020104070703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Len,

could you please add the following patch to acpi-testing. Thanks.

Stefan



--------------000808030503020104070703
Content-Type: text/x-diff;
 name="0001-UBUNTU-Upstream-acerhdf-Limit-modalias-matching-to-s.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-UBUNTU-Upstream-acerhdf-Limit-modalias-matching-to-s.pa";
 filename*1="tch"

>From 230e81c3440cdfc5f931755cece4f1181a3b1374 Mon Sep 17 00:00:00 2001
From: Stefan Bader <stefan.bader@canonical.com>
Date: Mon, 28 Sep 2009 17:11:29 +0000
Subject: [PATCH] acerhdf: Limit modalias matching to supported boards

BugLink: https://bugs.launchpad.net/ubuntu/+bug/435958

The module alias currently matches any Acer computer but when loaded the
BIOS checks will only succeed on Aspire One models. This causes a invalid
BIOS warning for all other models (seen on Aspire 4810T).
This is not fatal but worries users that see this message. Limiting the
moule alias to models starting with AOA or DOA for Packard Bell.

Signed-off-by: Stefan Bader <stefan.bader@canonical.com>
Acked-by: Borislav Petkov <petkovbb@gmail.com>
Acked-by: Peter Feuerer <peter@piie.net>
---
 drivers/platform/x86/acerhdf.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index aa298d6..890976f 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -629,9 +629,10 @@ static void __exit acerhdf_exit(void)
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
-- 
1.6.3.3


--------------000808030503020104070703--
