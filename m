From: Adrian Bunk <bunk@kernel.org>
Subject: [2.6 patch] sony-laptop.c: fix off-by-one
Date: Wed, 20 Feb 2008 00:59:03 +0200
Message-ID: <20080219225903.GS31955@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp5.pp.htv.fi ([213.243.153.39]:38533 "EHLO smtp5.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759821AbYBSW7k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Feb 2008 17:59:40 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>, Len Brown <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

This patch fixes an off-by-one spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
--- linux-2.6/drivers/misc/sony-laptop.c.old	2008-02-20 00:26:21.000000000 +0200
+++ linux-2.6/drivers/misc/sony-laptop.c	2008-02-20 00:26:38.000000000 +0200
@@ -314,9 +314,9 @@ static void sony_laptop_report_input_eve
 		kp.dev = jog_dev;
 		break;
 
 	default:
-		if (event > ARRAY_SIZE(sony_laptop_input_index)) {
+		if (event >= ARRAY_SIZE(sony_laptop_input_index)) {
 			dprintk("sony_laptop_report_input_event, event not known: %d\n", event);
 			break;
 		}
 		if (sony_laptop_input_index[event] != -1) {

