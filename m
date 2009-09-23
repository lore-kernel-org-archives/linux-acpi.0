From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] [PATCH 1/2] introduce ALS sysfs class
Date: Wed, 23 Sep 2009 09:18:57 +0200
Message-ID: <20090923071857.GC8565@elf.ucw.cz>
References: <1253590755.15763.21.camel@rzhang-dt> <4AB8C62F.5020605@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40471 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327AbZIWHTW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Sep 2009 03:19:22 -0400
Content-Disposition: inline
In-Reply-To: <4AB8C62F.5020605@cam.ac.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "alan@linux.intel.com" <alan@linux.intel.com>, Len Brown <lenb@kernel.org>, "Cory T. Tusar" <ctusar@videon-central.com>, "Trisal, Kalhan" <kalhan.trisal@intel.com>

On Tue 2009-09-22 13:42:23, Jonathan Cameron wrote:
> Zhang Rui wrote:
> > Hi, Jonathan,
> > 
> > this is the refresh ALS sysfs class driver.
> > I just introduced one sysfs attribute "illuminance", because
> > I didn't catch the exact meaning of the others like "???infrared".
> > So it would be great if you can generate an incremental patch
> > to introduce the other optional attributes needed, and update
> > the documentation as well. :)
> Will do, though may just leave it out of first pass of drivers
> (as it may be controversial and it would be nice to get something
> in place before the arguments begin!)
> 
> All looks nice and clean. The only real question is whether
> we want to standardize naming of devices under sysfs (like hwmon does)
> or allow the individual drivers to do the naming?

Allow the drivers to do the naming. Having useless name like "als0",
with als0/name telling me what the driver is is bad.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
