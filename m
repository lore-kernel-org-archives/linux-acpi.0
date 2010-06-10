From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH 1/2] suspend: Move NVS save/restore code to
 generic suspend functionality
Date: Thu, 10 Jun 2010 15:58:16 +0200
Message-ID: <20100610135816.GG4514@ucw.cz>
References: <1275416390.3778.7.camel@maxim-laptop>
 <201006012331.59747.rjw@sisk.pl>
 <1275429125.5573.7.camel@maxim-laptop>
 <201006020040.22429.rjw@sisk.pl>
 <1275432410.6733.4.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ksp.mff.cuni.cz ([195.113.26.206]:44433 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759144Ab0FJN6Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Jun 2010 09:58:25 -0400
Content-Disposition: inline
In-Reply-To: <1275432410.6733.4.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>

Hi!

> > > To be honest, I just want to get some feedback on this.
> > > This was major issue that kept me from using otherwise prefect suspend
> > > to ram.
> > 
> > I think this is a change we should try, but there is a chance it will break
> > some systems.
> I doubt that. BIOSes are tested against windows, and since it has this
> behavior, all systems this patch could break wouldn't work in windows
> ether.
> 
> I was doing all kinds of attempts to fix this bug, and finally I found
> the cause for it.

Well... should we only do it in 'platform' hibernation mode? There are
machines that predate windows/acpi and still should hibernate.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
