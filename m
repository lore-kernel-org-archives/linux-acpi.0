From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [ACPI] Re: Vaio doesn't poweroff with 2.4.22
Date: Wed, 17 Sep 2003 16:11:11 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030917141110.GA9125@openzaurus.ucw.cz>
References: <20030917103135.GL1205@elf.ucw.cz> <Pine.GSO.4.21.0309171445150.3677-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0309171445150.3677-100000-Q9iLAqk50tFNk+PO8Cj175kigfUh6rMo@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Development <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > And was that acpi or apm? If it was acpi you saw a little miracle.
> 
> ACPI.
> 
> BTW, I just started to see other weird things that may be related to ACPI, but
> aren't related to Linux (machine powers down 1 second after power up, etc.),
> but now it's fine again (running 2.4.21).

I have seen similar crazy stuff (like hard crash with power LED going
both green *and* red on OS boot (any OS, even w98) after poweron.
Only cure was to unplug it and remove battery. Seeing crash
where 4-sec-power no longer worked was pretty common...

ACPI tends to provoke rather weird hw problems.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...
