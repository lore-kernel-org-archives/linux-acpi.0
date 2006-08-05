From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Sony ACPI extras mainline inclusion
Date: Sun, 6 Aug 2006 01:23:24 +0200
Message-ID: <20060805232324.GB16196@elf.ucw.cz>
References: <44CB288A.1010702@gmail.com> <20060802100314.GF7601@ucw.cz> <44D47661.8080000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2225 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751447AbWHEXXk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 5 Aug 2006 19:23:40 -0400
Content-Disposition: inline
In-Reply-To: <44D47661.8080000@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alessandro Guido <alessandro.guido.box@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Hi!

> >>I own a Sony VAIO laptop that uses ACPI for setting 
> >>screen brightness
> >>through the "2.6-sony_acpi4.patch" patch that has been 
> >>living in -mm for a while.
> >>I'd like this patch to be merged in mainline, so that I 
> >>won't be forced anymore to patch
> >>the kernel by hand or to use the -mm patchset.
> >>Is there something that prevents this to happen?
> >
> >Wrong interface?
> >
> >Convert it to use /sys/class/backlight sysfs interface...
> 
> Thank you for repling!
> 
> I found a patch that does it in the mailing list archives,
> although I've not tested if it can be still applied correctly:
> 
> http://marc.theaimsgroup.com/?l=linux-acpi&m=113950408508944&w=2

Yep, that looks like a good starting point. Plus "old" backlight
interface should be removed so that we don't have to support two of
them for 2+ years.
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
