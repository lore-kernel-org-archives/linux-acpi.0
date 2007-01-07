From: malattia@linux.it
Subject: [PATCH 9/11] Add lanpower and audiopower controls
Date: Sun,  7 Jan 2007 18:54:41 +0100
Message-ID: <11681924831019-git-send-email-malattia@linux.it>
References: <1168192483500-git-send-email-malattia@linux.it> <11681924832840-git-send-email-malattia@linux.it> <1168192483207-git-send-email-malattia@linux.it> <11681924833947-git-send-email-malattia@linux.it> <11681924832264-git-send-email-malattia@linux.it> <11681924831582-git-send-email-malattia@linux.it> <11681924831482-git-send-email-malattia@linux.it> <11681924833473-git-send-email-malattia@linux.it> <11681924833091-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:38090 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932623AbXAGSB5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Jan 2007 13:01:57 -0500
In-Reply-To: <11681924833091-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

From: Mattia Dongili <malattia@linux.it>

audiopower works well on my SZ72B so it's not marked has "debug" while lanpower
has at least one report of not resuming power happily so morked as "debug"

Signed-off-by: Mattia Dongili <malattia@linux.it>
---
 drivers/acpi/sony_acpi.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
index 69122ad..1f7dca3 100644
--- a/drivers/acpi/sony_acpi.c
+++ b/drivers/acpi/sony_acpi.c
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
-- 
1.4.4.2

