From: Nicolas Kaiser <nikai@nikai.net>
Subject: [PATCH] drivers/misc/sony-laptop.c: remove duplicated define
Date: Fri, 9 Nov 2007 14:08:32 +0100
Message-ID: <20071109140832.4f2a145c@lucky.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ensim03.bon.m2soft.com ([195.38.20.12]:49645 "EHLO
	ensim03.bon.m2soft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758344AbXKINUP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Nov 2007 08:20:15 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org

Remove duplicated define.

Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
---

 drivers/misc/sony-laptop.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/misc/sony-laptop.c	2007-11-07 11:26:12.000000000 +0100
+++ b/drivers/misc/sony-laptop.c	2007-11-09 13:56:36.000000000 +0100
@@ -1504,7 +1504,6 @@
 #define SONYPI_CAMERA_SHUTTER_MASK 		0x7
 
 #define SONYPI_CAMERA_SHUTDOWN_REQUEST		7
-#define SONYPI_CAMERA_CONTROL			0x10
 
 #define SONYPI_CAMERA_STATUS 			7
 #define SONYPI_CAMERA_STATUS_READY 		0x2
