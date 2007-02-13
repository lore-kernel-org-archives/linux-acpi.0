From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/41] sony_acpi: Video sysfs support take 2
Date: Tue, 13 Feb 2007 00:49:08 -0500
Message-ID: <11713457941772-git-send-email-lenb@kernel.org>
References: <11713457831139-git-send-email-lenb@kernel.org> <11713457843659-git-send-email-lenb@kernel.org> <11713457871537-git-send-email-lenb@kernel.org> <1171345789246-git-send-email-lenb@kernel.org> <1171345790970-git-send-email-lenb@kernel.org> <11713457922756-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:39577 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751045AbXBMFt4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Feb 2007 00:49:56 -0500
In-Reply-To: <11713457922756-git-send-email-lenb@kernel.org>
Message-Id: <95e3512ecb64af5b28facb75c75979c328ef248f.1171345630.git.len.brown@intel.com>
In-Reply-To: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
References: <268d175f131e33fe1aed4cd5080884ab5d0badb2.1171345630.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>

From: Andrew Morton <akpm@osdl.org>

add dev argument for backlight_device_register

Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Mattia Dongili <malattia@linux.it>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/sony_acpi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/sony_acpi.c b/drivers/acpi/sony_acpi.c
index fd7d55a..195895c 100644
--- a/drivers/acpi/sony_acpi.c
+++ b/drivers/acpi/sony_acpi.c
@@ -322,7 +322,7 @@ static int sony_acpi_add(struct acpi_device *device)
 
 	if (ACPI_SUCCESS(acpi_get_handle(sony_acpi_handle, "GBRT", &handle))) {
 		sony_backlight_device = backlight_device_register("sony", NULL,
-					&sony_backlight_properties);
+					NULL, &sony_backlight_properties);
 	        if (IS_ERR(sony_backlight_device)) {
         	        printk(LOG_PFX "unable to register backlight device\n");
 		}
-- 
1.5.0.rc4.345.gb4d2
