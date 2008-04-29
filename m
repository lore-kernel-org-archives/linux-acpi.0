From: Thomas Renninger <trenn@suse.de>
Subject: Re: Linux 2.6.25 (coretemp reads high temperatures)
Date: Tue, 29 Apr 2008 15:07:03 +0200
Message-ID: <1209474423.1784.837.camel@queen.suse.de>
References: <e85b9d30804180837y39c52e26i588e4b67c87a5e9d@mail.gmail.com>
	 <200804182151.49021.lenb@kernel.org>
	 <200804231143.10875.maximlevitsky@gmail.com>
	 <1209406784.11608.15.camel@localhost>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761489AbYD2NHZ@vger.kernel.org>
In-Reply-To: <1209406784.11608.15.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Kasper Sandberg <lkml@metanurb.dk>
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Len Brown <lenb@kernel.org>, Matthew <jackdachef@gmail.com>, linux-acpi@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, "Zhang, Rui" <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2008-04-28 at 20:19 +0200, Kasper Sandberg wrote:
> On Wed, 2008-04-23 at 11:43 +0300, Maxim Levitsky wrote:
> > On Saturday, 19 April 2008 04:51:48 Len Brown wrote:
> > > On Friday 18 April 2008, Matthew wrote:
> > > > Hi everyone, hi Linus,
> > > >=20
> > > > congratulations on this new great kernel-release :)
> > > >=20
> > > > I've another "regression" to report for 2.6.25:
> > > >=20
> > > > it's concerning much higher temperatures being read out by the
> > > > "coretemp" kernel-module in comparison to 2.6.24* series
> > > >=20
> > > > e.g. where temperatures were around 40-47=C2=B0C they are now c=
onstantly
> > > > jumping around 55-70=C2=B0C (even in idle !)
> >=20
> > I just updated from 2.6.24 to 2.6.25
> > (I usually follow whole development cycle, but I was very busy, so =
I skipped 2.6.25 cycle)
> >=20
> > I confirm this.
> > I *know* that temperatures reported now are wrong.
>=20
> I too can confirm that it reports incorrect temperatures.
>=20
> I have a Q9450, and this is my "sensors" output:
> it8718-isa-0290
> Adapter: ISA adapter
> <snip>
> temp1:       +44=C3=82=C2=B0C  (low  =3D  +127=C3=82=C2=B0C, high =3D=
  +127=C3=82=C2=B0C)   sensor =3D
> thermistor
> temp2:       +22=C3=82=C2=B0C  (low  =3D  +127=C3=82=C2=B0C, high =3D=
   +60=C3=82=C2=B0C)   sensor =3D diode
> temp3:        -2=C3=82=C2=B0C  (low  =3D  +127=C3=82=C2=B0C, high =3D=
  +127=C3=82=C2=B0C)   sensor =3D
> thermistor
> vid:      +0.000 V
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Core 0:      +44=C3=82=C2=B0C  (high =3D  +100=C3=82=C2=B0C)
>=20
> coretemp-isa-0001
> Adapter: ISA adapter
> Core 1:      +44=C3=82=C2=B0C  (high =3D  +100=C3=82=C2=B0C)
>=20
> coretemp-isa-0002
> Adapter: ISA adapter
> Core 2:      +43=C3=82=C2=B0C  (high =3D  +100=C3=82=C2=B0C)
>=20
> coretemp-isa-0003
> Adapter: ISA adapter
> Core 3:      +41=C3=82=C2=B0C  (high =3D  +100=C3=82=C2=B0C)
>=20
>=20
> temp2 is the cpu temperature(matches bios), temp1 is the northbridge(=
i
> think, bios says "system temp").
>=20
> i have watercooling, and well :P when i touch the "tube", its normal
> room temperature, and believe me, i would notice if it was 45.. this =
is
> with my cpu at idle - at full load on all 4 cores, temp2 says 35, and
> ~60 on coretemp, and THIS i would surely be able to notice over room
> temp :)
>=20
> any progress on this bug?
>=20
> >=20
> > The reason is that bios did report same temperatures as coretemp in=
 2.6.24,
> > moreover some time ago I have run a cpu tool (don't remember its na=
me) on windows
> > which similar to coretemp reads from each core directly, sensor dat=
a ,=20
> > and I noticed that temperature that bios reports is exactly the ave=
rage=20
> > temperature of both cores
> > (I had to run this on windows - intel haven't released=20
> > drivers for their QST for temperature monitoring from bios - very s=
ad)
> >=20
> > And the driver did say in kernel log that TJMAX is 85C
> >=20
> > Lets at least make a kernel option to override tjmax?
> >=20

Could it be that due to latest thermal changes ACPI is reading
temperatures more often, or started to read sensors that interfere with
libsensors?

There was a patch-set that detect such interference from myself and Jea=
n
which was not accepted by Linus.
This is what I got from Jean recently, he should be able to point you t=
o
the latest patches if you want to give them a try:
----------------------------------------------
On Mon, 28 Apr 2008 22:13:13 -0700, Andrew Morton wrote:
> In light of Linus's dummyspit last time around I guess I'll drop
> this patch.

That's OK, I'll include it in my i2c tree instead. While Linus doesn't
like it, he didn't actually provide replacement code, only a vague idea
which Thomas and myself know by experience, won't work well anyway. As
the checks done by this driver are valuable, having it in -mm and
linux-next is still good.

--=20
Jean Delvare
----------------------------------------------


If you get a conflict you should see something like this when loading
the hwmon/sensor driver:
i2c /dev entries driver
f71805f: Found F71805F/FG chip at 0x290, revision 19
ACPI: I/O resource f71805f [0x290-0x297] conflicts with ACPI region IP_=
_ [0x295-0x296]
ACPI: Device needs an ACPI driver

   Thomas
