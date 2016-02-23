From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: ACPI SPI slave device
Date: Tue, 23 Feb 2016 17:02:22 +0200
Message-ID: <20160223150222.GL1770@lahna.fi.intel.com>
References: <CAAbRKOuTsBe0SBvcD-q+bBOSdkv_OWBu0-YWeMfKnM1o4MhT4A@mail.gmail.com>
 <20160223073819.GK1770@lahna.fi.intel.com>
 <CAAbRKOvktig4w9RPngCV4PBYZmO+3emCPwjMT1XMSxNesY+M6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28337 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752839AbcBWPCc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Feb 2016 10:02:32 -0500
Content-Disposition: inline
In-Reply-To: <CAAbRKOvktig4w9RPngCV4PBYZmO+3emCPwjMT1XMSxNesY+M6A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Leif Liddy <leif.linux@gmail.com>
Cc: linux-acpi@vger.kernel.org, jarkko.nikula@linux.intel.com

On Tue, Feb 23, 2016 at 03:18:26PM +0100, Leif Liddy wrote:
> The device does have SPISerialbus() in _CRS.
>=20
> Looks like this guy is having the same issue.
> https://www.mail-archive.com/linux-yocto@yoctoproject.org/msg04044.ht=
ml
>=20
> "Slave devices were not enumerated by ACPI data because the ACPI hand=
le
> for the spi-pxa2xx controller was NULL if it was itself enumerated by
> PCI.

Yes, PCI part of the spi-pxa2xx does not propagate ACPI handle of the
device to the platform device it creates which prevents SPI core from
enumerating it.

> Upstream-status: Inappropriate, real fix forthcoming"

I believe passing the ACPI handle to the platform device is the real
fix.

Actually I think Jarkko (CC'd) already did patch for this some time ago=
=2E
We probably never upstreamed it because Haswell and Broadwell both were
supposed to enumerate LPSS devices only from ACPI. It seems not to be
the case for Apple devices, though.

>=20
> I'm going to try out his patch and see what happens..
>=20
> On Tue, Feb 23, 2016 at 8:38 AM, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> > On Tue, Feb 23, 2016 at 02:54:45AM +0100, Leif Liddy wrote:
> >> I'm new to kernel development, and there's few fairly large gaps i=
n my
> >> understanding about
> >> how drivers are meant to work, but hopefully you guys can point me=
 in
> >> the right direction.
> >>
> >> The macbook8,1 (early 2015) has a keyboard/trackpad that is seen b=
y
> >> ACPI as a single SPI slave device.
> >> It appears the only method to access the keyboard/trackpad is via
> >> the SPI bus --my goal is the get keyboard/trackpad working.
> >>
> >> I've recently submitted a kernel patch that binds the spi-pxa2xx-p=
ci
> >> driver to the Wildcat Point-LP Serial IO GSPI Controller. With thi=
s
> >> patch, the SPI controller appears to be working...
> >> http://www.spinics.net/lists/linux-spi/msg06867.html
> >>
> >> ----------LSHW INFO------------
> >> *-serial:1
> >>              description: Serial bus controller
> >>              product: Wildcat Point-LP Serial IO GSPI Controller #=
1
> >>              vendor: Intel Corporation
> >>              physical id: 15.4
> >>              bus info: pci@0000:00:15.4
> >>              version: 03
> >>              width: 32 bits
> >>              clock: 33MHz
> >>              capabilities: pm cap_list
> >>              configuration: driver=3Dpxa2xx_spi_pci latency=3D0
> >>              resources: irq:21 memory:c181a000-c181afff
> >>
> >>
> >> What I'm having trouble with is sorting out how to register the SP=
I
> >> slave device with the SPI controller.
> >> **no slave devices are found when I modprobe the driver.
> >> I'm not sure if this is something that should be done by the spi
> >> driver (by calling an acpi function), or whether I must manually d=
o
> >> it.
> >>
> >> =E2=80=93------------UDEV INFO---------------
> >>
> >> P: /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/INT33C1:00/APP000D:=
00
> >> E: DEVPATH=3D/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/INT33C1:0=
0/APP000D:00
> >> E: ID_VENDOR_FROM_DATABASE=3DApple Computer Inc
> >> E: MODALIAS=3Dacpi:APP000D:APPLE-SPI-TOPCASE:
> >> E: SUBSYSTEM=3Dacpi
> >> E: USEC_INITIALIZED=3D13574842
> >>
> >> **INT33C1 is the SPI master controller
> >> **APP000D is the slave device
> >
> > If the device has ACPI SpiSerialBus() resource in _CRS it should be
> > enumerated automatically by the Linux SPI core. See
> > Documentation/acpi/enumeration.txt.
> >
> > You should also see the device listed under /sys/bus/spi/devices.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
