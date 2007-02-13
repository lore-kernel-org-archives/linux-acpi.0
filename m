From: Len Brown <lenb@kernel.org>
Subject: [PATCH 09/41] sony_acpi: Add lanpower and audiopower controls
Date: Tue, 13 Feb 2007 00:49:11 -0500
Message-ID: <1171345798129-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org> <11713457941772-git-send-email-lenb@kernel.org> <11713457953042-git-send-email-lenb@kernel.org> <11713457971245-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:39577 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751049AbXBMFuA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:50:00 -0500
In-Reply-To: <11713457971245-git-send-email-lenb@kernel.org>
Message-Id: <a510bc55cb997353d4dbdbb9632ecb71ac4d2f98.1171345630.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Mattia Dongili <malattia@linux.it>

audiopower works well on my SZ72B so it's not marked has "debug" while lanpower
has at least one report of not resuming power happily so morked as "debug"

Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.0.rc4.345.gb4d2
