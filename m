From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH V6 1/2] introduce ALS sysfs class
Date: Wed, 2 Sep 2009 23:14:15 +0200
Message-ID: <20090902211414.GA2789@elf.ucw.cz>
References: <1251789947.3483.215.camel@rzhang-dt> <200909012047.00606.rjw@sisk.pl> <20090901134144.GA2028@ucw.cz> <200909022312.58494.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:44768 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752248AbZIBVOe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Sep 2009 17:14:34 -0400
Content-Disposition: inline
In-Reply-To: <200909022312.58494.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Greg KH <greg@kroah.com>

On Wed 2009-09-02 23:12:58, Rafael J. Wysocki wrote:
> On Tuesday 01 September 2009, Pavel Machek wrote:
> > 
> > > > > IMO, 0 and -1 are not errors. they just suggest that the Ambient Light
> > > > > illuminance is beyond the device support range, while the device is
> > > > > still working normally.
> > > > > what about exporting these values (0 and -1) to user space directly?
> > > > 
> > > > Returning 0 for "below" range and 99999999 for "above" range would be
> > > > nice, yes. 
> > > 
> > > Why not 0 and "all ones" or 0 and -1.
> > > 
> > > Is there anything wrong with -1 in particular?
> > 
> > Normal people expect -1 to be less than 123, and output is in ascii. If
> > you make it ((unsigned) ~0) I guess that becomes acceptable.
> 
> Well, "-1" is a perfectly valid alphanumerical representation of an int.
> I don't really see the problem with the "-", unless we're talking about some
> broken user space, that is.

No. But if you see illumination value of -1 lumen, do you really
expect a *lot* of light?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
