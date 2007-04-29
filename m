From: Len Brown <len.brown@intel.com>
Subject: [PATCH 017/105] asus-laptop: version bump
Date: Sun, 29 Apr 2007 00:50:17 -0400
Message-ID: <11778223201940-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:58359 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754602AbXD2EwB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:01 -0400
In-Reply-To: <11778223192706-git-send-email-len.brown@intel.com>
Message-Id: <8ec555c2c4c6c33759a1dbb13fa8f3b14fc77e10.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Corentin Chary <corentincj@iksaif.net>

Version and copyright bump.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/misc/asus-laptop.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/asus-laptop.c b/drivers/misc/asus-laptop.c
index d75e447..65c32a9 100644
--- a/drivers/misc/asus-laptop.c
+++ b/drivers/misc/asus-laptop.c
@@ -3,7 +3,7 @@
  *
  *
  *  Copyright (C) 2002-2005 Julien Lerouge, 2003-2006 Karol Kozimor
- *  Copyright (C) 2006 Corentin Chary
+ *  Copyright (C) 2006-2007 Corentin Chary
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -48,7 +48,7 @@
 #include <acpi/acpi_bus.h>
 #include <asm/uaccess.h>
 
-#define ASUS_LAPTOP_VERSION "0.40"
+#define ASUS_LAPTOP_VERSION "0.41"
 
 #define ASUS_HOTK_NAME          "Asus Laptop Support"
 #define ASUS_HOTK_CLASS         "hotkey"
-- 
1.5.2.rc0.34.gda94
