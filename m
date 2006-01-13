From: <foo_bar_baz_boo-acpi-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Re: t41, suspend on ram, power consumption
Date: Fri, 13 Jan 2006 02:16:38 -0800 (PST)
Message-ID: <20060113101638.12055.qmail@web81607.mail.mud.yahoo.com>
References: <20060113095634.GA7112@mnementh.homelinux.org>
Reply-To: foo_bar_baz_boo-acpi-/E1597aS9LQAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20060113095634.GA7112-zdned+2MO19t+tyI2NedBz+iFHGzDt/a@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?ISO-8859-1?Q?=20=22Fr=E9d=E9ric=22?= Gobry <frederic.gobry-p8DiymsW2f8@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--- Fr=E9d=E9ric Gobry <frederic.gobry-p8DiymsW2f8@public.gmane.org> wrote:
> Hi,
>=20
> On my Thinkpad T41, I try to use ACPI (Debian unstable, kernel
> 2.6.15)
> to suspend the system on RAM. It works quite well (ie, it goes to
> sleep
> and resumes properly), but I guess that some hardware parts are not
> actually stopped properly, as:
>=20
>   - the autonomy of the mode is very short (a few hours for a fully
>     charged battery), whereas I managed to get at least one day of
>     autonomy when APM used to work.
>=20
>   - the laptop gets warm
>=20
> Do you have an idea what could cause this behavior, or alternatively
> how
> I could start tracking it down myself?
>=20
> thanks,
>=20
> Fr=E9d=E9ric

I'll take a stab at this.

Please install cpufreqd to control the speed of the CPU. You'll need to
enable some underlying kernel support, something along the lines of:
CONFIG_CPU_FREQ and friends.

Additionally, you probably want to consider the suspend2 kernel patch
series from http://www.suspend2.net/ to allow for reliably shutting the
system off without losing state and storing memory into your swap
partition or a file.

You'll probably want to poke around /proc/acpi and such to find out if
C1, C2, and C3 are getting entered a reasonable amount of time by the
processor. This might lead to the possibility that one or multiple of
these states are underused, which could be caused by anything from a
kernel bug to some kind of problem with your DSDT that prevents one or
more of these states from being marked as available.

Last thing I can think of, try building a kernel that uses APM (it's
still available under Power Management as far as I recall) instead of
ACPI and see how it works for comparison purposes.

Good Luck!
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
