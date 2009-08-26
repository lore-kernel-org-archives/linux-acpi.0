From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] fujitsu-laptop: fix config corner case
Date: Thu, 27 Aug 2009 08:44:46 +0930 (CST)
Message-ID: <200908262314.n7QNEkcP021958@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:59989 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752077AbZHZXP5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Aug 2009 19:15:57 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, lenb@kernel.org
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, alan-jenkins@tuffmail.co.uk

Hi Len

Here's another one for 2.6.31-rc or, failing that, 2.6.32.

---

This patch is a trivial fix for a config corner case, ensuring that
fujitsu-laptop doesn't get compiled into the kernel when the led class is a
module.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Signed-off-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

--- a/drivers/platform/x86/Kconfig	2009-08-26 11:03:20.000000000 +0930
+++ b/drivers/platform/x86/Kconfig	2009-08-26 11:04:28.000000000 +0930
@@ -82,6 +82,7 @@
 	depends on ACPI
 	depends on INPUT
 	depends on BACKLIGHT_CLASS_DEVICE
+	depends on LEDS_CLASS || LEDS_CLASS=n
 	---help---
 	  This is a driver for laptops built by Fujitsu:

