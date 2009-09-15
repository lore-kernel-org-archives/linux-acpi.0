From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: How to backlight_device_register with some kind of "low prior"
	(for KMS)
Date: Tue, 15 Sep 2009 15:43:54 +0800
Message-ID: <1253000634.2504.27.camel@rzhang-dt>
References: <b170af450909142324i478b453fw105554eb584e7181@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36994 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753574AbZIOHr2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Sep 2009 03:47:28 -0400
In-Reply-To: <b170af450909142324i478b453fw105554eb584e7181@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, dri-devel@lists.sourceforge.net, "Zhao, Yakui" <yakui.zhao@intel.com>, "Barnes, Jesse" <jbarnes@virtuousgeek.org>

On Tue, 2009-09-15 at 14:24 +0800, Rafa=C5=82 Mi=C5=82ecki wrote:
> Hi,
>=20
> There are some unfunny cases, when ACPI can not be used for
> controlling backlight level.
>=20
> Example can be my Sony VAIO
> (http://bugzilla.kernel.org/show_bug.cgi?id=3D11682) where bl control
> doesn't work with sony-laptop. This notebook has ATI GPU that is
> responsible for backlight level.
>=20
> So we have to implement that in radeon module, which has access to
> card and can just use register/AtomBIOS to manage backlight. Of cours=
e
> KMS is perfect place for that.
>=20
> However we don't want to play with controlling backlight when there i=
s
> specific vendor driver for that. Many notebooks are well supported by
> sony-laptop (and other modules) and in these cases we don't want to
> change that.
>=20
> Is there some way of detecting if there is vendor-specific driver tha=
t
> cares backlight? Or can we register bl device with some low priority,
> so when acpi module registers with higher, it will be used?

well, a similar issue happens on Intel graphics,
=EF=BB=BFhttp://bugs.freedesktop.org/show_bug.cgi?id=3D20963

and we have a similar proposal but in fact it doesn't work.
you can get detailed information in the below link:
http://marc.info/?l=3Dlinux-acpi&m=3D124650087015684&w=3D2

Now the solution is:
1. register another backlight sysfs device in KMS driver, which is
different from  ACPI.
2. xrandr supports changing the backlight in multiple way, via differen=
t
backlight sysfs devices.

And I think it may work for you as well, i.e. two backlight sysfs I/F
may co-exist, it's the user space to decide which I/F to use.

thanks,
rui


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
