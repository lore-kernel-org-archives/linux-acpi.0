From: =?iso-8859-1?Q?Fr=E9d=E9ric?= Gobry <frederic.gobry-p8DiymsW2f8@public.gmane.org>
Subject: Re: t41, suspend on ram, power consumption
Date: Fri, 13 Jan 2006 14:30:23 +0100
Message-ID: <20060113133023.GA6527@mnementh.homelinux.org>
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

(sorry for answered with more questions, I really wish to understand ho=
w
all that stuff operates together)

> Please install cpufreqd to control the speed of the CPU. You'll need =
to
> enable some underlying kernel support, something along the lines of:
> CONFIG_CPU_FREQ and friends.

I use powernowd: would it make a difference?

> Additionally, you probably want to consider the suspend2 kernel patch
> series from http://www.suspend2.net/ to allow for reliably shutting t=
he
> system off without losing state and storing memory into your swap
> partition or a file.

Does suspend2 change the behavior of the system for suspend to mem, or
is it only for suspend to disk? I hesitated to use these patches, as th=
e
debian kernel is far from a vanilla kernel, and I don't think they
packaged a version of it.

> You'll probably want to poke around /proc/acpi and such to find out i=
f
> C1, C2, and C3 are getting entered a reasonable amount of time by the
> processor. This might lead to the possibility that one or multiple of
> these states are underused, which could be caused by anything from a
> kernel bug to some kind of problem with your DSDT that prevents one o=
r
> more of these states from being marked as available.

The system actually goes in sleep mode, I don't know which part of the
hardware does not. By comparing the list of PCI devices being disabled
(in the log I sent in the previous message) with the output of lspci, i=
t
seems that the graphical card is not disabled. But I don't know if some
other part of the code does the job, neither do I know what this
'disabled' state actually means (maybe only regarding interrupts?)

> Last thing I can think of, try building a kernel that uses APM (it's
> still available under Power Management as far as I recall) instead of
> ACPI and see how it works for comparison purposes.

I was hoping I could start using debian's packaged kernels again :-) In
fact, APM worked well in 2.6.8, but from that version upward, it really
was a source of random crashes when the system was going up again. I wa=
s
not using then hibernate script at that time. Do you think it would hav=
e
improved the experience?

=46r=E9d=E9ric

--=20
=46r=E9d=E9ric Gobry    Infoscience
                  SISB / EPFL
                  Tel: +41216932288
http://people.epfl.ch/frederic.gobry

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
