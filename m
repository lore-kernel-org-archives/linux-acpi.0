From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [ACPI] Metolious hardware-sensors-using-ACPI specs
Date: Mon, 16 Dec 2002 23:40:57 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021216224057.GE20773@atrey.karlin.mff.cuni.cz>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A5A4@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A5A4-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Is it goign to be implemented in linux-acpi?
> > 
> > I took a look at specs at intel, and it has rather funny legaleese:
> 
> Wow, is that still on a website somewhere?

Yep, as someone already pointed out.

> So as you may know from looking at the spec, Metolious was a spec that
> defined a way for platforms to enumerate various motherboard sensors to the
> OS, for manageability purposes.
> 
> It never took off, except for a couple companies that used the Windows
> driver for other things because they didn't want to write a driver that
> received ACPI device Notify()s.

> The licensing may be weird, but given that there really is no point in
> implementing it on Linux, does that really matter?

Ouch, I started implementing that hour ago... [Never mind, very little
damage done so far].

But... Metolious sounds *needed*; how do you access voltage sensors
without metolious, in a way that can coexist with ACPI thermal
support?

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
