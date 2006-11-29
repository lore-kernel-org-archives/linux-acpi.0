From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: acpi nic card flapping
Date: Wed, 29 Nov 2006 16:14:00 +0900
Message-ID: <456D3338.6070709@jp.fujitsu.com>
References: <000f01c71064$36a4ea20$6602a8c0@yonglaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:15294 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S935356AbWK2HTO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Nov 2006 02:19:14 -0500
In-Reply-To: <000f01c71064$36a4ea20$6602a8c0@yonglaptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yong Lee <yonglee@telus.net>
Cc: linux-acpi@vger.kernel.org

Hi Yong Lee,

> shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=3D0x5

This message means OSHP method is not found under _SB.PCI0.PBLO. This
message itself is harmless, I think.

But, IIRC, old shpchp driver had a problem that loading shpchp driver
may cause a master-abort on some ongoing PCI cards. The root cause is
old shpchp driver writes 0xFFFFFFFF to BARs of some ongoing PCI cards
to know the size of resources assigned to the cards at modprobe time.

I don't know this is related to your problem. But I hope this info is
helpful for you.

Thanks,
Kenji Kaneshige


Yong Lee wrote:
> Hi all,
>=20
> I=92m hoping that someone out there can lend me a hand with a problem=
 that we
> were seeing.  I=92m not very familiar with the acpi tool so please be=
ar with
> me.
>=20
> We had an outage where we could not ssh into our web server and we ha=
d to do
> a reboot from our console to get things running again.  It looks like=
 an
> acpi problem and I=92m trying to figure out what was going on.  Was A=
CPI going
> crazy or was it trying to report a problem condition that we were not=
 aware
> of.
>=20
> What we saw in the dmesg log was this :
>=20
> shpchp: Address64 -------- Resource unparsed
> shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=3D0x5
> shpchp: acpi_shpchprm:   Slot sun(0) at s:b:d:f=3D0x00:04:1f:00
> shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=3D0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=3D0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=3D0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=3D0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=3D0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=3D0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=3D0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=3D0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=3D0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=3D0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=3D0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=3D0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=3D0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=3D0x5
> shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=3D0x5
> shpchp: shpc_init : shpc_cap_offset =3D=3D 0
> shpchp: shpc_init : shpc_cap_offset =3D=3D 0
> shpchp: shpc_init : shpc_cap_offset =3D=3D 0
> shpchp: shpc_init : shpc_cap_offset =3D=3D 0
> shpchp: shpc_init : shpc_cap_offset =3D=3D 0
> shpchp: shpc_init : shpc_cap_offset =3D=3D 0
> shpchp: shpc_init : shpc_cap_offset =3D=3D 0
> shpchp: shpc_init : shpc_cap_offset =3D=3D 0
> shpchp: shpc_init : shpc_cap_offset =3D=3D 0
> shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
>=20
> During the time of the outage we saw from our router logs that the
> connection to the server was going up and down.
>=20
> There was a lot of other messages on the console but our sysadmin guy=
 didn=92t
> capture this.
>=20
> We=92re running redhat linux 2.6.9-34.0.2.ELsmp on intel xeon process=
ors. =20
> We have 2 intel nic cards : Intel Corporation 82541GI/PI Gigabit Ethe=
rnet
> Controller (rev 05)
>=20
> Any light you can shed on this problem would be great.  Note that whi=
le the
> kacpid kernel thread is running the acpid daemon was shut off during =
this
> incident.
>=20
> Many thanks,
> Yong.
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20


-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
