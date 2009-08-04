From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/3] Generic sysfs support for ACPI ALS and other ALS
	devices
Date: Tue, 4 Aug 2009 15:21:29 +0200
Message-ID: <20090804132129.GH18974@elf.ucw.cz>
References: <1249290657.2670.250.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42737 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755500AbZHDNVh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Aug 2009 09:21:37 -0400
Content-Disposition: inline
In-Reply-To: <1249290657.2670.250.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Richard Purdie <rpurdie@rpsys.net>, Matthew Garrett <mjg59@srcf.ucam.org>, Greg KH <greg@kroah.com>

On Mon 2009-08-03 17:10:57, Zhang Rui wrote:
> Hi, all,
> 
> This is the patch set I made to introduce ACPI ALS device driver
> and a generic sysfs I/F for all the ALS devices, like ACPI ALS,
> platform ALS, etc.
> 
> Patch 01 introduces the ACPI ALS device driver.
> 
> Patch 02 introduces ALS sysfs class.
> 	Two sysfs I/F are created for each ALS device.
>   /sys/class/als/alsX/illuminance:
> 	the amount of light incident upon a specified surface area.
>   /sys/class/als/alsX/mappings:
> 	ambient light illuminance to display luminance mappings
> 	that can be used by an OS to calibrate its ambient light policy
> 	this is what I got on a test box:
> 	cat /sys/class/als/als0/mappings
> 	???Illuminance	Adjustment
> 	          0	       70
> 	         10	       73
> 	         80	       85
> 	        300	      100
> 	       1000	      150

There's one value per file for sysfs... You should definitely have the
header. 

Is there chance to already return adjusted values, avoiding this
uglyness?

Plus I'd say Documentation/ file is needed.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
