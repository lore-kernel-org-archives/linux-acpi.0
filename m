From: Rudolf Marek <r.marek@assembler.cz>
Subject: Re: Linux 2.6.25 (coretemp reads high temperatures)
Date: Wed, 30 Apr 2008 00:14:12 +0200
Message-ID: <48179DB4.8040701@assembler.cz>
References: <e85b9d30804180837y39c52e26i588e4b67c87a5e9d@mail.gmail.com>	<200804182151.49021.lenb@kernel.org>	<200804231143.10875.maximlevitsky@gmail.com>	<1209406784.11608.15.camel@localhost>	<1209474423.1784.837.camel@queen.suse.de> <20080429170824.09540206@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753059AbYD2WOl@vger.kernel.org>
In-Reply-To: <20080429170824.09540206@hyperion.delvare>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>, Maxim Levitsky <maximlevitsky@gmail.com>
Cc: trenn@suse.de, Kasper Sandberg <lkml@metanurb.dk>, Len Brown <lenb@kernel.org>, Matthew <jackdachef@gmail.com>, linux-acpi@vger.kernel.org, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, "Zhang, Rui" <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

I already answered this thread while ago. I can just confirm what Jean =
told.

>>>> I confirm this.
>>>> I *know* that temperatures reported now are wrong.
>=20
> And how do you know? The newly reported temperatures could be correct
> and the previous ones were incorrect (that's actually the case.) The
> thing is, the temperature is stored as a relative value in the CPU.
> Relative to what, depends on the CPU model, can be 85=B0C or 100=B0C.=
 Up to
> kernel 2.6.24 we had a set of rules to find out, in 2.6.25 we have a
> presumably better heuristic. So some people have seen their CPU
> temperature climb by 15=B0C and others drop by 15=B0C, that's expecte=
d.

Yes exactly. I decided to move to 0-100C scale, and move the limit too.
Of course some users with too low jumped to better scale some like you =
seems to
complain now.

>>> i have watercooling, and well :P when i touch the "tube", its norma=
l
>>> room temperature, and believe me, i would notice if it was 45.. thi=
s is
>>> with my cpu at idle - at full load on all 4 cores, temp2 says 35, a=
nd
>>> ~60 on coretemp, and THIS i would surely be able to notice over roo=
m
>>> temp :)
>=20
> The coretemp driver reports the CPU _core_ temperature. That's not
> something you can touch, believe me (unless you are an electron.)
>=20
> Also note that the CPU temperature reported by the IT8718F may or may
> not match the reality. To make sure, you'd need to know the type of
> thermal diode expected by the IT8718F, the type of thermal diode in
> your CPU, compute the correction factor if there is one. And you'd ne=
ed
> to know where the thermal diode is exactly. It is most certainly buil=
t
> into the CPU, but some motherboard makers are doing weird things.
>=20
> 22=B0C seems very low to me, even for water-cooling. Note that
> non-linearity of thermal diodes makes measurements inaccurate as they
> get away from the expected operating point. I guess that thermal diod=
es
> used in CPUs are calibrated for best results around the expected
> temperature when using air-cooling, rather than water-cooling.
>=20
>>> any progress on this bug?
>=20
> I still need to be convinced that there is a bug here.

It is not a bug, a max limit changed too, it is just matter how to scal=
e it. The
temperature is non-physical so comparing it to physical temperature doe=
s not
make any sense. I'm sorry I did not invent this relative temp stuff - C=
omplain
@intel. They have some calibration of TjMAX for mobiles, but this bit d=
oes not
work for desktops/servers. I tried really hard to get at LEAST some
documentation so the driver looks like it looks. And not
guessed/guessed/guessed/how it looked earlier.

>=20
>>>> The reason is that bios did report same temperatures as coretemp i=
n 2.6.24,
>>>> moreover some time ago I have run a cpu tool (don't remember its n=
ame) on windows

It was most likely coretemp - I'm in contact with the guy. We share inf=
os.

>>>> temperature of both cores
>>>> (I had to run this on windows - intel haven't released=20
>>>> drivers for their QST for temperature monitoring from bios - very =
sad)
>>>>
>>>> And the driver did say in kernel log that TJMAX is 85C
>=20
> Which driver, which kernel? As I wrote above, the coretemp heuristic
> changed in kernel 2.6.25, so the fact that a previous kernel was
> reporting a different tjmax value is irrelevant. Unless you have
> additional documentation from Intel, I would tend to believe that the
> coretemp driver in 2.6.25 is correct. But feel free to report the exa=
ct
> CPU model you have (with CPUID info) to Rudolf, if he gets enough
> reports about a specific CPU model which most people believe gets the
> wrong tjmax, he can fix the driver.

Well again, I tried hard at Intel and I really could not get any info o=
n some
calibration bit. The temperature is non-physical on arbitrary scale. I =
changed
that so for some people it jumped to 100C, for some it remained.

>>>> Lets at least make a kernel option to override tjmax?
>=20
> That's a possibility for sure, but what we would really need is to
> adjust the coretemp driver heuristics to always get it right - if
> that's not already the case, that is. I'll let Rudolf decide anyway.

Well again, Intel swears there is no way how to get the TjMAX for
desktops/servers. It sucks but this is not my fault.

Thanks,
Rudolf






-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFIF5203J9wPJqZRNURAnFSAKC3GpafvkviWggGJPG2o71R4lel0wCgirnW
Cr2RidnTZEdKTAj8yEviR0U=3D
=3DlFMk
-----END PGP SIGNATURE-----
