From: Thomas Renninger <trenn@suse.de>
Subject: RE: acpi nic card flapping
Date: Tue, 28 Nov 2006 13:00:50 +0100
Message-ID: <1164715250.4656.272.camel@queen.suse.de>
References: <000f01c71064$36a4ea20$6602a8c0@yonglaptop>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.suse.de ([195.135.220.2]:57291 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1757014AbWK1MA7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Nov 2006 07:00:59 -0500
In-Reply-To: <000f01c71064$36a4ea20$6602a8c0@yonglaptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yong Lee <yonglee@telus.net>
Cc: linux-acpi@vger.kernel.org

On Fri, 2006-11-24 at 23:34 -0800, Yong Lee wrote:
> Hi all,
>=20
> I=E2=80=99m hoping that someone out there can lend me a hand with a p=
roblem that we
> were seeing.  I=E2=80=99m not very familiar with the acpi tool so ple=
ase bear with
> me.
>=20
> We had an outage where we could not ssh into our web server and we ha=
d to do
> a reboot from our console to get things running again.  It looks like=
 an
> acpi problem and I=E2=80=99m trying to figure out what was going on. =
 Was ACPI going
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
 didn=E2=80=99t
> capture this.
Hmm, so that may not be the root cause of your problems?
>=20
> We=E2=80=99re running redhat linux 2.6.9-34.0.2.ELsmp on intel xeon p=
rocessors. =20
> We have 2 intel nic cards : Intel Corporation 82541GI/PI Gigabit Ethe=
rnet
> Controller (rev 05)
>=20
> Any light you can shed on this problem would be great.  Note that whi=
le the
> kacpid kernel thread is running the acpid daemon was shut off during =
this
> incident.
If the pci hotplug module (shpchp, difficult to spell...) really causes
this it might be kernel or a BIOS bug. If this is a production machine
that is already running for a while, I would not risk a BIOS update or
waste time with kernel compilations. Best/simplest would be to remove
the module out of /lib/modules/xy/kernel/drivers/pci/hotplug/shpchp.ko
directory if you do not need PCI hotplug urgently.

Hope that works...

      Thomas

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
