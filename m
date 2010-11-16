From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [REGRESSION] [2.6.37-rc1] Fan noise after suspend to ram/disk
Date: Tue, 16 Nov 2010 23:35:26 +0100
Message-ID: <201011162335.26220.rjw@sisk.pl>
References: <201011041706.59046.maciej.rutecki@gmail.com> <1289870775.8148.2020.camel@rui> <201011162028.47007.maciej.rutecki@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54699 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753946Ab0KPWgM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Nov 2010 17:36:12 -0500
In-Reply-To: <201011162028.47007.maciej.rutecki@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: maciej.rutecki@gmail.com
Cc: Zhang Rui <rui.zhang@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>

On Tuesday, November 16, 2010, Maciej Rutecki wrote:
> On wtorek, 16 listopada 2010 o 02:26:15 Zhang Rui wrote:
> > On Tue, 2010-11-16 at 04:39 +0800, Maciej Rutecki wrote:
> > > On poniedzia=C5=82ek, 15 listopada 2010 o 04:16:35 Zhang Rui wrot=
e:
> > > > On Tue, 2010-11-09 at 01:35 +0800, Maciej Rutecki wrote:
> > > > > On poniedzia=C5=82ek, 8 listopada 2010 o 07:58:52 Zhang Rui w=
rote:
> > > > > > IMO, the only one that may cause this regression is commit
> > > > > > c57b62f5b1e6dd69ff8c96f6db7f86ea31c0e21f
> > > > > > some app may enable polling via procfs and update the therm=
al zone
> > > > > > status.
> > > > >=20
> > > > > I revert this commit from 2.6.37-rc1. Still the same:
> > > > could you please apply the patch attached, on top of 2.6.37-rc1=
, and
> > > > then attach the dmesg output if the fan is noise after suspend/=
resume.
> > >=20
> > > Dmesg in attachement.
> > >=20
> > > Starting suspend to ram from:
> > > [  104.602674] PM: Syncing filesystems ... done.
> > > resume OK, but next:
> > > [  144.298104] PM: Syncing filesystems ... done.
> > > after resume fan starts on full speed.
> >=20
> > it seems that it's not the thermal driver that changes the Fan spee=
d.
> > Please apply the debug patch attached, rebuild with CONFIG_ACPI_DEB=
UG
> > set and reboot with "acpi.debug_level=3D0x004
> > acpi.debug_layer=3D0x04A10000", and then attach the dmesg output af=
ter the
> > same test.
> > Please attach the acpidump output of this laptop as well.
> >=20
> > thanks,
> > rui
> >=20
> > > Regards
>=20
> Revert 3e384ee6c687cb397581ee8f9440fc8220cfac80 seems solve problem:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D22932#c3

Please do the test I asked for in the bug entry.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
