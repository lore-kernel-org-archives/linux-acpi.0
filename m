From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: Re: t41, suspend on ram, power consumption
Date: Tue, 17 Jan 2006 21:37:32 +0100
Message-ID: <20060117203732.GC24179@message-id.gmane0305.slipkontur.de>
References: <20060113095634.GA7112@mnementh.homelinux.org> <20060113101638.12055.qmail@web81607.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20060113101638.12055.qmail-ezTNgkwNaeqvuULXzWHTWIglqE1Y4D90QQ4Iyu8u01E@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 13, 2006 at 02:16:38AM -0800, foo_bar_baz_boo-acpi-/E1597aS9LQ@public.gmane.org=
m wrote:
> --- Fr=E9d=E9ric Gobry <frederic.gobry-p8DiymsW2f8@public.gmane.org> wrote:
> > Hi,
> >=20
> > On my Thinkpad T41, I try to use ACPI (Debian unstable, kernel
> > 2.6.15)
> > to suspend the system on RAM. It works quite well (ie, it goes to
> > sleep
> > and resumes properly), but I guess that some hardware parts are not
> > actually stopped properly, as:
> >=20
> >   - the autonomy of the mode is very short (a few hours for a fully
> >     charged battery), whereas I managed to get at least one day of
> >     autonomy when APM used to work.
> >=20
> >   - the laptop gets warm
> >=20
> > Do you have an idea what could cause this behavior, or alternativel=
y
> > how
> > I could start tracking it down myself?

There have been some "thinkpad needs to much energy when suspended" rep=
orts
some time ago. Probably search the archives of the thinkpad list for
solutions. IIRC it was the graphics chip that was not completely shut d=
own.

> > thanks,
> >=20
> > Fr=E9d=E9ric
>=20
> I'll take a stab at this.

And you are writing completely unrelated stuff.
=20
> Please install cpufreqd to control the speed of the CPU. You'll need =
to
> enable some underlying kernel support, something along the lines of:
> CONFIG_CPU_FREQ and friends.

Has nothing to do at all with the power consumption when the system is
suspended.

> Additionally, you probably want to consider the suspend2 kernel patch
> series from http://www.suspend2.net/ to allow for reliably shutting t=
he
> system off without losing state and storing memory into your swap
> partition or a file.

Has nothing to do at all with suspend to ram and the power consumption
when suspended.
=20
> You'll probably want to poke around /proc/acpi and such to find out i=
f
> C1, C2, and C3 are getting entered a reasonable amount of time by the
> processor. This might lead to the possibility that one or multiple of
> these states are underused, which could be caused by anything from a
> kernel bug to some kind of problem with your DSDT that prevents one o=
r
> more of these states from being marked as available.

Has nothing to do at all with the power consumption when the system is
suspended.
=20
> Last thing I can think of, try building a kernel that uses APM (it's
> still available under Power Management as far as I recall) instead of
> ACPI and see how it works for comparison purposes.

He already wrote that the system was suspending for a longer time with
APM.
--=20
Stefan Seyfried

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
