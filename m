From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Sony vaio serie F PCIe PME service failure.
Date: Sun, 23 May 2010 20:38:55 +0200
Message-ID: <201005232038.55698.rjw@sisk.pl>
References: <4BF6FEA4.1050406@gmail.com> <201005231944.51135.maciej.rutecki@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60232 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755053Ab0EWShu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 23 May 2010 14:37:50 -0400
In-Reply-To: <201005231944.51135.maciej.rutecki@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: maciej.rutecki@gmail.com
Cc: Xavier Gnata <xavier.gnata@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org

On Sunday 23 May 2010, Maciej Rutecki wrote:
> (Add CC)
>=20
> 2.6.33.* works OK?
>=20
> On pi=C4=85tek, 21 maja 2010 o 23:44:04 Xavier Gnata wrote:
> > Hi,
> >=20
> > I get that during the boot of the vaio VPCF11M1E using unpatched 2.=
6.34
> > from kernel.org:
> >=20
> > [    2.047242] pcieport 0000:00:01.0: Failed to receive control of =
PCIe
> > PME service: ACPI _OSC failed
> > [    2.047249] pcie_pme: probe of 0000:00:01.0:pcie01 failed with e=
rror -13
> > [    2.047418] pcieport 0000:00:1c.0: Failed to receive control of =
PCIe
> > PME service: ACPI _OSC failed
> > [    2.047424] pcie_pme: probe of 0000:00:1c.0:pcie01 failed with e=
rror -13
> > [    2.047589] pcieport 0000:00:1c.1: Failed to receive control of =
PCIe
> > PME service: ACPI _OSC failed
> > [    2.047595] pcie_pme: probe of 0000:00:1c.1:pcie01 failed with e=
rror -13
> > [    2.047759] pcieport 0000:00:1c.2: Failed to receive control of =
PCIe
> > PME service: ACPI _OSC failed
> > [    2.047764] pcie_pme: probe of 0000:00:1c.2:pcie01 failed with e=
rror -13
> > [    2.047928] pcieport 0000:00:1c.5: Failed to receive control of =
PCIe
> > PME service: ACPI _OSC failed
> > [    2.047933] pcie_pme: probe of 0000:00:1c.5:pcie01 failed with e=
rror -13
> >=20
> > for i in /sys/bus/pnp/devices/*; do echo $i; cat $i/id; done
> > returns :
> >=20
> > /sys/bus/pnp/devices/00:00
> > PNP0a08
> > PNP0a03
> > /sys/bus/pnp/devices/00:01
> > PNP0200
> > /sys/bus/pnp/devices/00:02
> > INT0800
> > /sys/bus/pnp/devices/00:03
> > PNP0103
> > /sys/bus/pnp/devices/00:04
> > PNP0c04
> > /sys/bus/pnp/devices/00:05
> > PNP0c02
> > /sys/bus/pnp/devices/00:06
> > PNP0b00
> > /sys/bus/pnp/devices/00:07
> > PNP0303
> > /sys/bus/pnp/devices/00:08
> > SNY9011
> > PNP0f13
> > /sys/bus/pnp/devices/00:09
> > PNP0c02
> > /sys/bus/pnp/devices/00:0a
> > PNP0a03
> >=20
> >=20
> > Everthing looks fine except these messages during the boot.
> > Any clue about what's going wrong? (maybe nothing...)

Actually nothing.  Your BIOS doesn't want us to use the native PCIe PME=
 on
root ports.

There's nothing wrong with that, but we want to know in case PCI runtim=
e PM
doesn't work.

Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
