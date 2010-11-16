From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: [REGRESSION] [2.6.37-rc1] Fan noise after suspend to ram/disk
Date: Tue, 16 Nov 2010 20:28:46 +0100
Message-ID: <201011162028.47007.maciej.rutecki@gmail.com>
References: <201011041706.59046.maciej.rutecki@gmail.com> <201011152139.46261.maciej.rutecki@gmail.com> <1289870775.8148.2020.camel@rui>
Reply-To: maciej.rutecki@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1289870775.8148.2020.camel@rui>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-acpi@vger.kernel.org

On wtorek, 16 listopada 2010 o 02:26:15 Zhang Rui wrote:
> On Tue, 2010-11-16 at 04:39 +0800, Maciej Rutecki wrote:
> > On poniedzia=C5=82ek, 15 listopada 2010 o 04:16:35 Zhang Rui wrote:
> > > On Tue, 2010-11-09 at 01:35 +0800, Maciej Rutecki wrote:
> > > > On poniedzia=C5=82ek, 8 listopada 2010 o 07:58:52 Zhang Rui wro=
te:
> > > > > IMO, the only one that may cause this regression is commit
> > > > > c57b62f5b1e6dd69ff8c96f6db7f86ea31c0e21f
> > > > > some app may enable polling via procfs and update the thermal=
 zone
> > > > > status.
> > > >=20
> > > > I revert this commit from 2.6.37-rc1. Still the same:
> > > could you please apply the patch attached, on top of 2.6.37-rc1, =
and
> > > then attach the dmesg output if the fan is noise after suspend/re=
sume.
> >=20
> > Dmesg in attachement.
> >=20
> > Starting suspend to ram from:
> > [  104.602674] PM: Syncing filesystems ... done.
> > resume OK, but next:
> > [  144.298104] PM: Syncing filesystems ... done.
> > after resume fan starts on full speed.
>=20
> it seems that it's not the thermal driver that changes the Fan speed.
> Please apply the debug patch attached, rebuild with CONFIG_ACPI_DEBUG
> set and reboot with "acpi.debug_level=3D0x004
> acpi.debug_layer=3D0x04A10000", and then attach the dmesg output afte=
r the
> same test.
> Please attach the acpidump output of this laptop as well.
>=20
> thanks,
> rui
>=20
> > Regards

Revert 3e384ee6c687cb397581ee8f9440fc8220cfac80 seems solve problem:
https://bugzilla.kernel.org/show_bug.cgi?id=3D22932#c3

Thanks
--=20
Maciej Rutecki
http://www.maciek.unixy.pl
