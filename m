From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [BK PATCH] ACPI updates
Date: Fri, 6 Dec 2002 17:50:04 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021206165004.GE7961@atrey.karlin.mff.cuni.cz>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A576@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A576-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: 'Arjan van de Ven' <arjanv-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I (Andy) said:
> > > Well maybe that's what we should do - use the UnitedLinux 
> > ACPI patch (which
> > > iirc is based on fairly recent ACPI code, and presumably minimizes
> > > ACPI-related breakage) and then proceed incrementally from there?
> > > 
> > > Sound OK? Marcelo? UL folks?
> 
> > I guess it will be better if you push acpi patch without killing those
> > backup solutions. Extractign blacklist from UL might be worth it,
> > through.
> 
> Well after communicating with Marcelo it sounds like he'd like to hold off
> taking it in 2.4.21 because IDE changes take priority, and two big changes
> at once is too many for a stable kernel revision.
> 
> Fair enough. I'm just worried that 2.4.22 is a long ways away.
> 
> Maybe one way to address Marcelo's stability concerns and Arjan's "keep
> acpitable.[ch] around" preference is for me to submit a patch that I *know*
> don't affect anything besides ACPI -- i.e. only the changes that have been
> made under drivers/acpi, and then go from there, submitting UL-derived and
> other improvements incrementally after that.

Yes, try that. Its certainly better than no ACPI update at all.
									Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
