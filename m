From: Ken Corbin <kencx@peak.org>
Subject: Re: Suspend locks up Toshiba Satelite L355-S7915 (no longer)
Date: Sat, 7 Nov 2009 08:09:23 -0800
Message-ID: <200911070809.23947.kencx@peak.org>
References: <200911051928.38825.kencx@peak.org> <4AF39E45.7050803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailscanner1.peak.org ([69.59.192.37]:56723 "EHLO
	mailscanner1.peak.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbZKGQJk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Nov 2009 11:09:40 -0500
In-Reply-To: <4AF39E45.7050803@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

Too obvious.  And rumors of upgrade problems with 9.10 had me leary of jumping 
into it.  But I went ahead with the upgrade, had no significant issues.  And 
sure enough, that fixed my suspend problem.

There are other problems, but they are minor and can be lived with.  Most 
hotkeys do not work.  And the computer doesn't flash the power button when it 
is suspended.  There is a omnibook module that purports do do these 
functions, but it isn't coded to work with the Satelite L355-S7915.  I've 
been looking into fixing that.  But it has occurred to me that that driver is 
largely duplicating standard acpi functions.  And that it might be a better 
use of my time to look into configuring acpi to work with this laptop.  Any 
recommendations?

Thanks again,
-Ken


On Thursday 05 November 2009 19:55:49 Alexey Starikovskiy wrote:
> Hi Ken,
>
> Probably the easiest way for you will be to install/upgrade Ubuntu 9.10,
> which is just out.
> It has latest kernel, so most probably your problem will be fixed.
>
> Regards,
> Alex.
>
> Ken Corbin wrote:
> > Hi Folks,
> >
> > I've installed Ubuntu 9.04 (kernel version 2.6.28-16) on a new laptop. 
> > For the most part everything is working, but suspend to disk and suspend
> > to RAM both lock the box up.  The shutdown looks normal, but then the
> > screen comes back on with low level backlight, and the system won't
> > respond to anything. Holding power button down for 5 seconds forces a
> > poweroff and is the only way to recover.
> >
> > I want to do whatever it takes to get this working.  I'm a pretty good C
> > programmer.  I've never done any kernel hacking but am willing to learn.
> > What I need now is some pointers where I should start looking.
> >
> > Thanks a bunch,
> > -Ken
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html




