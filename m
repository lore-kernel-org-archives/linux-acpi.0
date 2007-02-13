From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/41] sony_acpi: Add backlight support to the sony_acpi v2
Date: Tue, 13 Feb 2007 00:49:07 -0500
Message-ID: <11713457922756-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:39577 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751028AbXBMFty (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:49:54 -0500
In-Reply-To: <1171345790970-git-send-email-lenb@kernel.org>
Message-Id: <9e73ddf5a1d443f31d2397a4d09a24788892716f.1171345630.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alessandro Guido <alessandro.guido@gmail.com>, Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Alessandro Guido <alessandro.guido@gmail.com>

Enable the sony_acpi driver to use the backlight subsysyem for adjusting
the monitor brightness.  Old way of changing the brightness will be still
available for compatibility with existing tools.

Signed-off-by: Alessandro Guido <alessandro.guido@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sony_acpi.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
index d509468..fd7d55a 100644
--- a/drivers/acpi/sony_acpi.c
+++ b/drivers/acpi/sony_acpi.c
@@ -77,6 +77,14 @@ static struct sony_acpi_value {
 	int			debug;	 /* active only in debug mode ? */
 } sony_acpi_values[] = {
 	{
+		.name		= "brightness",
+		.acpiget	= "GBRT",
+		.acpiset	= "SBRT",
+		.min		= 1,
+		.max		= SONY_MAX_BRIGHTNESS,
+		.debug		= 0,
+	},
+	{
 		.name		= "brightness_default",
 		.acpiget	= "GPBR",
 		.acpiset	= "SPBR",
-- 
1.5.0.rc4.345.gb4d2
