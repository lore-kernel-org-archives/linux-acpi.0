From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [ACPI] Re: [PATCH] s4bios for 2.5.59 + apci-20030123
Date: Thu, 6 Feb 2003 16:37:57 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030206153757.GB19350@atrey.karlin.mff.cuni.cz>
References: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com> <20030204221003.GA250@elf.ucw.cz> <1044477704.1648.19.camel@laptop-linux.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1044477704.1648.19.camel-udXHSmD1qAz9bBlWBkG5g4WQyAnV0byH@public.gmane.org>
To: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Some people apparently want slower suspend/resume but have all caches
> > intact when resumed. Thats not easy for swsusp but they can have that
> > with S4bios. And S4bios is usefull for testing device support; it
> > seems to behave slightly differently to S3 meaning better testing.
> 
> Whether its slower depends on the hardware; on my 128MB Celeron 933
> laptop (17MB/s HDD), I can write an image of about 120MB, reboot and get
> back up and running in around a minute and a half. That's about the same
> as far as I remember, but has (as you say) the advantage of not still
> having to get things swapped back in.
> 
> > If you already have hibernation partition from factory, which you are
> > using anyway for w98, S4bios is easier to use and more foolproof
> > (i.e. you can't boot into wrong kernel which does not resume but does
> > fsck instead).
> 
> It doesn't really matter what kernel is loaded when we start a resume
> anyway, does it? Could they not be different versions because one is
> going to replace the other anyway?

No, no. It has to be exactly the same kernel, otherwise you get a nice
crash (if you are lucky) and ugly data corruption (when you are not);
there's check to prevent that and panic, however.

That's why I call S4bios more foolproof.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
