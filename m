From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.24-rc1-git] properly hookup acpi buttons to driver model tree
Date: Tue, 6 Nov 2007 12:07:46 -0800
Message-ID: <200711061207.46939.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:41685 "HELO
	smtp113.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753934AbXKFUHv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Nov 2007 15:07:51 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-acpi@vger.kernel.org

Link input devices for ACPI buttons to their "physical" ACPI device node.
This way the /sys/class/input/*/device links are set up correctly, the
/proc/bus/input/devices "P: Phys=..." lines exist, and related oddness
need not appear.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
I've had this floating around for most of the last year as part of
another patch ... never observed any problems.

--- g26.orig/drivers/acpi/button.c	2007-11-04 11:47:40.000000000 -0800
+++ g26/drivers/acpi/button.c	2007-11-04 11:48:50.000000000 -0800
@@ -395,6 +395,7 @@ static int acpi_button_add(struct acpi_d
 		error = -ENOMEM;
 		goto err_free_button;
 	}
+	input->cdev.dev = &device->dev;
 
 	/*
 	 * Determine the button type (via hid), as fixed-feature buttons
