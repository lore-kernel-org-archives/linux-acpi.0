From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: Vaio doesn't poweroff with 2.4.22
Date: Sat, 20 Sep 2003 15:17:37 +0200 (MEST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.GSO.4.21.0309191053140.4488-100000@vervain.sonytel.be>
References: <20030915224136.GA11666@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030915224136.GA11666-NW/W/tFpkLjPJA67Yv3YjA@public.gmane.org>
To: Roger Luethi <rl-7uj+XXdSDtwfv37vnLkPlQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Development <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 16 Sep 2003, Roger Luethi wrote:
> On Mon, 15 Sep 2003 08:43:56 +0200, Geert Uytterhoeven wrote:
> > With 2.4.22, my Sony Vaio PCG-Z600TEK (s/600/505/ in US/JP) shows a regression
> > w.r.t. power management:
> >   - It doesn't poweroff anymore (screen contents are still there after the
> >     powering down message)
> >   - It doesn't reboot anymore (screen goes black, though)
> >   - It accidentally suspended to RAM once while I was actively working on it (I
> >     never managed to get suspend working, except for this `accident'). I didn't
> >     see any messages about this in the kernel log.
> 
> On some machines APIC (sic) support can cause this. Try turning off UP APIC
> if you have it turned on.

If I turn off CONFIG_X86_UP_APIC I get:

| ACPI disabled because your bios is from 00 and too old
| You can enable it with acpi=force
| Sony Vaio laptop detected.

and ACPI is disabled. Halt doesn't work.

If I then pass `acpi=force' to explicitly enable ACPI, `halt' works again and
powers off the machine, but `reboot' causes a black screen with IDE disk spun
down, but no restart.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
