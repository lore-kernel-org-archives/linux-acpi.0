From: "narin" <narin_007-YSGFQ8SKJZVDPfheJLI6IQ@public.gmane.org>
Subject: Not send any mail to me anymore
Date: Fri, 22 Oct 2004 17:46:49 +0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1098442009.c75c4c3cnarin_007@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org



-----Original Message-----
From: acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Date: Wed, 06 Oct 2004 10:53:33 -0700
Subject: Acpi-devel digest, Vol 1 #2096 - 14 msgs

Send Acpi-devel mailing list submissions to
=09acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

To subscribe or unsubscribe via the World Wide Web, visit
=09https://lists.sourceforge.net/lists/listinfo/acpi-devel
or, via email, send a message with subject or body 'help' to
=09acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

You can reach the person managing the list at
=09acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Acpi-devel digest..."


Today's Topics:

   1. what is throttling? (Keld =3D?iso-8859-1?Q?J=3DF8rn?=3D Simonsen)
   2. Re: Acer Travermate 8005 and battery info (Sergey Vlasov)
   3. Re: what is throttling? (Dominik Brodowski)
   4. Re: DSDT on suse 9.1 (George Barnett)
   5. Re: what is throttling? (Andi Kleen)
   6. Re: smartbattery support (Pedro Venda)
   7. =3D?iso-8859-1?Q?acpid_and_kacpid?=3D (=3D?iso-8859-1?Q?xavier.sineco=
sa?=3D)
   8. Re: [SoftwareSuspend-devel] status update for current development on =
ASUS M2N (Georg C. F. Greve)
   9. Re: what is throttling? (Ville =3D?iso-8859-1?Q?Syrj=3DE4l=3DE4?=3D)
  10. Re: what is throttling? (Bruno Ducrot)
  11. Re: what is throttling? (Andi Kleen)
  12. Re: what is throttling? (Bruno Ducrot)
  13. Students email list (Tom Theroux)
  14. RE: IASL bug with big constants? (Moore, Robert)

--__--__--

Message: 1
Date: Wed, 6 Oct 2004 11:04:08 +0200
From: Keld =3D?iso-8859-1?Q?J=3DF8rn?=3D Simonsen <keld-6PR53cSIHaE@public.gmane.org>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: [ACPI] what is throttling?

Hi!

I have googled around for a couple of hours to find out precisely what
throttling means. I did it before and found some useful information, but
this time I did not find the relevant data.

I would like to find out, which state precisely that the CPU enters when
throttling. Maybe it is different from CPU to CPU. Specifically I would
like to know if the CPU is completely powered off, my recollection of
some information I have seen earlier is that this may be the case.

And where is throttling done in the kernel?

Best regards
Keld


--__--__--

Message: 2
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
From: Sergey Vlasov <vsu-u2l5PoMzF/Uox3rIn2DAYQ@public.gmane.org>
Date: Wed, 6 Oct 2004 13:46:10 +0400
Subject: [ACPI] Re: Acer Travermate 8005 and battery info

On Tue, 05 Oct 2004 16:42:09 +0100 Pedro Venda wrote:

> Pavel Machek wrote:
> > Hi!
> >=20
> >=20
> >>|>>Search maillist archives, look up "smart battery specification" in
> >>google.
> >>|>>If you are willing to spend few days writing driver, let me know.
> >>|>
> >>|>Ive checked out some specs now and Im willing to give it a shot but=
=20
> >>Ive
> >>|>no idea on where to start.. Ive checked out my DSL and I find=20
> >>nothing
> >>|>containing SBS in it. Suggestions?
> >>|
> >>|
> >>| Right start probably is drivers/i2c. I collected these links:
> >>
> >>i'm willing to participate also. but first, let me see if i
> >>understood... the first step should be building a driver to=20
> >>communicate
> >>with the smbus via i2c. am i right?
> >=20
> >=20
> > I believe that smbus is subset of i2c... So first step would be
> > "make it talk with smart battery over i2c".
> >=20
> > Anyway I may be wrong. You'll know for sure when the patch starts
> > working :-).
>=20
> sometime in the not-so-near future :-)
>=20
> i'll start studying i2c to find out the smbus "address" (sorry if this=20
> is a dumb mistake) and try to scan it for the smart battery.

Some code already exists - the lm_sensors package
(http://secure.netroedge.com/~lm78/) includes the "smartbatt" module.
However, it is for 2.4.x kernels, therefore some porting work will be
needed to use it on 2.6.x.

SMBus controller drivers already exist for most chipsets - see
drivers/i2c/busses/.



--__--__--

Message: 3
Date: Wed, 6 Oct 2004 12:05:04 +0200
From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
To: Keld =3D?iso-8859-1?Q?J=3DF8rn?=3D Simonsen <keld-6PR53cSIHaE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] what is throttling?

On Wed, Oct 06, 2004 at 11:04:08AM +0200, Keld J=3DF8rn Simonsen wrote:
> Hi!
>=3D20
> I have googled around for a couple of hours to find out precisely what
> throttling means. I did it before and found some useful information, bu=
=3D
t
> this time I did not find the relevant data.
>=3D20
> I would like to find out, which state precisely that the CPU enters whe=
=3D
n
> throttling. Maybe it is different from CPU to CPU. Specifically I would
> like to know if the CPU is completely powered off, my recollection of
> some information I have seen earlier is that this may be the case.
>=3D20
> And where is throttling done in the kernel?

It's managed in the ACPI processor module. Specific, extensive documentat=
=3D
ion
will be added to the ACPI HOWTO soon.

=09Dominik


--__--__--

Message: 4
Date: Wed, 06 Oct 2004 12:05:15 +0100
From: George Barnett <george-OvXvXIFG8FfYkQIYctQFYw@public.gmane.org>
To:  acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] DSDT on suse 9.1

George Barnett wrote:

> I have the modified .asl file - what switches should I feed to iasl to=20
> get the correct output?  -tc seems to give hex, which I dont believe is=
=20
> what I want?

Hi,

Ignore me.  I managed to get this asl file compiled to hex and it spewed=20
the same errors as the dsdt already installed with my distro of linux.

The powersaving mostly works and I dont think I'm going to get much=20
better.  I'm not too worried about suspend.

Cheers,

George

--=20
George Barnett
Reality Engineer & Explorer

e: george-OvXvXIFG8FfYkQIYctQFYw@public.gmane.org
m: +44 778 884 7205

Things must be as they may
       - William Shakespeare, Henry V


--__--__--

Message: 5
Date: Wed, 6 Oct 2004 13:49:35 +0200
From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
To: Keld J?rn Simonsen <keld-6PR53cSIHaE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] what is throttling?

On Wed, Oct 06, 2004 at 11:04:08AM +0200, Keld J?rn Simonsen wrote:
> Hi!
>=20
> I have googled around for a couple of hours to find out precisely what
> throttling means. I did it before and found some useful information, but
> this time I did not find the relevant data.
>=20
> I would like to find out, which state precisely that the CPU enters when
> throttling. Maybe it is different from CPU to CPU. Specifically I would
> like to know if the CPU is completely powered off, my recollection of
> some information I have seen earlier is that this may be the case.

On Intel CPUs Throttling means that the CPU skips each other
(or more) clock. This is quite slow, but only done to get=20
the temperature down.

AMD CPUs don't have it afaik.

-Andi


--__--__--

Message: 6
Date: Wed, 06 Oct 2004 12:52:18 +0100
From: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>
To: Christian Axelsson <smiler-pw/8oln/LLv0Dx+PQ6IoOQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] smartbattery support

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Christian Axelsson wrote:
| Pedro Venda wrote:
|
|> i read some things also, but i disagree with christian. i think that
|> smbus patch is not the way to go. don't get me wrong! i'm also just
|> scratching the surface. for what i read, those patches put smbus bios
|> support into the kernel.
|
|
| yep

sorry... do you agree or not? i meant that we should be creating an i2c
module to talk specifically to the smart battery independently of the
bios...

|
|> 1. is this a "sensor" i2c driver? i mean, should we find help with the
|> lmsensors team? there are some debugging tools for i2c developed by
|> the lm-sensors people (i guess). this document
|> (http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/chips/SUMMARY)
|> refers some smartbattery support, but i don't think it solves our
|> problem.
|
|
| I cant get the detect-thingies to see any i2c-bus and Im not aware of
| any sensorchip in my laptop (but I would be happy to be proven wrong).
|

again i should have explained myself better... my laptop can see 5
busses... although i cannot yet interpret that information well. anyway,
what i wanted to ask was: should we be using some of the sensors code?

|> 2. what exactly should the i2c driver do? should it just know the
|> smartbattery address and ask generic questions made by userland
|> programs? or should it do all the work and retrive charge rates and
|> capacity information and such?
|
|
| I think it should publish as much generic info (info thats avaible on
| all smartbatteries) as possible into sysfs.

agree. then useland programs could use that information. but i see a
pitfall here... if it is so, how will it be hooked into ACPI?

[]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBY9xyeRy7HWZxjWERAtW9AKCI/UBkin8Q+U/xiYAuX/Vkv0adogCeLsH6
t1/108wqCrKYGP6bRWrWwXc=3D
=3D54Fs
-----END PGP SIGNATURE-----


--__--__--

Message: 7
Date: Wed,  6 Oct 2004 14:26:39 +0200
From: "=3D?iso-8859-1?Q?xavier.sinecosa?=3D" <xavier.sinecosa-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
To: "=3D?iso-8859-1?Q?acpi-devel?=3D" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Subject: [ACPI] =3D?iso-8859-1?Q?acpid_and_kacpid?=3D

Hello, and sorry to bother you concerning maybe =3D0D=3D0Aobvious questions=
 f=3D
or you but I haven't found yet =3D0D=3D0Ainformation, so I would be very pl=
ea=3D
sed if someone =3D0D=3D0Acan enlighten me!=3D0D=3D0A=3D0D=3D0AI compiled ke=
rnel 2.6.8=3D
 with RH9 distribution. =3D0D=3D0A=3D0D=3D0AI have kacpid daemon already ru=
nning.=3D
 Does acpid =3D0D=3D0Apackage from sourceforge (latest version acpid-1.0.=
=3D0D=3D0A=3D
3.tar.gz) conflict with kacpid ? What are the =3D0D=3D0Adifferences between=
 t=3D
hese two processes ?=3D0D=3D0A=3D0D=3D0AI installed acpid-1.0.2-fr1.i386.rp=
m  and=3D
 acpid =3D0D=3D0Aappears in ntsysv service list, while it doesn't =3D0D=3D0=
Awhen =3D
I install acpid-1.0.3.tar.gz. Is the =3D0D=3D0Adifference between these 2 i=
ns=3D
tallation only =3D0D=3D0Asomething like "chkconfig --add acpid" ?=3D0D=3D0A=
=3D0D=3D0A=3D
Thank you, Xavier.=3D0D=3D0A=3D0D=3D0A



--__--__--

Message: 8
To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        SoftwareSuspend-Devel <softwaresuspend-devel-0fE9KPoRgkgATYTw5x5z8w@public.gmane.org>
From: "Georg C. F. Greve" <greve-mXXj517/zsQ@public.gmane.org>
Date: Wed, 06 Oct 2004 12:22:43 +0200
Subject: [ACPI] Re: [SoftwareSuspend-devel] status update for current devel=
opment on ASUS M2N

--20041006122243+0200-3026523736900844-7630649

 || On Wed, 06 Oct 2004 09:44:23 +1000
 || Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org> wrote:=20

 >> When kdb is left and the buffer is different from 0, the contents
 >> are dumped to dmesg/syslog.

 nc> Something like printk :> It wouldn't work with suspending because
 nc> we're overwriting such buffers when copying the original kernel
 nc> back (with the contents from suspend-time). Furthermore, it won't
 nc> help if you get such a crash because you're never going to start
 nc> syslogd and get the data written.

I agree that it would not help in all cases.

In this case it would have helped, though. The machine is running,
syslog is doing its job -- that is how I got the sysrq-T output.

So if kbd had support for that, we could have saved ourselves the
trouble of taking a photograph of the screen and mailing that around.

Speaking of which: Since you told me that you did not see it, I just
resent it, please let me know whether it reaches you this time.

Regards,
Georg

--=20
Georg C. F. Greve                                       <greve-mXXj517/zsQ@public.gmane.org>
Free Software Foundation Europe=09                 (http://fsfeurope.org)
Brave GNU World=09                           (http://brave-gnu-world.org)

--20041006122243+0200-3026523736900844-7630649
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBY8dzbvivwoZXSsoRAiXXAKC2FFo4xcjvzNH80eMgclCQ2pG/LgCeN41H
V/A+S8HWcHSd3uNZz4Bk2EQ=3D
=3D7Yty
-----END PGP SIGNATURE-----
--20041006122243+0200-3026523736900844-7630649--


--__--__--

Message: 9
Date: Wed, 6 Oct 2004 16:21:48 +0300
From: Ville =3D?iso-8859-1?Q?Syrj=3DE4l=3DE4?=3D <syrjala-ORSVBvAovxo@public.gmane.org>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] what is throttling?

On Wed, Oct 06, 2004 at 01:49:35PM +0200, Andi Kleen wrote:
> On Wed, Oct 06, 2004 at 11:04:08AM +0200, Keld J?rn Simonsen wrote:
> > Hi!
> >=3D20
> > I have googled around for a couple of hours to find out precisely wha=
=3D
t
> > throttling means. I did it before and found some useful information, =
=3D
but
> > this time I did not find the relevant data.
> >=3D20
> > I would like to find out, which state precisely that the CPU enters w=
=3D
hen
> > throttling. Maybe it is different from CPU to CPU. Specifically I wou=
=3D
ld
> > like to know if the CPU is completely powered off, my recollection of
> > some information I have seen earlier is that this may be the case.
>=3D20
> On Intel CPUs Throttling means that the CPU skips each other
> (or more) clock. This is quite slow, but only done to get=3D20
> the temperature down.
>=3D20
> AMD CPUs don't have it afaik.

My AMD system (Duron 1300 + Abit KT7) can be throttled by 50%. In reality=
=3D
=3D20
it feels more like 90% since even a temperature/fan monitor applet eats=3D2=
0
15% of my CPU when throttled. I haven't seen any benefits from throttling=
=3D
=3D20
though.

--=3D20
Ville Syrj=3DE4l=3DE4
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/


--__--__--

Message: 10
Date: Wed, 6 Oct 2004 16:12:45 +0200
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] what is throttling?
From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>

On Wed, Oct 06, 2004 at 01:49:35PM +0200, Andi Kleen wrote:
> AMD CPUs don't have it afaik.

ducrot@poupoune:~$ cat /proc/acpi/processor/CPU1/throttling=20
state count:             8
active state:            T0
states:
   *T0:                  00%
    T1:                  12%
    T2:                  25%
    T3:                  37%
    T4:                  50%
    T5:                  62%
    T6:                  75%
    T7:                  87%
ducrot@poupoune:~$ uname -m
x86_64

though I don't see real usefullness for throttling anyway, so
I've not tested if that works.

Cheers,

--=20
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


--__--__--

Message: 11
Date: Wed, 6 Oct 2004 16:23:58 +0200
From: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] what is throttling?

On Wed, Oct 06, 2004 at 04:12:45PM +0200, Bruno Ducrot wrote:
> On Wed, Oct 06, 2004 at 01:49:35PM +0200, Andi Kleen wrote:
> > AMD CPUs don't have it afaik.
>=20
> ducrot@poupoune:~$ cat /proc/acpi/processor/CPU1/throttling=20
> state count:             8
> active state:            T0
> states:
>    *T0:                  00%
>     T1:                  12%
>     T2:                  25%
>     T3:                  37%
>     T4:                  50%
>     T5:                  62%
>     T6:                  75%
>     T7:                  87%
>=20
> though I don't see real usefullness for throttling anyway, so
> I've not tested if that works.

Indeed. It seems to work different from the Intel implementation
though, it doesn't skip clocks.

It's only useful to prevent your machine from melting when the=20
fan fails or someone misdesigns the cooling setup.

-Andi


--__--__--

Message: 12
Date: Wed, 6 Oct 2004 17:56:44 +0200
To: Andi Kleen <ak-l3A5Bk7waGM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: [ACPI] what is throttling?
From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>

On Wed, Oct 06, 2004 at 04:23:58PM +0200, Andi Kleen wrote:
> It's only useful to prevent your machine from melting when the=20
> fan fails or someone misdesigns the cooling setup.
>=20

Indeed, but I forgot to say that machine will use powernow-k8
in that case.

--=20
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


--__--__--

Message: 13
From: Tom Theroux <bhavani-SDUOzxK1X8w@public.gmane.org>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Date: Wed, 06 Oct 2004 16:47:21 +0000
Subject: [ACPI] Students email list

This is a multi-part message in MIME format.

------=3D_NextPart_000_0000_439AB860.C58BF69B
Content-Type: multipart/alternative;
    boundary=3D"----=3D_NextPart_001_0001_4153473D.F9253BF5"


------=3D_NextPart_001_0001_4153473D.F9253BF5
Content-Type: text/plain; charset=3Diso-8859-1
Content-Transfer-Encoding: 7bit

Are you targeting the student sector? Do you want students to buy your prod=
uct or visit your website?

Our company has carefully collected an email database, which allows to adve=
rtise your product or=20
service to the audience of 1.7 million US college & university students! Th=
is is the most comprehensive
students email database available on the Internet.=20

All addresses on the database belong to students (18-24 years old), are ver=
ified and as a proof of
their origin end with '.edu', which stands for educational institutions.

The database will be delivered to you in a ZIP archive of a 34MB TXT file.=
=20
All addresses were collected in September, 2004.

The price we are asking is $370. To place an order please proceed to:

Mirror 1: http://www.nsshost.com/edu.php
Mirror 2: http://www.bbehost.com/edu.php

Sincerely,
Tom Theroux


_____________________________________________________=20
To change your mail preferences, go here: http://www.nsshost.com/out.htm
_____________________________________________________=20


------=3D_NextPart_001_0001_4153473D.F9253BF5
Content-Type: text/html; charset=3Diso-8859-1
Content-Transfer-Encoding: 7bit

<body>
<html>
<CENTER>
<TABLE cellSpacing=3D0 cellPadding=3D0 width=3D600 align=3Dcenter border=3D=
0>
  <TBODY>
  <TR>
    <TD>
      <P>
Are you targeting the student sector? Do you want students to buy your prod=
uct or visit your website?<br><br>

Our company has carefully collected an email database, which allows to adve=
rtise your product or=20
service to the audience of 1.7 million US college & university students! Th=
is is the most comprehensive
students email database available on the Internet. <br><br>

All addresses on the database belong to students (18-24 years old), are ver=
ified and as a proof of
their origin end with '.edu', which stands for educational institutions.<br=
><br>

The database will be delivered to you in a ZIP archive of a 34MB TXT file. =
<br>
All addresses were collected in September, 2004.<br><br>

The price we are asking is $370. To place an order please proceed to:<br><b=
r>

Mirror 1: <a href=3D"http://www.nsshost.com/edu.php">http://www.nsshost.com=
/edu.php</a><br>
Mirror 2: <a href=3D"http://www.bbehost.com/edu.php">http://www.bbehost.com=
/edu.php</a><br><br>

Sincerely,<br>
Tom Theroux
<br><br><br>
_____________________________________________________ <br>
To change your mail preferences, go here: <a href=3D"http://www.nsshost.com=
/out.htm">http://www.nsshost.com/out.htm</a><br>
_____________________________________________________=20

</P></TD></TR></TBODY></TABLE></CENTER></BODY></HTML>


------=3D_NextPart_001_0001_4153473D.F9253BF5--



------=3D_NextPart_000_0000_439AB860.C58BF69B--
=20


--__--__--

Message: 14
Subject: RE: [ACPI] IASL bug with big constants?
Date: Wed, 6 Oct 2004 10:47:53 -0700
From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: "Greg Alexander" <gre-VobwYXd2LmVM656bX5wj8A@public.gmane.org>, <acpi-devel-5NWGOfrQmneRv+LV9MX5uv+2+P5yyue3@public.gmane.org=
t>


Yes, it's a bug in the compiler.  I tested it, but did not run into the
problem until later.

I am having some trouble getting the new version of the compiler posted
to the web site, but I will send you a new version directly.

Bob


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Greg Alexander
> Sent: Saturday, October 02, 2004 10:13 AM
> To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: [ACPI] IASL bug with big constants?
>=3D20
> Hi -
>=3D20
> I hope this hasn't already been addressed.  I skimmed the logs and the
> buggy version appears to still be on Intel's site...
>=3D20
> I see the trouble in constants in OperationRegions generally getting
> cut to one-byte.  i.e.:
>=3D20
> ---
> DefinitionBlock ("DSDT.aml", "DSDT", 1, "VIA", "VIA_K7", 4096)
> {
>     ....
>     OperationRegion (M4D0, SystemMemory, 0x04D0, 0x0B)
>     Field (M4D0, ByteAcc, NoLock, Preserve)
>     {
>         ....
>     }
> }
> ---
>=3D20
> when I assembled then disassembled that with the 20040715 version of
> iasl, I got:
>=3D20
> ---
> DefinitionBlock ("DSDT.aml", "DSDT", 1, "VIA", "VIA_K7", 4096)
> {
>     ....
>     OperationRegion (M4D0, SystemMemory, 0xD0, 0x0B)=09/* should be
0x04D0
> */
>     Field (M4D0, ByteAcc, NoLock, Preserve)
>     {
>         ....
>     }
> }
> ---
>=3D20
> Note the 0xD0 where 0x04D0 is expected!  My laptop manufacturer put
> NVRAM at 0x4D0.  They did not put it at 0xD0.
>=3D20
> I tracked it down to the following code in
> acpica/compiler/aslopcodes.c line 209 in OpcSetOptimalIntegerSize(),
> at the very beginning:
>=3D20
> ---
>     if (Op->Asl.Parent &&
>         Op->Asl.Parent->Asl.Parent &&
>         (Op->Asl.Parent->Asl.Parent->Asl.ParseOpcode =3D3D=3D3D
> PARSEOP_DEFINITIONBLOCK))
>     {
>         return 0;
>     }
> ---
>=3D20
> The parent is the OperationRegion, the parent's parent is the
> DefinitionBlock, so it doesn't generate a size for the opcode.
> So it gets the default from aslmap.c line 520:
>=3D20
>    /* INTEGER */ OP_TABLE_ENTRY (AML_BYTE_OP, 0, 0,
ACPI_BTYPE_INTEGER),
>=3D20
> It defaults to a byte!  I looked in the changelog and I suspect this
> corresponds to the following entry:
>=3D20
>    Eliminated optimization messages for "_T_x" objects and small
>    constants within the DefinitionBlock operator.
>=3D20
> Why don't you want to optimize small constants within the
> DefinitionBlock operator?  Why only when it's nested?  Why not test a
> change at least once before sending it to customers?  Since the
> change is both broken and meaningless to me, I simply removed the
> offending piece of code and now OpcSetOptimalIntegerSize() does its
> job appropriately and my DSDT works.  If we really don't want to
> optimize them, perhaps we should set a better default, like
> AML_DWORD_OP?
>=3D20
> This is a MOST frustrating bug to track down -- I had so little faith
> in my BIOS vendor that I thought they had enough non-standard crap
> jammed in there that recompiling my DSDT was expected to fail.
>=3D20
> Sure takes the joy out of bashing the Microsoft compiler.
>=3D20
> Nonetheless, thanks for the tools.  I never could have fixed my laptop
> without iasl.
>=3D20
>=3D20
> Cheers,
> - Greg
>=3D20
>=3D20
> -------------------------------------------------------
> This SF.net email is sponsored by: IT Product Guide on
ITManagersJournal
> Use IT products in your business? Tell us what you think of them. Give
us
> Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out
> more
> http://productguide.itmanagersjournal.com/guidepromo.tmpl
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel



--__--__--

_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


End of Acpi-devel Digest





-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
