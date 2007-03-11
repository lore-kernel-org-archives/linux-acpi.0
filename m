From: Corentin CHARY <corentincj@iksaif.net>
Subject: [PATCH 5/5] asus-laptop version bump
Date: Sun, 11 Mar 2007 10:28:03 +0100
Message-ID: <200703111028.03801.corentincj@iksaif.net>
References: <200703111023.04437.corentincj@iksaif.net>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:48339 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbXCKJ2F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Mar 2007 05:28:05 -0400
In-Reply-To: <200703111023.04437.corentincj@iksaif.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, acpi4asus-user@lists.sourceforge.net

From: Corentin Chary <corentincj@iksaif.net>

Version and copyright bump.

Signed-off-by: Corentin Chary <corentincj@iksaif.net>
---
 asus-laptop.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/misc/asus-laptop.c	2007-03-10 16:35:10.000000000 +0100
+++ b/drivers/misc/asus-laptop.c	2007-03-10 16:35:53.000000000 +0100
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
