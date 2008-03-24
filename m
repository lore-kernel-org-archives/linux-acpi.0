From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [2.6.25-rc5-mm1] BUG: spinlock bad magic early during boot
Date: Mon, 24 Mar 2008 17:03:33 +0100
Message-ID: <20080324160333.GD4069@atrey.karlin.mff.cuni.cz>
References: <47DAE55C.3080506@tremplin-utc.net> <1205530551.8167.20.camel@nimitz.home.sr71.net> <47DB013D.3060102@tremplin-utc.net> <1205537395.8167.31.camel@nimitz.home.sr71.net> <47DBC578.7050101@imap.cc> <alpine.LFD.1.00.0803151212180.3020@woody.linux-foundation.org> <47DC26BC.7060502@tremplin-utc.net> <alpine.LFD.1.00.0803151315250.3020@woody.linux-foundation.org> <20080321131737.GC5331@ucw.cz> <1206288004.30471.45.camel@nimitz.home.sr71.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:58450 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754075AbYCXQDe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Mar 2008 12:03:34 -0400
Content-Disposition: inline
In-Reply-To: <1206288004.30471.45.camel@nimitz.home.sr71.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, ?ric Piel <Eric.Piel@tremplin-utc.net>, Tilman Schmidt <tilman@imap.cc>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>, Christoph Hellwig <hch@infradead.org>, Markus Gaugusch <dsdt@gaugusch.at>, linux-acpi@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>, Arjan van de Ven <arjanv@redhat.com>, Eric Biederman <ebiederm@xmission.com>

Hi!
> > > So what's the reason for pushing for this insanely-early workaround in the 
> > > first place, instead of letting user-space do something like
> > > 
> > >       cat my-dsdt-image > /proc/sys/acpi/DSDT
> > > 
> > > or whatever at runtime?
> > 
> > You have interpretted code runing (AML), and you want to replace it
> > with different code?
> > 
> > Akin to changing from one kernel to different during runtime?
> 
> Heh.  That gave me an idea.
> 
> Can we use kexec for this?  Let's say you get as far in boot as the
> initrd and realize that you're running on one of these screwed up
> systems.  Can you stick the new DSDT somewhere known (and safe) in
> memory, and kexec yourself back to the beginning of the kernel boot?
> 
> When you boot up the second time, you have the new, shiny DSDT there
> which is, of course, used instead of the bogus BIOS one.
> 
> It costs you some bootup time, but we're talking about working around
> really busted hardware here.  

Hmmm. I guess we should turn off acpi mode, kexec, turn on acpi mode
with new dsdt.

Turning off acpi is not exactly easy, but specs describe how to do
it...

So yes, this is hard but doable.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
