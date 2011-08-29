From: "Joey Lee" <jlee@suse.com>
Subject: Re: [PATCH 2/2] ACPI: Implement overriding of arbitrary ACPI
 tables via initrd
Date: Mon, 29 Aug 2011 02:39:57 -0600
Message-ID: <4E5BDCFD0200002300030F1C@novprvlin0050.provo.novell.com>
References: <1314179290-31526-1-git-send-email-trenn@suse.de>
 <1314179290-31526-3-git-send-email-trenn@suse.de>
 <4E5BDB090200002300030F12@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from novprvlin0050.provo.novell.com ([137.65.248.33]:42982 "EHLO
	novprvlin0050.provo.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751176Ab1H2IkB (ORCPT
	<rfc822;groupwise-linux-acpi@vger.kernel.org:6:1>);
	Mon, 29 Aug 2011 04:40:01 -0400
In-Reply-To: <4E5BDB090200002300030F12@novprvlin0050.provo.novell.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: devel@acpica.org, jnelson-suse@jamponi.net, lenb@kernel.org, x86@kernel.org, eric.piel@tremplin-utc.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com

=E6=96=BC =E4=B8=80=EF=BC=8C2011-08-29 =E6=96=BC 02:31 -0600=EF=BC=8CJo=
ey Lee =E6=8F=90=E5=88=B0=EF=BC=9A
> =E6=96=BC =E4=B8=89=EF=BC=8C2011-08-24 =E6=96=BC 11:48 +0200=EF=BC=8C=
Thomas Renninger =E6=8F=90=E5=88=B0=EF=BC=9A
> > Details can be found in:
> > Documentation/acpi/initrd_table_override.txt
> >=20
> > Additional dmesg output of a booted system with
> > FACP (FADT), DSDT and SSDT (the 9th dynamically loaded one)
> > tables overridden (with ### marked comments):
> >=20
> > ### ACPI tables found glued to initrd
> > DSDT ACPI table found in initrd - size: 16234
> > FACP ACPI table found in initrd - size: 116
> > SSDT ACPI table found in initrd - size: 334
> > ### Re-printed e820 map via e820_update() with additionally created
> > ### ACPI data section at 0xcff55000 where the ACPI tables passed vi=
a
> > ### initrd where copied to
> > modified physical RAM map:
> > ...
> >   ### New ACPI data section:
> >   modified: 00000000cff55000 - 00000000cff5912c (ACPI data)
> >   ### BIOS e820 provided ACPI data section:
> >   modified: 00000000cff60000 - 00000000cff69000 (ACPI data)
> > ...
> > ### Total size of all ACPI tables glued to initrd
> > ### The address is initrd_start which gets updated to
> > ### initrd_start =3D initrd_start + "size of all ACPI tables glued =
to initrd"
> > Found acpi tables of size: 16684 at 0xffff8800374c4000
> >=20
> > Disabling lock debugging due to kernel taint
> > ### initrd provided FACP and DSDT tables are used instead of BIOS p=
rovided ones
> > ACPI: FACP @ 0x00000000cff68dd8 Phys table override, replaced with:
> > ACPI: FACP 00000000cff58f6a 00074 (v01 INTEL  TUMWATER 06040000 PTL=
  00000003)
> > ACPI: DSDT @ 0x00000000cff649d4 Phys table override, replaced with:
> > ACPI: DSDT 00000000cff55000 04404 (v01  Intel BLAKFORD 06040000 MSF=
T 0100000E)
> > ...
> > ### Much later, the 9th (/sys/firmware/acpi/table/dynamic/SSDT9) dy=
namically
> > ### loaded ACPI table matches and gets overridden:
> > ACPI: SSDT @ 0x00000000cff64824 Phys table override, replaced with:
> > ACPI: SSDT 00000000cff58fde 0014E (v01  PmRef  Cpu7Ist 00003000 INT=
L 20110316)
> > ACPI: Dynamic OEM Table Load:
> > ACPI: SSDT           (null) 0014E (v01  PmRef  Cpu7Ist 00003000 INT=
L 20110316)
> > ...
> >=20
> > If the initrd does not start with a valid ACPI table signature or t=
he ACPI
> > table's checksum is wrong, there is no functional change.
> >=20
> > Signed-off-by: Thomas Renninger <trenn@suse.de>
> > CC: linux-acpi@vger.kernel.org
> > CC: lenb@kernel.org
> > CC: linux-kernel@vger.kernel.org
> > CC: x86@kernel.org
> > ---
>=20
> This patch works fine to me on Acer TravelMate 8572.
> I added a debug message to _BCM method in DSDT then override it in
> initrd by follow initrd_table_override.txt.
>=20
> The attached is my dmesg log.
>=20
> > +3) How does it work
> > +-------------------
> > +
> > +# Extract the machine's ACPI tables:
> > +acpidump >acpidump
> > +acpixtract -a acpidump
> > +# Disassemble, modify and recompile them:
> > +iasl -d *.dat
> > +# For example add this statement into a _PRT (PCI Routing Table) f=
unction
> > +# of the DSDT:
> > +Store("Hello World", debug)
> > +iasl -sa *.dsl
> > +# glue them together with the initrd. ACPI tables go first, origin=
al initrd
> > +# goes on top:
> > +cat TBL1.dat >>instrumented_initrd
> > +cat TBL2.dat >>instrumented_initrd
> > +cat TBL3.dat >>instrumented_initrd
>=20
> I suggest use TBL1.aml to replace TBL1.dat in initrd_table_override.t=
xt,
> because iasl -sa default generate out *.aml file but not *.dat file, =
my
> iasl version is Intel 20110112-64 [Feb 27 2011].
> That will be more clear for the first time user to understand need ca=
t
> *.aml file.
>=20
> Tested-by: Lee, Chun-Yi <jlee@suse.com>
>=20
>=20
> Thank's
> Joey Lee
>=20

I applied the 2 patches on linux v3.0 kernel but not on the latest
linux-acpi-2.6 branch.

I will also test it on linux-acpi-2.6.


Thank's
Joey Lee


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
