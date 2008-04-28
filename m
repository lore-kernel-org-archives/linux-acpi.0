From: Kasper Sandberg <lkml@metanurb.dk>
Subject: Re: Linux 2.6.25 (coretemp reads high temperatures)
Date: Mon, 28 Apr 2008 20:19:44 +0200
Message-ID: <1209406784.11608.15.camel@localhost>
References: <e85b9d30804180837y39c52e26i588e4b67c87a5e9d@mail.gmail.com>
	 <200804182151.49021.lenb@kernel.org>
	 <200804231143.10875.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pasmtpb.tele.dk ([80.160.77.98]:53491 "EHLO pasmtpB.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932335AbYD1SUx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Apr 2008 14:20:53 -0400
In-Reply-To: <200804231143.10875.maximlevitsky@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Len Brown <lenb@kernel.org>, Matthew <jackdachef@gmail.com>, linux-acpi@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org

On Wed, 2008-04-23 at 11:43 +0300, Maxim Levitsky wrote:
> On Saturday, 19 April 2008 04:51:48 Len Brown wrote:
> > On Friday 18 April 2008, Matthew wrote:
> > > Hi everyone, hi Linus,
> > >=20
> > > congratulations on this new great kernel-release :)
> > >=20
> > > I've another "regression" to report for 2.6.25:
> > >=20
> > > it's concerning much higher temperatures being read out by the
> > > "coretemp" kernel-module in comparison to 2.6.24* series
> > >=20
> > > e.g. where temperatures were around 40-47=B0C they are now consta=
ntly
> > > jumping around 55-70=B0C (even in idle !)
>=20
> I just updated from 2.6.24 to 2.6.25
> (I usually follow whole development cycle, but I was very busy, so I =
skipped 2.6.25 cycle)
>=20
> I confirm this.
> I *know* that temperatures reported now are wrong.

I too can confirm that it reports incorrect temperatures.

I have a Q9450, and this is my "sensors" output:
it8718-isa-0290
Adapter: ISA adapter
<snip>
temp1:       +44=C2=B0C  (low  =3D  +127=C2=B0C, high =3D  +127=C2=B0C)=
   sensor =3D
thermistor
temp2:       +22=C2=B0C  (low  =3D  +127=C2=B0C, high =3D   +60=C2=B0C)=
   sensor =3D diode
temp3:        -2=C2=B0C  (low  =3D  +127=C2=B0C, high =3D  +127=C2=B0C)=
   sensor =3D
thermistor
vid:      +0.000 V

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +44=C2=B0C  (high =3D  +100=C2=B0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +44=C2=B0C  (high =3D  +100=C2=B0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +43=C2=B0C  (high =3D  +100=C2=B0C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +41=C2=B0C  (high =3D  +100=C2=B0C)


temp2 is the cpu temperature(matches bios), temp1 is the northbridge(i
think, bios says "system temp").

i have watercooling, and well :P when i touch the "tube", its normal
room temperature, and believe me, i would notice if it was 45.. this is
with my cpu at idle - at full load on all 4 cores, temp2 says 35, and
~60 on coretemp, and THIS i would surely be able to notice over room
temp :)

any progress on this bug?

>=20
> The reason is that bios did report same temperatures as coretemp in 2=
=2E6.24,
> moreover some time ago I have run a cpu tool (don't remember its name=
) on windows
> which similar to coretemp reads from each core directly, sensor data =
,=20
> and I noticed that temperature that bios reports is exactly the avera=
ge=20
> temperature of both cores
> (I had to run this on windows - intel haven't released=20
> drivers for their QST for temperature monitoring from bios - very sad=
)
>=20
> And the driver did say in kernel log that TJMAX is 85C
>=20
> Lets at least make a kernel option to override tjmax?
>=20
> Best regards,
> 	Maxim Levitsky
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
