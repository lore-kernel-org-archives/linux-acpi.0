From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Fri, 24 Oct 2003 15:52:21 +0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8401720B63@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, M?ns Rullg?rd <mru-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Would you please try patch at http://bugme.osdl.org/show_bug.cgi?id=1409
Thanks,
Luming

-----Original Message-----
From: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Pavel Machek
Sent: 2003?10?23? 16:24
To: M?ns Rullg?rd; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; linux-kernel@vger.kernel.org
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1


Hi!


> > working.  Normally, they will generate an ACPI event, that is
> > processed by acpid etc.  After a suspend, each button will work once.
> > If I then close and open the lid, they will work one more time, and so
> > on.  Any way I can help?
> 
> Please specify the type of suspend. The situation I described only occurs
> for S1 (or, echo -n standby, more specifically), and only in certain kernel
> versions.

Find out which versions break it, pay special atetion to
hwsleep.c.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
