From: "Peter Mahlknecht" <mali100@gmx.net>
Subject: Re: ACPI reads wrong temperature
Date: Sun, 02 Nov 2008 12:31:12 +0100
Message-ID: <20081102113112.316040@gmx.net>
References: <20081031140247.325670@gmx.net>
 <20081031143030.GA9177@srcf.ucam.org> <20081031210913.3180@gmx.net>
 <20081102092541.GE10983@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:37480 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752985AbYKBLbO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 2 Nov 2008 06:31:14 -0500
In-Reply-To: <20081102092541.GE10983@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org

> > Thanks for the hint. I get the wrong temperatures after loading the=
=20
> > lm90 module (hwmon driver), but also if i load em28xx_cx25843, whic=
h=20
> > is a part of the driver for my tv-card. Both modules depend on=20
> > i2c-core, so probably the bug is related to the i2c bus?
>=20
> In the lm90 case it's almost certainly because you have the firmware =
and=20
> Linux trying to access the chip at the same time. Since it has indexe=
d=20
> registers, this fails very miserably. I'm surprised that the TV card=20
> driver has any effect - it should be on an entirely spearate i2c bus.=
=20
> Are you sure you don't have lm90 loaded in that case?
Yes, I am. I had also a talk with the author of the Tv-card driver and =
he suggested to but the problem on the lm-sensors ml: http://lists.lm-s=
ensors.org/pipermail/lm-sensors/2008-November/024610.html
We know now that the problem is related to the i2c-i801 driver.

Peter=20
--=20
Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt? Der kann`s mit all=
en: http://www.gmx.net/de/go/multimessenger
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
