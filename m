From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: Re: [PM][ACPI] No ACPI interrupts after resume from S1
Date: Sat, 25 Oct 2003 12:59:57 +1300
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1067039997.2114.16.camel@laptop-linux>
References: <20031020141512.GA30157@hell.org.pl>
 <yw1x8yngj7xg.fsf@users.sourceforge.net> <20031020184750.GA26154@hell.org.pl>
 <yw1xekx7afrz.fsf@kth.se> <20031023082534.GD643@openzaurus.ucw.cz>
 <yw1xr813f1a3.fsf@kth.se> <3F98FDDF.1040905@cyberone.com.au>
 <yw1xbrs6652m.fsf@kth.se> <20031024222347.GB728@elf.ucw.cz>
 <yw1xbrs6p85n.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <yw1xbrs6p85n.fsf-UNjuZkX4dYU@public.gmane.org>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru-UNjuZkX4dYU@public.gmane.org>
Cc: Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Some modules cause problems. If I suspend with the intel-agp driver
loaded, for example, the computer reboots when copying the original
kernel back, because the hardware state doesn't match. I can suspend an=
d
resume my i830 based laptop just fine without it. Once the right change=
s
are made to the driver, the module will work, but not yet.

Pavel, excuse me for jumping in here.

Regards,

Nigel

On Sat, 2003-10-25 at 11:45, M=E5ns Rullg=E5rd wrote:
> Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> writes:
>=20
> > Try it completely without modules. I'm not sure how it should work
> > with modules which means it probably does not work at all.
>=20
> Are you saying it doesn't work with any modules?  What about all the
> people who have reported success with suspend-to-disk?  I thought
> everyone used at least some modules.
--=20
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable eve=
nts occur=20
with alarming frequency, order arises from chaos, and no one is given c=
redit.
