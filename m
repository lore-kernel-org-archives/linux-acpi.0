From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V6 1/2] introduce ALS sysfs class
Date: Tue, 1 Sep 2009 15:41:44 +0200
Message-ID: <20090901134144.GA2028@ucw.cz>
References: <1251789947.3483.215.camel@rzhang-dt> <1251793844.3483.228.camel@rzhang-dt> <20090901084306.GD9942@elf.ucw.cz> <200909012047.00606.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50187 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbZIAUJS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Sep 2009 16:09:18 -0400
Content-Disposition: inline
In-Reply-To: <200909012047.00606.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>


> > > IMO, 0 and -1 are not errors. they just suggest that the Ambient Light
> > > illuminance is beyond the device support range, while the device is
> > > still working normally.
> > > what about exporting these values (0 and -1) to user space directly?
> > 
> > Returning 0 for "below" range and 99999999 for "above" range would be
> > nice, yes. 
> 
> Why not 0 and "all ones" or 0 and -1.
> 
> Is there anything wrong with -1 in particular?

Normal people expect -1 to be less than 123, and output is in ascii. If
you make it ((unsigned) ~0) I guess that becomes acceptable.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
