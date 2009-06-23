From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: why do drivers evaluate _INI?
Date: Tue, 23 Jun 2009 09:58:20 +0930 (CST)
Message-ID: <200906230028.n5N0SK69007374@turbo.physics.adelaide.edu.au>
References: <1245715275.441.13.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:60023 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751983AbZFWAfh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Jun 2009 20:35:37 -0400
In-Reply-To: <1245715275.441.13.camel@localhost> from "Tony Vroon" at Jun 23, 2009 01:01:15 AM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Vroon <tony@linx.net>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Len Brown <lenb@kernel.org>, Eric Piel <eric.piel@tremplin-utc.net>, Pavel Machek <pavel@suse.cz>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

Hi Tony

> On Mon, 2009-06-22 at 17:32 -0600, Bjorn Helgaas wrote:
> > I see the following drivers using _INI:
> >   drivers/platform/x86/fujitsu-laptop.c
> 
> Bjorn, can you send me an experimental patch where you remove it? I can
> regression test that for you on the Lifebook S6420.

As far as I can tell it's just a trivial removal of the relevent section of
the acpi_*_add() functions.  A patch doing this is at the end of this email.
This is completely untested so there may be something subtle I've missed
(for instance, the local "handle" variable is unused now I suspect but this
won't stop compilation or testing).

The patch is against fujitsu-laptop.c from 2.6.27.9 (the kernel source tree
I happen to have quick access to at present) but I don't *think* a lot has
changed since then so it should apply to other recent versions.

Regards
  jonathan

--- fujitsu-laptop.c-orig	2009-06-23 09:51:08.540087000 +0930
+++ fujitsu-laptop.c	2009-06-23 09:53:54.491830386 +0930
@@ -537,15 +537,6 @@ static int acpi_fujitsu_add(struct acpi_
 
 	fujitsu->dev = device;
 
-	if (ACPI_SUCCESS
-	    (acpi_get_handle(device->handle, METHOD_NAME__INI, &handle))) {
-		vdbg_printk(FUJLAPTOP_DBG_INFO, "Invoking _INI\n");
-		if (ACPI_FAILURE
-		    (acpi_evaluate_object
-		     (device->handle, METHOD_NAME__INI, NULL, NULL)))
-			printk(KERN_ERR "_INI Method failed\n");
-	}
-
 	/* do config (detect defaults) */
 	dmi_check_system(fujitsu_dmi_table);
 	use_alt_lcd_levels = use_alt_lcd_levels == 1 ? 1 : 0;
@@ -764,15 +755,6 @@ static int acpi_fujitsu_hotkey_add(struc
 
 	fujitsu_hotkey->dev = device;
 
-	if (ACPI_SUCCESS
-	    (acpi_get_handle(device->handle, METHOD_NAME__INI, &handle))) {
-		vdbg_printk(FUJLAPTOP_DBG_INFO, "Invoking _INI\n");
-		if (ACPI_FAILURE
-		    (acpi_evaluate_object
-		     (device->handle, METHOD_NAME__INI, NULL, NULL)))
-			printk(KERN_ERR "_INI Method failed\n");
-	}
-
 	i = 0;			/* Discard hotkey ringbuffer */
 	while (get_irb() != 0 && (i++) < MAX_HOTKEY_RINGBUFFER_SIZE) ;
 	vdbg_printk(FUJLAPTOP_DBG_INFO, "Discarded %i ringbuffer entries\n", i);
