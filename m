From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: backlight regression on ASUS F6S: inverted brightness control
Date: Wed, 31 Dec 2008 14:21:45 +0800
Message-ID: <1230704505.562.320.camel@rzhang-dt>
References: <200812280611.18320.kel@otaku42.de>
	 <200812291839.47270.kel@otaku42.de> <1230601067.562.235.camel@rzhang-dt>
	 <200812310202.16459.kel@otaku42.de>  <1230694408.562.306.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:43962 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751735AbYLaGYS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 31 Dec 2008 01:24:18 -0500
In-Reply-To: <1230694408.562.306.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Kel Modderman <kel@otaku42.de>

Hi, thomas,

we got a couple of regressions caused by the acpi video detect patch
set.
IMO, the reason is that they have buggy ACPI video extension
implemented. and these laptops used to control the backlight via
platform drivers.

you can refer to this thread or the bug:
http://bugzilla.kernel.org/show_bug.cgi?id=3D12037
http://bugzilla.kernel.org/show_bug.cgi?id=3D12235
http://bugzilla.kernel.org/show_bug.cgi?id=3D12249
http://bugzilla.kernel.org/show_bug.cgi?id=3D12302

I have fixed one by overriding the DSDT.
the source code of the customized DSDT can be found at
http://bugzilla.kernel.org/show_bug.cgi?id=3D12249#c32

so IMO, acpi_video_backlight_support should be able to verify if BIOS
offers buggy ACPI backlight control methods and returns false  in this
case. but then we need to move a lot of ACPI video code
(acpi_video_init_brightness) to video_detect.c, which doesn't sound
quite good. what do you think?

thanks,
rui

On Wed, 2008-12-31 at 11:33 +0800, Zhang Rui wrote:
> the ACPI video backlight I/F on your laptop is broken.
> could you please boot with acpi_backlight=3Dvendor and see if it work=
s at
> before?
>=20
> BTW: please attach the output of =EF=BB=BF"grep . /proc/acpi/video/*/=
*/*" in=20
> 1. 2.6.28 kenrel & boot with "acpi_backlight=3Dvendor"
> 2. an earlier working kernel, say 2.6.26.
>=20
> thanks,
> rui
>=20
>=20
> On Wed, 2008-12-31 at 00:02 +0800, Kel Modderman wrote:
> > On Tuesday 30 December 2008 11:37:47 Zhang Rui wrote:
> > > On Mon, 2008-12-29 at 16:39 +0800, Kel Modderman wrote:
> > > > On Monday 29 December 2008 11:07:32 Zhang Rui wrote:
> > > > > hi,
> > > > >=20
> > > > > This is a duplicate of bug
> > > > > http://bugzilla.kernel.org/show_bug.cgi?id=3D12302
> > > > > please try the patch at
> > > > > http://bugzilla.kernel.org/show_bug.cgi?id=3D12037#c5
> > > >=20
> > > > When patch is applied backlight control returned to normality.
> > > >=20
> > > please attach the output of "grep . /proc/acpi/video/*/*/*" both =
before
> > > and after applying this patch.
> >=20
> > Attached.
> >=20
> > Thanks, Kel
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
