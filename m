From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [kernel 3.13.0-06058-g2d08cd0] Strange ACPI error messages
Date: Sat, 25 Jan 2014 14:59:09 +0100
Message-ID: <4387759.ffnsEjDaad@vostro.rjw.lan>
References: <CADDKRnDZt9Q4XKyJcO1htMrCJYj6_5yECURBHsJ7O==hup7ZRw@mail.gmail.com> <9739501.rBu7tJQIYj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64650 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752005AbaAYNoz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Jan 2014 08:44:55 -0500
In-Reply-To: <9739501.rBu7tJQIYj@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Saturday, January 25, 2014 02:53:24 PM Rafael J. Wysocki wrote:
> On Saturday, January 25, 2014 11:03:09 AM J=C3=B6rg Otte wrote:
> > Kernel 3.13.0-06058-g2d08cd0 displays following errors on the conso=
le:
> >=20
> > ACPI: \_PR_.CPU4: failed to get CPU APIC ID.
> > ACPI: \_PR_.CPU5: failed to get CPU APIC ID.
> > ACPI: \_PR_.CPU6: failed to get CPU APIC ID.
> > ACPI: \_PR_.CPU7: failed to get CPU APIC ID.
> >=20
> > I don't have CPUs 4..7! Error messages regarding not existing
> > CPUs should not be displayed.
> > kernel 3.13.0-05617-g3aacd62 and before did'nt show this messages.
> >=20
> > This is a regression. I never saw this messages before.
>=20
> Does your system show any other suspicious symptoms or are you worrie=
d about
> those messages only?

Gerry, this is your commit b981513f806d (ACPI / scan: bail out early if=
 failed
to parse APIC ID for CPU).  Apparently, the BIOS has room for 4 CPUs mo=
re than
there actually are in the system.  Maybe we can reduce the log level of=
 those
messages to avoid ringing bells unnecessarily?

Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
