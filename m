From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Linux 2.6.25 (coretemp reads high temperatures)
Date: Fri, 2 May 2008 22:36:15 +0200
Message-ID: <20080502203615.GF3956@ucw.cz>
References: <e85b9d30804180837y39c52e26i588e4b67c87a5e9d@mail.gmail.com> <200804182151.49021.lenb@kernel.org> <200804231143.10875.maximlevitsky@gmail.com> <1209406784.11608.15.camel@localhost> <1209474423.1784.837.camel@queen.suse.de> <20080429170824.09540206@hyperion.delvare> <48179DB4.8040701@assembler.cz> <1209514274.27499.12.camel@localhost> <20080430082005.4b76186f@hyperion.delvare> <20080430145110.GC3543@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46259 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934352AbYEBUgb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 May 2008 16:36:31 -0400
Content-Disposition: inline
In-Reply-To: <20080430145110.GC3543@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Jean Delvare <khali@linux-fr.org>, Kasper Sandberg <lkml@metanurb.dk>, Rudolf Marek <r.marek@assembler.cz>, Maxim Levitsky <maximlevitsky@gmail.com>, trenn@suse.de, Len Brown <lenb@kernel.org>, Matthew <jackdachef@gmail.com>, linux-acpi@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>

Hi!

> > > So, im confused.. The reason for this is that the internal sensor=
 is
> > > operating on some sort of weird scale, and thus when you interpol=
ate it
> > > into "your" scale, it doesent quite come out in the actual degree=
s
> > > celcius the cpu temperature really is?
> >=20
> > It's really only an offset, rather than scaling. The temperature
> > reported by the Core and Core2 CPUs is a relative temperature. It t=
ells
> > how far you are from the maximum temperature the CPU can survive. T=
he
> > value is expressed in (relative) degrees C.
>=20
> Ah, please ignore my email about ITUs (Intel thermal units), then.  T=
he
> above means 1ITU=3D1=B0C, but their zeros are at different places.
>=20
> > Rudolf did his best to find out the (absolute) temperature each CPU
> > model can survive (known as TJmax) so that the coretemp driver can
> > provide an absolute temperature to user-space, as all other hardwar=
e
> > monitoring drivers do. Our hope was to limit the confusion, but it
> > seems we failed ;) Maybe it would be better if the driver was repor=
ting
> > the relative temperature value directly when we don't know the TJma=
x
> > value for sure - but then all user-space tools would need to learn =
how
> > to deal with this.
>=20
> Actually, just libsensors would, and the local admin can adjust it at
> will using the config file.
>=20
> Nobody in userspace should be reading hwmon sysfs directly without th=
e
> use of libsensors.  If they are, it is their bug, and it is unsupport=
ed
> AFAIK.

Hmm, that's an interesting ABI design. No, I do not think that's a
good idea.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
