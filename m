From: akpm@linux-foundation.org
Subject: [patch 11/13] sony_acpi: add lanpower and audiopower controls
Date: Mon, 05 Feb 2007 16:09:18 -0800
Message-ID: <200702060010.l160ALCi003751@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:40712 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965156AbXBFALz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Feb 2007 19:11:55 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, malattia@linux.it

From: Mattia Dongili <malattia@linux.it>

audiopower works well on my SZ72B so it's not marked has "debug" while
lanpower has at least one report of not resuming power happily so morked as
"debug"

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/sony_acpi.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff -puN drivers/acpi/sony_acpi.c~sony_acpi-add-lanpower-and-audiopower-controls drivers/acpi/sony_acpi.c
--- a/drivers/acpi/sony_acpi.c~sony_acpi-add-lanpower-and-audiopower-controls
+++ a/drivers/acpi/sony_acpi.c
@@ -102,11 +102,27 @@ static struct sony_acpi_value {
 		.name		= "cdpower",
 		.acpiget	= "GCDP",
 		.acpiset	= "SCDP",
-		.min		= -1,
-		.max		= -1,
+		.min		= 0,
+		.max		= 1,
 		.debug		= 0,
 	},
 	{
+		.name           = "audiopower",
+		.acpiget        = "GAZP",
+		.acpiset        = "AZPW",
+		.min            = 0,
+		.max            = 1,
+		.debug          = 0,
+	},
+	{
+		.name           = "lanpower",
+		.acpiget        = "GLNP",
+		.acpiset        = "LNPW",
+		.min            = 0,
+		.max            = 1,
+		.debug          = 1,
+	},
+	{
 		.name		= "PID",
 		.acpiget	= "GPID",
 		.debug		= 1,
_
