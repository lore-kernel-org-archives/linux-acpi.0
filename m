From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Linux 2.6.25 (coretemp reads high temperatures)
Date: Wed, 30 Apr 2008 08:20:05 +0200
Message-ID: <20080430082005.4b76186f@hyperion.delvare>
References: <e85b9d30804180837y39c52e26i588e4b67c87a5e9d@mail.gmail.com>
	<200804182151.49021.lenb@kernel.org>
	<200804231143.10875.maximlevitsky@gmail.com>
	<1209406784.11608.15.camel@localhost>
	<1209474423.1784.837.camel@queen.suse.de>
	<20080429170824.09540206@hyperion.delvare>
	<48179DB4.8040701@assembler.cz>
	<1209514274.27499.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:20378 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755046AbYD3GUf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Apr 2008 02:20:35 -0400
In-Reply-To: <1209514274.27499.12.camel@localhost>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: Rudolf Marek <r.marek@assembler.cz>, Maxim Levitsky <maximlevitsky@gmail.com>, trenn@suse.de, Len Brown <lenb@kernel.org>, Matthew <jackdachef@gmail.com>, linux-acpi@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>

On Wed, 30 Apr 2008 02:11:14 +0200, Kasper Sandberg wrote:
> On Wed, 2008-04-30 at 00:14 +0200, Rudolf Marek wrote:
> > Well again, I tried hard at Intel and I really could not get any in=
fo on some
> > calibration bit. The temperature is non-physical on arbitrary scale=
=2E I changed
> > that so for some people it jumped to 100C, for some it remained.
>=20
> So, im confused.. The reason for this is that the internal sensor is
> operating on some sort of weird scale, and thus when you interpolate =
it
> into "your" scale, it doesent quite come out in the actual degrees
> celcius the cpu temperature really is?

It's really only an offset, rather than scaling. The temperature
reported by the Core and Core2 CPUs is a relative temperature. It tells
how far you are from the maximum temperature the CPU can survive. The
value is expressed in (relative) degrees C.

Rudolf did his best to find out the (absolute) temperature each CPU
model can survive (known as TJmax) so that the coretemp driver can
provide an absolute temperature to user-space, as all other hardware
monitoring drivers do. Our hope was to limit the confusion, but it
seems we failed ;) Maybe it would be better if the driver was reporting
the relative temperature value directly when we don't know the TJmax
value for sure - but then all user-space tools would need to learn how
to deal with this.

> so if i understand this correctly, the coretemp output does NOT
> represent the actual deg celcius temperature my cpu is?

It should, but there's no guarantee on desktop/server CPUs. It can be
offset by 15=B0C if the driver's heuristic to determine TJmax for your
CPU is incorrect. I guess the offset could even be different - after
all the documentation we got from Intel was incomplete so we don't
really know.

--=20
Jean Delvare
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
