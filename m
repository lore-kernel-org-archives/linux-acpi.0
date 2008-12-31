From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: backlight regression on ASUS F6S: inverted brightness control
Date: Wed, 31 Dec 2008 11:33:28 +0800
Message-ID: <1230694408.562.306.camel@rzhang-dt>
References: <200812280611.18320.kel@otaku42.de>
	 <200812291839.47270.kel@otaku42.de> <1230601067.562.235.camel@rzhang-dt>
	 <200812310202.16459.kel@otaku42.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11807 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755560AbYLaDgB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Dec 2008 22:36:01 -0500
In-Reply-To: <200812310202.16459.kel@otaku42.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kel Modderman <kel@otaku42.de>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

the ACPI video backlight I/F on your laptop is broken.
could you please boot with acpi_backlight=3Dvendor and see if it works =
at
before?

BTW: please attach the output of =EF=BB=BF"grep . /proc/acpi/video/*/*/=
*" in=20
1. 2.6.28 kenrel & boot with "acpi_backlight=3Dvendor"
2. an earlier working kernel, say 2.6.26.

thanks,
rui


On Wed, 2008-12-31 at 00:02 +0800, Kel Modderman wrote:
> On Tuesday 30 December 2008 11:37:47 Zhang Rui wrote:
> > On Mon, 2008-12-29 at 16:39 +0800, Kel Modderman wrote:
> > > On Monday 29 December 2008 11:07:32 Zhang Rui wrote:
> > > > hi,
> > > >=20
> > > > This is a duplicate of bug
> > > > http://bugzilla.kernel.org/show_bug.cgi?id=3D12302
> > > > please try the patch at
> > > > http://bugzilla.kernel.org/show_bug.cgi?id=3D12037#c5
> > >=20
> > > When patch is applied backlight control returned to normality.
> > >=20
> > please attach the output of "grep . /proc/acpi/video/*/*/*" both be=
fore
> > and after applying this patch.
>=20
> Attached.
>=20
> Thanks, Kel

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
