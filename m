From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [kernel 3.13.0-06058-g2d08cd0] Strange ACPI error messages
Date: Sat, 25 Jan 2014 14:18:17 -0200
Message-ID: <20140125161817.GB25531@khazad-dum.debian.net>
References: <CADDKRnDZt9Q4XKyJcO1htMrCJYj6_5yECURBHsJ7O==hup7ZRw@mail.gmail.com>
 <9739501.rBu7tJQIYj@vostro.rjw.lan>
 <4387759.ffnsEjDaad@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52724 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751781AbaAYQSY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Jan 2014 11:18:24 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 22F3C20B26
	for <linux-acpi@vger.kernel.org>; Sat, 25 Jan 2014 11:18:24 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4387759.ffnsEjDaad@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Sat, 25 Jan 2014, Rafael J. Wysocki wrote:
> On Saturday, January 25, 2014 02:53:24 PM Rafael J. Wysocki wrote:
> > On Saturday, January 25, 2014 11:03:09 AM J=F6rg Otte wrote:
> > > Kernel 3.13.0-06058-g2d08cd0 displays following errors on the con=
sole:
> > >=20
> > > ACPI: \_PR_.CPU4: failed to get CPU APIC ID.
> > > ACPI: \_PR_.CPU5: failed to get CPU APIC ID.
> > > ACPI: \_PR_.CPU6: failed to get CPU APIC ID.
> > > ACPI: \_PR_.CPU7: failed to get CPU APIC ID.
> > >=20
> > > I don't have CPUs 4..7! Error messages regarding not existing
> > > CPUs should not be displayed.
> > > kernel 3.13.0-05617-g3aacd62 and before did'nt show this messages=
=2E
> > >=20
> > > This is a regression. I never saw this messages before.
> >=20
> > Does your system show any other suspicious symptoms or are you worr=
ied about
> > those messages only?
>=20
> Gerry, this is your commit b981513f806d (ACPI / scan: bail out early =
if failed
> to parse APIC ID for CPU).  Apparently, the BIOS has room for 4 CPUs =
more than
> there actually are in the system.  Maybe we can reduce the log level =
of those
> messages to avoid ringing bells unnecessarily?

It is standard practice (at least in SuperMicro boxes, but I've also se=
en it
elsewhere) for the BIOS to have ACPI tables mentioning all cores suppor=
ted
by the biggest core-count CPU topology possible by the motherboard.  Th=
e
cores you don't have are reported as if they were hotpluggable but abse=
nt,
even if they will *never* show up at runtime.  Meh.

So yes, such warnings will get annoying *very* quickly.

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
