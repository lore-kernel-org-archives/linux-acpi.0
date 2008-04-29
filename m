From: Jean Delvare <khali@linux-fr.org>
Subject: Re: Linux 2.6.25 (coretemp reads high temperatures)
Date: Tue, 29 Apr 2008 17:08:24 +0200
Message-ID: <20080429170824.09540206@hyperion.delvare>
References: <e85b9d30804180837y39c52e26i588e4b67c87a5e9d@mail.gmail.com>
	<200804182151.49021.lenb@kernel.org>
	<200804231143.10875.maximlevitsky@gmail.com>
	<1209406784.11608.15.camel@localhost>
	<1209474423.1784.837.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932119AbYD2PIx@vger.kernel.org>
In-Reply-To: <1209474423.1784.837.camel@queen.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: trenn@suse.de
Cc: Kasper Sandberg <lkml@metanurb.dk>, Maxim Levitsky <maximlevitsky@gmail.com>, Len Brown <lenb@kernel.org>, Matthew <jackdachef@gmail.com>, linux-acpi@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>, Rudolf Marek <r.marek@assembler.cz>
List-Id: linux-acpi@vger.kernel.org

Hi all,

Adding Rudolf Marek to the thread, as he wrote the coretemp driver and
is maintaining it. He was really the first person to contact about your
problem...

On Tue, 29 Apr 2008 15:07:03 +0200, Thomas Renninger wrote:
> On Mon, 2008-04-28 at 20:19 +0200, Kasper Sandberg wrote:
> > On Wed, 2008-04-23 at 11:43 +0300, Maxim Levitsky wrote:
> > > On Saturday, 19 April 2008 04:51:48 Len Brown wrote:
> > > > On Friday 18 April 2008, Matthew wrote:
> > > > > Hi everyone, hi Linus,
> > > > >=20
> > > > > congratulations on this new great kernel-release :)
> > > > >=20
> > > > > I've another "regression" to report for 2.6.25:
> > > > >=20
> > > > > it's concerning much higher temperatures being read out by th=
e
> > > > > "coretemp" kernel-module in comparison to 2.6.24* series
> > > > >=20
> > > > > e.g. where temperatures were around 40-47=B0C they are now co=
nstantly
> > > > > jumping around 55-70=B0C (even in idle !)
> > >=20
> > > I just updated from 2.6.24 to 2.6.25
> > > (I usually follow whole development cycle, but I was very busy, s=
o I skipped 2.6.25 cycle)
> > >=20
> > > I confirm this.
> > > I *know* that temperatures reported now are wrong.

And how do you know? The newly reported temperatures could be correct
and the previous ones were incorrect (that's actually the case.) The
thing is, the temperature is stored as a relative value in the CPU.
Relative to what, depends on the CPU model, can be 85=B0C or 100=B0C. U=
p to
kernel 2.6.24 we had a set of rules to find out, in 2.6.25 we have a
presumably better heuristic. So some people have seen their CPU
temperature climb by 15=B0C and others drop by 15=B0C, that's expected.

> >=20
> > I too can confirm that it reports incorrect temperatures.
> >=20
> > I have a Q9450, and this is my "sensors" output:
> > it8718-isa-0290
> > Adapter: ISA adapter
> > <snip>
> > temp1:       +44=B0C  (low  =3D  +127=B0C, high =3D  +127=B0C)   se=
nsor =3D thermistor
> > temp2:       +22=B0C  (low  =3D  +127=B0C, high =3D   +60=B0C)   se=
nsor =3D diode
> > temp3:        -2=B0C  (low  =3D  +127=B0C, high =3D  +127=B0C)   se=
nsor =3D thermistor
> > vid:      +0.000 V
> >=20
> > coretemp-isa-0000
> > Adapter: ISA adapter
> > Core 0:      +44=B0C  (high =3D  +100=B0C)
> >=20
> > coretemp-isa-0001
> > Adapter: ISA adapter
> > Core 1:      +44=B0C  (high =3D  +100=B0C)
> >=20
> > coretemp-isa-0002
> > Adapter: ISA adapter
> > Core 2:      +43=B0C  (high =3D  +100=B0C)
> >=20
> > coretemp-isa-0003
> > Adapter: ISA adapter
> > Core 3:      +41=B0C  (high =3D  +100=B0C)
> >=20
> >=20
> > temp2 is the cpu temperature(matches bios), temp1 is the northbridg=
e(i
> > think, bios says "system temp").
> >=20
> > i have watercooling, and well :P when i touch the "tube", its norma=
l
> > room temperature, and believe me, i would notice if it was 45.. thi=
s is
> > with my cpu at idle - at full load on all 4 cores, temp2 says 35, a=
nd
> > ~60 on coretemp, and THIS i would surely be able to notice over roo=
m
> > temp :)

The coretemp driver reports the CPU _core_ temperature. That's not
something you can touch, believe me (unless you are an electron.)

Also note that the CPU temperature reported by the IT8718F may or may
not match the reality. To make sure, you'd need to know the type of
thermal diode expected by the IT8718F, the type of thermal diode in
your CPU, compute the correction factor if there is one. And you'd need
to know where the thermal diode is exactly. It is most certainly built
into the CPU, but some motherboard makers are doing weird things.

22=B0C seems very low to me, even for water-cooling. Note that
non-linearity of thermal diodes makes measurements inaccurate as they
get away from the expected operating point. I guess that thermal diodes
used in CPUs are calibrated for best results around the expected
temperature when using air-cooling, rather than water-cooling.

> >=20
> > any progress on this bug?

I still need to be convinced that there is a bug here.

> >=20
> > >=20
> > > The reason is that bios did report same temperatures as coretemp =
in 2.6.24,
> > > moreover some time ago I have run a cpu tool (don't remember its =
name) on windows

In my experience, the BIOS is more likely to get the information from
the on-board hardware monitoring chip than from the CPU MSRs as the
coretemp driver does.

> > > which similar to coretemp reads from each core directly, sensor d=
ata ,=20
> > > and I noticed that temperature that bios reports is exactly the a=
verage=20

If that windows tool was not written by Intel, then chances are that
the author had as much difficulties as we did to get the correct TJmax
values for the different CPU models, so it's hardly meaningful. And
even a tool written by Intel themselves, I wouldn't necessarily trust
it, given how hard it was to get the information from them.

> > > temperature of both cores
> > > (I had to run this on windows - intel haven't released=20
> > > drivers for their QST for temperature monitoring from bios - very=
 sad)
> > >=20
> > > And the driver did say in kernel log that TJMAX is 85C

Which driver, which kernel? As I wrote above, the coretemp heuristic
changed in kernel 2.6.25, so the fact that a previous kernel was
reporting a different tjmax value is irrelevant. Unless you have
additional documentation from Intel, I would tend to believe that the
coretemp driver in 2.6.25 is correct. But feel free to report the exact
CPU model you have (with CPUID info) to Rudolf, if he gets enough
reports about a specific CPU model which most people believe gets the
wrong tjmax, he can fix the driver.

> > >=20
> > > Lets at least make a kernel option to override tjmax?

That's a possibility for sure, but what we would really need is to
adjust the coretemp driver heuristics to always get it right - if
that's not already the case, that is. I'll let Rudolf decide anyway.

Note that all in all, the absolute temperature doesn't really matter
anyway. What matters is how far you are from TJmax.

> Could it be that due to latest thermal changes ACPI is reading
> temperatures more often, or started to read sensors that interfere wi=
th
> libsensors?

No, there's a much more simple explanation for this change users are
reporting, see above. Plus, I fail to see how ACPI could interfere with
the coretemp driver as all, as it gets its values from MSRs and not I/O
ports.

--=20
Jean Delvare
