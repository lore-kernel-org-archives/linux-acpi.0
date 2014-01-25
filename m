From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [kernel 3.13.0-06058-g2d08cd0] Strange ACPI error messages
Date: Sat, 25 Jan 2014 23:31:43 +0100
Message-ID: <2010872.ETICEKhYmO@vostro.rjw.lan>
References: <CADDKRnDZt9Q4XKyJcO1htMrCJYj6_5yECURBHsJ7O==hup7ZRw@mail.gmail.com> <4387759.ffnsEjDaad@vostro.rjw.lan> <20140125161817.GB25531@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54406 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752355AbaAYWR2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Jan 2014 17:17:28 -0500
In-Reply-To: <20140125161817.GB25531@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Jiang Liu <jiang.liu@linux.intel.com>

On Saturday, January 25, 2014 02:18:17 PM Henrique de Moraes Holschuh w=
rote:
> On Sat, 25 Jan 2014, Rafael J. Wysocki wrote:
> > On Saturday, January 25, 2014 02:53:24 PM Rafael J. Wysocki wrote:
> > > On Saturday, January 25, 2014 11:03:09 AM J=C3=B6rg Otte wrote:
> > > > Kernel 3.13.0-06058-g2d08cd0 displays following errors on the c=
onsole:
> > > >=20
> > > > ACPI: \_PR_.CPU4: failed to get CPU APIC ID.
> > > > ACPI: \_PR_.CPU5: failed to get CPU APIC ID.
> > > > ACPI: \_PR_.CPU6: failed to get CPU APIC ID.
> > > > ACPI: \_PR_.CPU7: failed to get CPU APIC ID.
> > > >=20
> > > > I don't have CPUs 4..7! Error messages regarding not existing
> > > > CPUs should not be displayed.
> > > > kernel 3.13.0-05617-g3aacd62 and before did'nt show this messag=
es.
> > > >=20
> > > > This is a regression. I never saw this messages before.
> > >=20
> > > Does your system show any other suspicious symptoms or are you wo=
rried about
> > > those messages only?
> >=20
> > Gerry, this is your commit b981513f806d (ACPI / scan: bail out earl=
y if failed
> > to parse APIC ID for CPU).  Apparently, the BIOS has room for 4 CPU=
s more than
> > there actually are in the system.  Maybe we can reduce the log leve=
l of those
> > messages to avoid ringing bells unnecessarily?
>=20
> It is standard practice (at least in SuperMicro boxes, but I've also =
seen it
> elsewhere) for the BIOS to have ACPI tables mentioning all cores supp=
orted
> by the biggest core-count CPU topology possible by the motherboard.  =
The
> cores you don't have are reported as if they were hotpluggable but ab=
sent,
> even if they will *never* show up at runtime.  Meh.
>=20
> So yes, such warnings will get annoying *very* quickly.

Well, what about using acpi_handle_debug() in there, then?

--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
