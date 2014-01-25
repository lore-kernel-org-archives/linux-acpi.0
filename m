From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [kernel 3.13.0-06058-g2d08cd0] Strange ACPI error messages
Date: Sat, 25 Jan 2014 14:53:24 +0100
Message-ID: <9739501.rBu7tJQIYj@vostro.rjw.lan>
References: <CADDKRnDZt9Q4XKyJcO1htMrCJYj6_5yECURBHsJ7O==hup7ZRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADDKRnDZt9Q4XKyJcO1htMrCJYj6_5yECURBHsJ7O==hup7ZRw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Saturday, January 25, 2014 11:03:09 AM J=C3=B6rg Otte wrote:
> Kernel 3.13.0-06058-g2d08cd0 displays following errors on the console=
:
>=20
> ACPI: \_PR_.CPU4: failed to get CPU APIC ID.
> ACPI: \_PR_.CPU5: failed to get CPU APIC ID.
> ACPI: \_PR_.CPU6: failed to get CPU APIC ID.
> ACPI: \_PR_.CPU7: failed to get CPU APIC ID.
>=20
> I don't have CPUs 4..7! Error messages regarding not existing
> CPUs should not be displayed.
> kernel 3.13.0-05617-g3aacd62 and before did'nt show this messages.
>=20
> This is a regression. I never saw this messages before.

Does your system show any other suspicious symptoms or are you worried =
about
those messages only?

Rafael
