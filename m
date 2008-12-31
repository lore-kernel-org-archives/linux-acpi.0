From: "Christian Hufgard" <christian.hufgard@gmx.de>
Subject: DMI-Infos for Hasee WS210
Date: Wed, 31 Dec 2008 19:01:54 +0100
Message-ID: <20081231180154.267300@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:41097 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752598AbYLaSB4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 31 Dec 2008 13:01:56 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi everyone,

I just baught a Hasee WS210. Even though it has a Celeron DualCore acpi=
 cannot reduce the cpu speed. :(

Here what dmeg tells me:
[    0.000000] ACPI: RSDP 000F8160, 0024 (r2 PTLTD )
[    0.000000] ACPI: XSDT 3F6D453B, 008C (r1  HASEE PARADISE  6040000  =
LTP        0)
[    0.000000] ACPI: FACP 3F6DBC2C, 00F4 (r3 INTEL  CRESTLNE  6040000 A=
LAN        1)
[    0.000000] ACPI: DSDT 3F6D618B, 5A2D (r2 HASEE_ S20_____  6040000 I=
NTL 20050624)
[    0.000000] ACPI: FACS 3F6DEFC0, 0040
[    0.000000] ACPI: APIC 3F6DBD20, 0068 (r1 INTEL  CRESTLNE  6040000 L=
OHR       5A)
[    0.000000] ACPI: HPET 3F6DBD88, 0038 (r1 INTEL  CRESTLNE  6040000 L=
OHR       5A)
[    0.000000] ACPI: MCFG 3F6DBDC0, 003C (r1 INTEL  CRESTLNE  6040000 L=
OHR       5A)
[    0.000000] ACPI: TMOR 3F6DBDFC, 0026 (r1 PTLTD            6040000 P=
TL         3)
[    0.000000] ACPI: APIC 3F6DBE22, 0068 (r1 PTLTD       APIC    604000=
0  LTP        0)
[    0.000000] ACPI: SLIC 3F6DBE8A, 0176 (r1  HASEE PARADISE  6040000  =
LTP        0)
[    0.000000] ACPI: SSDT 3F6D5B3C, 064F (r1 SataRe  SataPri     1000 I=
NTL 20050624)
[    0.000000] ACPI: SSDT 3F6D54AA, 0692 (r1 SataRe  SataSec     1000 I=
NTL 20050624)
[    0.000000] ACPI: SSDT 3F6D53DA, 00D0 (r1 BrtRef  DD01BRT     1000 I=
NTL 20050624)
[    0.000000] ACPI: SSDT 3F6D4C04, 025F (r1  PmRef  Cpu0Tst     3000 I=
NTL 20050624)
[    0.000000] ACPI: SSDT 3F6D4B5E, 00A6 (r1  PmRef  Cpu1Tst     3000 I=
NTL 20050624)
[    0.000000] ACPI: SSDT 3F6D45C7, 0597 (r1  PmRef    CpuPm     3000 I=
NTL 20050624)
[    0.000000] ACPI: BIOS bug: multiple APIC/MADT found, using 0
[    0.000000] ACPI: If "acpi_apic_instance=3D2" works better, notify l=
inux-acpi@vger.kernel.org

[...]

[    0.583384] ACPI: DMI System Vendor: HASEE         =20
[    0.583386] ACPI: DMI Product Name: S20II  =20
[    0.583388] ACPI: DMI Product Version: 1.04
[    0.583390] ACPI: DMI Board Name: S20II  =20
[    0.583392] ACPI: DMI BIOS Vendor: HASEE         =20
[    0.583395] ACPI: DMI BIOS Date: 04/08/2008
[    0.583397] ACPI: Please send DMI info above to linux-acpi@vger.kern=
el.org

Hope you can do anything usefull with this information, I think I will =
send the machine back, since the cpu fan is pretty annoying running eve=
ry few minutes - while the machine isn't doing anything cpu intensive. =
:(

Christian
--=20
Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt? Der kann`s mit all=
en: http://www.gmx.net/de/go/multimessenger
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
