From: akpm@linux-foundation.org
Subject: [patch 2/5] ACPI: add ACPI aliases to toshiba_acpi module
Date: Tue, 04 Mar 2008 15:06:34 -0800
Message-ID: <200803042306.m24N6Ygd001806@imap1.linux-foundation.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44162 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934572AbYCDXIE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Mar 2008 18:08:04 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, akpm@linux-foundation.org, arvidjaar@mail.ru, blino@mandriva.com

From: Andrey Borzenkov < arvidjaar@mail.ru>

This adds aliases to enable autoloading of toishiba_acpi.  Two aliases are
defined - TOS6200 (for \\_SB_.VALD.GHCI) and TSO1900 (for \\_SB_.VALZ.GHCI). 
This allows toishiba_acpi to be autoloaded on systems that provide those
devices.

Signed-off-by: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: Olivier Blin <blino@mandriva.com>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/acpi/toshiba_acpi.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff -puN drivers/acpi/toshiba_acpi.c~acpi-add-acpi-aliases-to-toshiba_acpi-module drivers/acpi/toshiba_acpi.c
--- a/drivers/acpi/toshiba_acpi.c~acpi-add-acpi-aliases-to-toshiba_acpi-module
+++ a/drivers/acpi/toshiba_acpi.c
@@ -99,6 +99,13 @@ MODULE_LICENSE("GPL");
 #define HCI_VIDEO_OUT_CRT		0x2
 #define HCI_VIDEO_OUT_TV		0x4
 
+static const struct acpi_device_id toshiba_device_ids[] = {
+	{"TOS6200", 0},
+	{"TOS1900", 0},
+	{"", 0},
+};
+MODULE_DEVICE_TABLE(acpi, toshiba_device_ids);
+
 /* utility
  */
 
_
