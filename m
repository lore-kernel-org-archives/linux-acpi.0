From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] ACPI video: Still use ACPI backlight control if _DOS
 doesn't exist
Date: Wed, 20 Jun 2012 09:48:43 +0800
Message-ID: <1340156923.1682.16.camel@rui.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60900 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831Ab2FTBrG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Jun 2012 21:47:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Len, Brown" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>


This is a regression introduced by commit
ea9f8856bd6d4ed45885b06a338f7362cd6c60e5
https://bugzilla.kernel.org/show_bug.cgi?id=43168

Some platforms don't have _DOS control method, but the ACPI
backlight still works.
We should not invoke _DOS for these platforms.

CC : Igor Murzov <intergalactic.anonymous@gmail.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/video.c |    2 ++
 1 file changed, 2 insertions(+)

Index: rtd3/drivers/acpi/video.c
===================================================================
--- rtd3.orig/drivers/acpi/video.c
+++ rtd3/drivers/acpi/video.c
@@ -558,6 +558,8 @@ acpi_video_bus_DOS(struct acpi_video_bus
 	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
 	struct acpi_object_list args = { 1, &arg0 };
 
+	if (!video->cap._DOS)
+		return 0;
 
 	if (bios_flag < 0 || bios_flag > 3 || lcd_flag < 0 || lcd_flag > 1)
 		return -EINVAL;


