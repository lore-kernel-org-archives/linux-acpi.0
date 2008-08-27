From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: [PATCH] fujitsu-laptop: fix regression for P8010 in 2.6.27-rc
Date: Wed, 27 Aug 2008 09:53:31 +0930 (CST)
Message-ID: <200808270023.m7R0NVKP014272@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:57351 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751346AbYH0AXg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Aug 2008 20:23:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, ak@linux.intel.com

Hi Andi

The following patch (based on a patch from Stephen Gildea) fixes a
regression with the LCD brightness keys on Fujitsu P8010 laptops which was
observed with the 2.6.27-rc series (basically they stopped working due to
changes within the fujitsu-laptop module).  Please apply to 2.6.27-rc and
acpi git.

Signed-off-by: Stephen Gildea <stepheng+fujitsu-laptop@gildea.com>
Signed-off-by: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>

Thanks
  jonathan

--- linux-2.6.27-rc4-orig/drivers/misc/fujitsu-laptop.c	2008-08-27 09:38:11.220532000 +0930
+++ linux-2.6.27-rc4/drivers/misc/fujitsu-laptop.c	2008-08-27 09:48:37.811194368 +0930
@@ -463,6 +463,13 @@ static struct dmi_system_id __initdata f
 		     DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK S6410"),
 		     },
 	 .callback = dmi_check_cb_s6410},
+	{
+	 .ident = "FUJITSU LifeBook P8010",
+	 .matches = {
+		     DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+		     DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook P8010"),
+		    },
+	 .callback = dmi_check_cb_s6410},
 	{}
 };
