From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: why do drivers evaluate _INI?
Date: Mon, 22 Jun 2009 17:32:35 -0600
Message-ID: <200906221732.35993.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:40802 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbZFVXcg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2009 19:32:36 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Eric Piel <eric.piel@tremplin-utc.net>, Pavel Machek <pavel@suse.cz>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, Mattia Dongili <malattia@linux.it>, linux-acpi@vger.kernel.org

[Sorry for the duplicate; I meant to CC: linux-acpi, so I added it here.]

Why do we have ACPI device drivers evaluating _INI?  That seems
like something that should be done by Linux/ACPI, not by the driver.

I see the following drivers using _INI:
  drivers/hwmon/hp_accel.c
  drivers/platform/x86/fujitsu-laptop.c
  drivers/platform/x86/sony-laptop.c

I looked at the git logs where the _INI usage was introduced in
these drivers, but none gives enough information for me to understand
why.

If running _INI in the driver makes a difference, I think it's
really telling us about a problem in Linux/ACPI, and we should
fix that problem rather than sprinkling _INI evaluation around
in drivers.

I do see _INI evaluation in this path:

    acpi_init
        acpi_bus_init
            acpi_initialize_objects(ACPI_FULL_INITIALIZATION)
                acpi_ns_initialize_devices
                    acpi_ns_walk_namespace .. acpi_ns_init_one_device

The spec (section 6.5.1) says OSPM should run _INI when a
description table is loaded.  I assume the above path does
this for the DSDT, at least, but I'm not smart enough about
the ACPI CA to know whether we also handle SSDTs and dynamic
LoadTables correctly.

Bjorn

P.S.  I'm about to go on vacation for a couple weeks, so I'll
be slow in responding to any discussion here.
