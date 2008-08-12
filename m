From: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.27-rc1: critical thermal shutdown on thinkpad x60
Date: Tue, 12 Aug 2008 13:55:30 +0200
Message-ID: <20080812115530.GB8806@elf.ucw.cz>
References: <20080806090246.GA1572@elf.ucw.cz> <87bq046cht.fsf@basil.nowhere.org> <20080812094135.GA1565@elf.ucw.cz> <20080812105409.GA1366@one.firstfloor.org> <48A16EFC.1050401@redhat.com> <20080812112602.GA2948@elf.ucw.cz> <48A1779B.5020303@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44218 "EHLO
	gprs189-60.eurotel.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbYHLNKl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Aug 2008 09:10:41 -0400
Content-Disposition: inline
In-Reply-To: <48A1779B.5020303@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Milan Broz <mbroz@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <linux-acpi@vger.kernel.org>

On Tue 2008-08-12 13:44:27, Milan Broz wrote:
> Pavel Machek wrote:
> > Hi!
> >>> On Tue, Aug 12, 2008 at 11:41:35AM +0200, Pavel Machek wrote:
> >>>>>> Aug  6 11:00:10 amd kernel: ACPI: Critical trip point
> >>>>>> Aug  6 11:00:10 amd kernel: Critical temperature reached (128 C),
> >>>>>> shutting down.
> >>>>>> Aug  6 11:00:10 amd shutdown[24414]: shutting down for system halt
> >>>>>>
> >>>>>> ...and machine went down at that point :-(.
> >>>>> I hope you can easily reproduce it?
> >>>>>
> >>>>> So it's new in 2.6.27rc1 and wasn't in 2.6.26? Can you please
> >>>> Yes, I'm very sure. It makes machine basically unusable.
> >>> Does this mean you can easily reproduce it?  
> >>> Please do a bisect then. 
> >>>
> >>>> Not that one :-(. Thinkpad does not even have fan device: it is
> >>>> controlled by hardware.
> >> Hi,
> >> I see exactly the same on my x60s, but during upgrade to 2.6.26.2.
> > 
> > Are you sure?
> 
> yes. maybe some userspace tool controlling frequency is involved, no idea yet.
> But it is 2.6.26 tree for sure.

So it definitely is in 2.6.26.2, and it definitely is in 2.6.26?

...because I'm using 2.6.26, and see nothing..

> >> Now, the CPU cores remains on 1.67GHz and fan is unable to cool them properly
> >> under heavy load (even if I set "level disengaged" through thinkpad fan control,
> >> temperature sensor shows after a while 128 C (probably not real temp,
> >> I expect some critical flag => and it properly switch off the
> >> system...)
> > 
> > How do you control fans? I could not get anything but -EINVAL from IBM
> > ACPI driver :-(.
> 
> you need add fan_control=1 to thinkpad_acpi module
> 
> http://www.thinkwiki.org/wiki/How_to_control_fan_speed
> http://www.thinkwiki.org/wiki/ACPI_fan_control_script

Thanks for pointers!

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
