From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: vaio doesn't poweroff with 2.4.22 (fwd)
Date: Wed, 8 Oct 2003 10:13:56 +0200 (MEST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.GSO.4.21.0310081005080.3432-100000@waterleaf.sonytel.be>
References: <1065560111.3366.33.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1065560111.3366.33.camel-D2Zvc0uNKG8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>, Dimitri Torfs <dimitri-osDt5Q4Chk1BDgjK7y7TUQ@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Linux Kernel Development <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On 7 Oct 2003, Len Brown wrote:
> On Tue, 2003-10-07 at 05:18, Geert Uytterhoeven wrote:
> > On 2 Oct 2003, Len Brown wrote:
> > > Is this still a problem w/ the latest build?
> > 
> > Yes (see below).
> > 
> > > Is there a bugzilla entry for it?
> > 
> > No.
> > 
> > Attached you can find my .config, and dmesg output, without and with
> > acpi=force.
> > 
> > Without acpi=force:
> > 
> >   - `halt' doesn't halt (still running)
> > 
> >   - `reboot' doesn't work, and pseudo-halts the machine (black screen, but
> >     power LED still lit)
> 
> The dmesg you attached says this:
> 
> < ACPI disabled because your bios is from 00 and too old
> < You can enable it with acpi=force
> ...
> < ACPI: Interpreter disabled.
> 
> So I'd expect the CONFIG_ACPI !CONFIG_APM kernel to fail to poweroff the
> system.
> 
> > With acpi=force,
> > 
> >   - `halt' works fine
> > 
> >   - `reboot' doesn't work, and pseudo-halts the machine (black screen, but
> >     power LED still lit)
> > In 2.4.21, both `halt' and `reboot' work fine.
> 
> Did you configure with ACPI in 2.4.21?

Yes. It worked fine for halt/reboot up to and including 2.4.21.

> If you configured with APM in 2.4.21, you might consider sticking with
> it rather than switching to ACPI in 2.4.22.

I tried APM in 2.4.23-pre6, and it can halt the machine, but not reboot it.
Now I remember, because APM had problems with reboot or halt, I switched to
ACPI in the first place, when I got the machine 2.5 years ago.

`apm -s' does work now, though (which came as a surprise, since it didn't work
the first time I tried it a long time ago).

> Also, if there is a BIOS update available for this system you should
> consider it.

I went to the website Stan mentioned, and it doesn't seem to list the European
models. Since the Z600 series is called Z505 in US/JP, it may work with one of
the Z505 updates, though. However, I saw updates for W2000/XP only, not for the
BIOS.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
