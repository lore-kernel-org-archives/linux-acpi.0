From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: Vaio doesn't poweroff with 2.4.22
Date: Wed, 17 Sep 2003 11:21:30 +0200 (MEST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.GSO.4.21.0309171120290.3644-100000@vervain.sonytel.be>
References: <20030916200655.GG602@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030916200655.GG602-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Development <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 16 Sep 2003, Pavel Machek wrote:
> > With 2.4.22, my Sony Vaio PCG-Z600TEK (s/600/505/ in US/JP) shows a regression
> > w.r.t. power management:
> >   - It doesn't poweroff anymore (screen contents are still there after the
> >     powering down message)
> >   - It doesn't reboot anymore (screen goes black, though)
> >   - It accidentally suspended to RAM once while I was actively working on it (I
> >     never managed to get suspend working, except for this `accident'). I didn't
> >     see any messages about this in the kernel log.
> 
> It suspended to RAM... Did it also *resume* correctly?

Yes, since I could continue working without problems (except for lost Ethernet,
solved by ifdown -a/ifup -a).

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
