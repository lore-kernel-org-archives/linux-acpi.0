From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: [ACPI] MS-6368L ACPI IRQ problem still in 2.4.21
Date: 25 Jun 2003 01:28:31 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1056500914.2005.47.camel@darkstar.portugal>
References: <20030623221541.GA8096@alf.amelek.gda.pl>
	<20030623222311.GD25982@parcelfarce.linux.theplanet.co.uk>
	<20030624054612.GA20235@alf.amelek.gda.pl>
	<20030624112630.GB451@parcelfarce.linux.theplanet.co.uk>
	<20030624221809.GA1805@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030624221809.GA1805-doiv7TgLjtAqfaPKo25k7GZHpeb/A1Y/@public.gmane.org>
To: Marek Michalkiewicz <marekm-HuSaFJn/uQtscumT1wHf3A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi(gh)!
So, has we can see in your dmesg, you don't test new acpi,
you are report problems from old acpi.
Well, can you send the /var/log/dmesg for ACPI: Core Subsystem version
200306...
you can try to see if DSDT has problems,without stop your production.

Get last iasl (ACPI CA - Unix Build Environment )in
http://developer.intel.com/technology/iapc/acpi/downloads.htm
 cd compiler;make
after this
cat /proc/acpi/dsdt > acpi_dsdt.dat
=2E/iasl  -d acpi_dsdt.dat
=2E/iasl -tc acpi_dsdt.dsl

and see your dsdt in bios are ok or not.

On Tue, 2003-06-24 at 23:18, Marek Michalkiewicz wrote:
> On Tue, Jun 24, 2003 at 12:26:30PM +0100, Matthew Wilcox wrote:
> > The ACPI code in 2.4.21 is something like 18 months old now.  It's
> > basically unmaintainable.  Fortunately, 2.4.22 should have an ACPI =
update.
>=20

> ACPI: Core Subsystem version [20011018]
			        ^^^^^^^^
> ACPI: Subsystem enabled
> ACPI: System firmware supports S0 S1 S4 S5
> Processor[0]: C0 C1 C2
> ACPI: Power Button (FF) found
> ACPI: Multiple power buttons detected, ignoring fixed-feature
> ACPI: Power Button (CM) found
> ACPI: Sleep Button (CM) found
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: INetU
> Attention Web Developers & Consultants: Become An INetU Hosting Partn=
er.
> Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commissi=
on!
> INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.ph=
p
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel
--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.
