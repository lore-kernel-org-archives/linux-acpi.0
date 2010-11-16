From: Maciej Rutecki <maciej.rutecki@gmail.com>
Subject: Re: [REGRESSION] [2.6.37-rc1] Fan noise after suspend to ram/disk
Date: Tue, 16 Nov 2010 16:46:23 +0100
Message-ID: <201011161646.24306.maciej.rutecki@gmail.com>
References: <201011041706.59046.maciej.rutecki@gmail.com> <201011152139.46261.maciej.rutecki@gmail.com> <1289870775.8148.2020.camel@rui>
Reply-To: maciej.rutecki@gmail.com
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38578 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221Ab0KPPqg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Nov 2010 10:46:36 -0500
In-Reply-To: <1289870775.8148.2020.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>

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

I will test it today.

> Please attach the acpidump output of this laptop as well.

http://unixy.pl/maciek/download/kernel/2.6.37-rc1/gumis/acpidump.dat

>=20
> thanks,
> rui
>=20

Regards
--=20
Maciej Rutecki
http://www.maciek.unixy.pl
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
