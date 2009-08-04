From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/3] Generic sysfs support for ACPI ALS and other ALS
 devices
Date: Tue, 4 Aug 2009 08:10:42 -0700
Message-ID: <20090804151042.GA20276@kroah.com>
References: <1249290657.2670.250.camel@rzhang-dt>
 <20090804132129.GH18974@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:34633 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932223AbZHDPPL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 4 Aug 2009 11:15:11 -0400
Content-Disposition: inline
In-Reply-To: <20090804132129.GH18974@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Matthew Garrett <mjg59@srcf.ucam.org>

On Tue, Aug 04, 2009 at 03:21:29PM +0200, Pavel Machek wrote:
> On Mon 2009-08-03 17:10:57, Zhang Rui wrote:
> > Hi, all,
> > 
> > This is the patch set I made to introduce ACPI ALS device driver
> > and a generic sysfs I/F for all the ALS devices, like ACPI ALS,
> > platform ALS, etc.
> > 
> > Patch 01 introduces the ACPI ALS device driver.
> > 
> > Patch 02 introduces ALS sysfs class.
> > 	Two sysfs I/F are created for each ALS device.
> >   /sys/class/als/alsX/illuminance:
> > 	the amount of light incident upon a specified surface area.
> >   /sys/class/als/alsX/mappings:
> > 	ambient light illuminance to display luminance mappings
> > 	that can be used by an OS to calibrate its ambient light policy
> > 	this is what I got on a test box:
> > 	cat /sys/class/als/als0/mappings
> > 	???Illuminance	Adjustment
> > 	          0	       70
> > 	         10	       73
> > 	         80	       85
> > 	        300	      100
> > 	       1000	      150
> 
> There's one value per file for sysfs... You should definitely have the
> header. 

No, no "header", just don't do this, it's not allowed. Again,
one-value-per-sysfs-file is the rule, please do not violate it.

> Plus I'd say Documentation/ file is needed.

It's required for any new sysfs file being added to the kernel.

thanks,

greg k-h
