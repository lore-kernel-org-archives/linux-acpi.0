From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto
	<sbasto-n97bsLhj/YhQPh2TJV30h1aTQe2KTcn/@public.gmane.org>
Subject: Re: [ACPI] MS-6368L ACPI IRQ problem still in 2.4.21
Date: 24 Jun 2003 14:16:04 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1056460565.1430.15.camel@darkstar.portugal>
References: <F760B14C9561B941B89469F59BA3A847E96FBE@orsmsx401.jf.intel.com>
	 <20030624063612.GB20235@alf.amelek.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030624063612.GB20235-doiv7TgLjtAqfaPKo25k7GZHpeb/A1Y/@public.gmane.org>
To: Marek Michalkiewicz <marekm-HuSaFJn/uQtscumT1wHf3A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2003-06-24 at 07:36, Marek Michalkiewicz wrote:
> On Mon, Jun 23, 2003 at 03:23:48PM -0700, Grover, Andrew wrote:
> > Is this an SMP machine?
>=20
> No, it's a low cost Socket-370 Micro-ATX board with built-in VGA and
> RTL8139 LAN, VT8601/VT82C686A chipset, Celeron 1200A processor.

I have a laptop presario 7xx that have one VIA mother board=20
with built-in VGA and RTL8139 LAN.

BTW: I have to disable APIC since the begging, because APIC enable,
without acpi cause oops, and with acpi doesn't boot.
my acpi works alone on irq 10 happily.
=20
>=20
> Some of the kernel build options:
>=20
> CONFIG_MPENTIUMIII=3Dy
> CONFIG_SMP=3Dn
> CONFIG_X86_UP_APIC=3Dy
> CONFIG_X86_UP_IOAPIC=3Dy
>=20
> But, there are some SMP-related boot messages:
>=20
> found SMP MP-table at 000f6430
>=20
> Intel MultiProcessor Specification v1.4
>     Virtual Wire compatibility mode.

So maybe you should compile with smp support ,

>=20
> I can provide the complete boot messages if necessary.
>=20
of course we want see the complete dmesg=20


--=20
S=E9rgio Basto
