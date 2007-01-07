From: malattia@linux.it
Subject: [PATCH 5/11] Add backlight support to the sony_acpi v2
Date: Sun,  7 Jan 2007 18:54:37 +0100
Message-ID: <11681924831582-git-send-email-malattia@linux.it>
References: <1168192483500-git-send-email-malattia@linux.it> <11681924832840-git-send-email-malattia@linux.it> <1168192483207-git-send-email-malattia@linux.it> <11681924833947-git-send-email-malattia@linux.it> <11681924832264-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:33087 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964810AbXAGRzX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Jan 2007 12:55:23 -0500
In-Reply-To: <11681924832264-git-send-email-malattia@linux.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Alessandro Guido <alessandro.guido@gmail.com>

From: Alessandro Guido <alessandro.guido@gmail.com>

Enable the sony_acpi driver to use the backlight subsysyem for adjusting
the monitor brightness.  Old way of changing the brightness will be still
available for compatibility with existing tools.

Signed-off-by: Alessandro Guido <alessandro.guido@gmail.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mattia Dongili <malattia@linux.it>
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
1.4.4.2

