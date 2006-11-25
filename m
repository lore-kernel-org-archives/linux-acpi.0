From: "Yong Lee" <yonglee@telus.net>
Subject: RE: acpi nic card flapping
Date: Fri, 24 Nov 2006 23:34:58 -0800
Message-ID: <000f01c71064$36a4ea20$6602a8c0@yonglaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from defout.telus.net ([204.209.205.55]:47810 "EHLO defout.telus.net")
	by vger.kernel.org with ESMTP id S1757874AbWKYHfB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 25 Nov 2006 02:35:01 -0500
Received: from priv-edmwaa06.telusplanet.net ([209.121.150.110])
          by priv-edmwes50.telusplanet.net
          (InterMail vM.7.05.01.01 201-2174-106-103-20060222) with ESMTP
          id <20061125073500.SWHF19925.priv-edmwes50.telusplanet.net@priv-edmwaa06.telusplanet.net>
          for <linux-acpi@vger.kernel.org>; Sat, 25 Nov 2006 00:35:00 -0700
Received: from yonglaptop (d209-121-150-110.bchsia.telus.net [209.121.150.110])
	by priv-edmwaa06.telusplanet.net (BorderWare MXtreme Infinity Mail Firewall) with ESMTP id 8561R3CHV8
	for <linux-acpi@vger.kernel.org>; Sat, 25 Nov 2006 00:34:59 -0700 (MST)
In-Reply-To: 
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi all,

I=92m hoping that someone out there can lend me a hand with a problem t=
hat we
were seeing. =A0I=92m not very familiar with the acpi tool so please be=
ar with
me.

We had an outage where we could not ssh into our web server and we had =
to do
a reboot from our console to get things running again.=A0 It looks like=
 an
acpi problem and I=92m trying to figure out what was going on. =A0Was A=
CPI going
crazy or was it trying to report a problem condition that we were not a=
ware
of.

What we saw in the dmesg log was this :

shpchp: Address64 -------- Resource unparsed
shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=3D0x5
shpchp: acpi_shpchprm:=A0=A0 Slot sun(0) at s:b:d:f=3D0x00:04:1f:00
shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=3D0x5
shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=3D0x5
shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=3D0x5
shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=3D0x5
shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=3D0x5
shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=3D0x5
shpchp: acpi_pciehprm:\_SB_.PCI0.PBLO OSHP fails=3D0x5
shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=3D0x5
shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=3D0x5
shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=3D0x5
shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=3D0x5
shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=3D0x5
shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=3D0x5
shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=3D0x5
shpchp: acpi_pciehprm:\_SB_.PCI0.VPR0 OSHP fails=3D0x5
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: shpc_init : shpc_cap_offset =3D=3D 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4

During the time of the outage we saw from our router logs that the
connection to the server was going up and down.

There was a lot of other messages on the console but our sysadmin guy d=
idn=92t
capture this.

We=92re running redhat linux 2.6.9-34.0.2.ELsmp on intel xeon processor=
s. =A0
We have 2 intel nic cards : Intel Corporation 82541GI/PI Gigabit Ethern=
et
Controller (rev 05)

Any light you can shed on this problem would be great.=A0 Note that whi=
le the
kacpid kernel thread is running the acpid daemon was shut off during th=
is
incident.

Many thanks,
Yong.

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
