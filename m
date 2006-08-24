From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] misc,acpi,backlight: MSI S270 Laptop support, third try
Date: Thu, 24 Aug 2006 07:52:26 +0200
Message-ID: <20060824055226.GB1952@elf.ucw.cz>
References: <20060820225209.GA5453@curacao>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26759 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030321AbWHXFwk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Aug 2006 01:52:40 -0400
Content-Disposition: inline
In-Reply-To: <20060820225209.GA5453@curacao>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: len.brown@intel.com, rubini@ipvvis.unipv.it, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi!

> Please merge! 
> 
> I wonder who's the right one to ask for merging, since this driver
> sits in drivers/misc/. According to MAINTAINERS Alessandro Rubini
> maintains that directory. However it's somewhat based on the ACPI EC
> access stuff I posted earlier, hence the APCI tree might be another
> path to get this merged. Len, Alessandro, which one of you shall I
> bug to get this driver commited?

I guess Andrew is right person to get this in, but please follow
SubmittingPatches w.r.t. changelog.

> +/* $Id: msi-laptop.c 115 2006-08-20 20:02:54Z lennart $ */

Can you kill this? It only causes problems...

> +/*
> + * msi-laptop.c - MSI S270 laptop support. This laptop is sold under
> + * various brands, including "Cytron/TCM/Medion/Tchibo MD96100".
> + *
> + * This driver exports a few files in /sys/devices/platform/msi-laptop-pf/:
> + *
> + *   lcd_level - Screen brightness: contains a single integer in the
> + *   range 0..8. (rw)
> + * 
> + *   auto_brightness - Enable automatic brightness control: contains
> + *   either 0 or 1. If set to 1 the hardware adjusts the screen
> + *   brightness automatically when the power cord is
> + *   plugged/unplugged. (rw)
> + *
> + *   wlan - WLAN subsystem enabled: contains either 0 or 1. (ro)
> + *
> + *   bluetooth - Bluetooth subsystem enabled: contains either 0 or 1
> + *   Please note that this file is constantly 0 if no Bluetooth
> + *   hardware is available. (ro)

User level documentation should go to Documentation/ somewhere. Not
sure if we have centralized place for /sys docs?

> +/*** Hardware access ***/

Can you remove extra ** s? They hurt my eyes.

> +static int set_lcd_level(int level) {

Indentation (you have this one detail consistently wrong).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
