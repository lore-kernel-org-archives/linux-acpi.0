From: =?iso-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.com>
Subject: [RFC] halt to s4 for WOL
Date: Wed, 13 Jan 2016 17:40:53 +0100
Message-ID: <513D96FD-1D42-4E03-A308-FAB9A8782632@exactcode.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx.exactcode.de ([144.76.154.42]:44834 "EHLO mx.exactcode.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753634AbcAMRBT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jan 2016 12:01:19 -0500
Received: from ip5b403229.dynamic.kabel-deutschland.de ([91.64.50.41] helo=exactcode.com)
	by mx.exactcode.de with esmtp (Exim 4.82)
	(envelope-from <rene@exactcode.com>)
	id 1aJOTj-0004hH-8M
	for linux-acpi@vger.kernel.org; Wed, 13 Jan 2016 16:40:59 +0000
Received: from retina ([192.168.2.174])
	by exactcode.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.54)
	id 1aJOTw-0002Eq-K6
	for linux-acpi@vger.kernel.org; Wed, 13 Jan 2016 16:41:18 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

for some years our old Mac Pro and newer Mac mini used for unit testing and VMs
annoyed me in that we could never get Wake-On-Lan working on them at all.

Some people found some pci config bit poking for some older Mac mini that did not
work on our newer Mac mini, nor on our older Mac Pro.

	http://blog.dhampir.no/content/wake-on-lan-on-a-n-intel-mac-mini-with-linux

While we where setting up some new things we finally wanted this solved, and I found
a clever workaround by halting the machine to S4 instead of S5.

While of course this patch can not be applied as it. I just wanted to ask for feedback -
maybe a kernel or sysfs interface can be added to have a halt=S4 or whatever
switch as this might be useful to convince other machines to supply power to the NIC,
too.

--- linux-4.3/drivers/acpi/sleep.c.orig	2015-12-29 15:27:21.100959963 +0000
+++ linux-4.3/drivers/acpi/sleep.c	2015-12-29 15:28:36.828960630 +0000
@@ -811,7 +811,7 @@
 static void acpi_power_off_prepare(void)
 {
 	/* Prepare to power off the system */
-	acpi_sleep_prepare(ACPI_STATE_S5);
+	acpi_sleep_prepare(ACPI_STATE_S4);
 	acpi_disable_all_gpes();
 	acpi_os_wait_events_complete();
 }
@@ -821,7 +821,7 @@
 	/* acpi_sleep_prepare(ACPI_STATE_S5) should have already been called */
 	printk(KERN_DEBUG "%s called\n", __func__);
 	local_irq_disable();
-	acpi_enter_sleep_state(ACPI_STATE_S5);
+	acpi_enter_sleep_state(ACPI_STATE_S4);
 }
 
 int __init acpi_sleep_init(void)

-- 
 ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
 http://exactcode.com | http://exactscan.com | http://ocrkit.com | http://t2-project.org | http://rene.rebe.de

