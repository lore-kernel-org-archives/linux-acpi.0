From: Pavel Machek <pavel@ucw.cz>
Subject: Re: broken suspend in .2.6.25-rc3 on T61p (was Re: new regression
	in 2.6.25-rc3: no keyboard/lid acpi events on thinkpad T61p)
Date: Mon, 25 Feb 2008 23:58:20 +0100
Message-ID: <20080225225820.GP2659@elf.ucw.cz>
References: <200802252157.10412.rjw@sisk.pl> <20080225212615.GA2659@elf.ucw.cz> <8f53421d0802251331n31b37db8gb644dc9aa2d553d4@mail.gmail.com> <20080225215049.GD2659@elf.ucw.cz> <8f53421d0802251415g2033ca6bqd4e6ea9e2d93f097@mail.gmail.com> <20080225222023.GK2659@elf.ucw.cz> <8f53421d0802251436vd98a97h5db6b8af3dc39d0@mail.gmail.com> <20080225143932.6b83b65d.akpm@linux-foundation.org> <8f53421d0802251448v3e0db63j3f222f041e587f69@mail.gmail.com> <20080225145347.a61f6c61.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761956AbYBYW6S@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080225145347.a61f6c61.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Michael S. Tsirkin" <m.s.tsirkin@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org, Jeff Garzik <jeff@garzik.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > >  > Maybe it doesn't. Andrew saw the autoresume on -rc[2,3]
> > >
> > >  And earlier - I think 2.6.23 does it as well.
> > 
> > But that one at least resumes fine, does it not?
> 
> Nope, the resume-after-five-seconds and black-screen-after-resume have
> always been there (I've only had the thing a few months).
> 
> I thought the restoring of the screen after resume is handled by the X
> server?  I'm using the nv.o driver.  Perhaps nvidia's driver handles it
> right, dunno.

Aha, so you do not have s2ram from suspend.sf.net installed, do you?

Restoring the screen is done by either

a) kernel/bios (acpi_sleep=..., or better s2ram -f -a X )

b) vbetool

c) X

. s2ram should detect your machine, and automatically set acpi_sleep
and/or perform vbetool magic.

Please try s2ram, there's good chance it will just work.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
