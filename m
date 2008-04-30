From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Linux 2.6.25 (coretemp reads high temperatures)
Date: Wed, 30 Apr 2008 11:51:10 -0300
Message-ID: <20080430145110.GC3543@khazad-dum.debian.net>
References: <e85b9d30804180837y39c52e26i588e4b67c87a5e9d@mail.gmail.com> <200804182151.49021.lenb@kernel.org> <200804231143.10875.maximlevitsky@gmail.com> <1209406784.11608.15.camel@localhost> <1209474423.1784.837.camel@queen.suse.de> <20080429170824.09540206@hyperion.delvare> <48179DB4.8040701@assembler.cz> <1209514274.27499.12.camel@localhost> <20080430082005.4b76186f@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:34584 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756765AbYD3OvN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 30 Apr 2008 10:51:13 -0400
Content-Disposition: inline
In-Reply-To: <20080430082005.4b76186f@hyperion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Kasper Sandberg <lkml@metanurb.dk>, Rudolf Marek <r.marek@assembler.cz>, Maxim Levitsky <maximlevitsky@gmail.com>, trenn@suse.de, Len Brown <lenb@kernel.org>, Matthew <jackdachef@gmail.com>, linux-acpi@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>

On Wed, 30 Apr 2008, Jean Delvare wrote:
> On Wed, 30 Apr 2008 02:11:14 +0200, Kasper Sandberg wrote:
> > On Wed, 2008-04-30 at 00:14 +0200, Rudolf Marek wrote:
> > > Well again, I tried hard at Intel and I really could not get any =
info on some
> > > calibration bit. The temperature is non-physical on arbitrary sca=
le. I changed
> > > that so for some people it jumped to 100C, for some it remained.
> >=20
> > So, im confused.. The reason for this is that the internal sensor i=
s
> > operating on some sort of weird scale, and thus when you interpolat=
e it
> > into "your" scale, it doesent quite come out in the actual degrees
> > celcius the cpu temperature really is?
>=20
> It's really only an offset, rather than scaling. The temperature
> reported by the Core and Core2 CPUs is a relative temperature. It tel=
ls
> how far you are from the maximum temperature the CPU can survive. The
> value is expressed in (relative) degrees C.

Ah, please ignore my email about ITUs (Intel thermal units), then.  The
above means 1ITU=3D1=B0C, but their zeros are at different places.

> Rudolf did his best to find out the (absolute) temperature each CPU
> model can survive (known as TJmax) so that the coretemp driver can
> provide an absolute temperature to user-space, as all other hardware
> monitoring drivers do. Our hope was to limit the confusion, but it
> seems we failed ;) Maybe it would be better if the driver was reporti=
ng
> the relative temperature value directly when we don't know the TJmax
> value for sure - but then all user-space tools would need to learn ho=
w
> to deal with this.

Actually, just libsensors would, and the local admin can adjust it at
will using the config file.

Nobody in userspace should be reading hwmon sysfs directly without the
use of libsensors.  If they are, it is their bug, and it is unsupported
AFAIK.

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
