From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Re: Compaq Armada 1500c
Date: Wed, 16 Apr 2003 14:24:29 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <3ACA40606221794F80A5670F0AF15F8427228D@pdsmsx403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Florian Schilhabel <florian.schilhabel-S0/GAf8tV78@public.gmane.org>, Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Can you turn on debug option of ACPI, and collect debug message of

1). boot time=20

I'm interested in if FAN driver is initialized properly.

Thanks,
Luming

-----Original Message-----
From: Florian Schilhabel [mailto:florian.schilhabel-S0/GAf8tV78@public.gmane.org]
Sent: 2003?4?10? 19:43
To: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: Re: Re: [ACPI] Compaq Armada 1500c


"Florian Schilhabel" <florian.schilhabel-S0/GAf8tV78@public.gmane.org> schrieb am 10.04.03 =
13:17:20:
> hi everyone,
>=20
> short summary of ACPI on Compaq Armada 1500c:
> with help of herbert nachtnebel,( thanks for your dsdt's), i finally =
managed to
> disassemble and recompile my dsdt; ( 0 errors, 0 warnings, etc.pp )
> result:
> /proc/acpi is now much more populated than before... ;-))
> still weird are the entries in thermal_zone/.../trip_points;
> of course, currently i'm running on 2.4.20 ( + ACPI ) - the problem =
might be here;
> will update asap;
>=20
> i still have a problem with FAN CONTROL...
> i DO have 2 entries in /proc/acpi/fan;
> along with a state file.
> cat state gives me a "on", indicating, that the fan is running - this =
is _NOT_ true
> there is also no possibility to switch manually to off and back to on;
> battery status is now great, with one problem left:
> during system boot, the correct battery status is recognized ( for =
example 2 batteries available )
> if i pull out on battery, the acpi system still indicates 2 available =
batteries,
> of course the voltage indicator goes down to zero - good, it's no =
battery in the bay.
> but - system says, battery is still available; so there's no update at =
runtime here...
> during system boot with ONE battery, the second one is _never_ =
recognized. - too bad;
>=20
> nevertheless, at least a cat temperature seems to give me the correct =
values for CPU temp;
> at least, if i stress the CPU, the temp rises, when idle temp goes =
down.
> so there's a way for me to shut down the system, if the CPU should =
become too hot ;-))
>=20
> i think, someone's written a FAN-control patch; i just can't find it =
in mail-archive;
> would anyone please be so kind to send it to me ???
> thanks a lot....
>=20
> at last:
> if nothing helps, my final solution is to cut the wires to the fan and =
solder it to
> voltage supply of my fdd drive - *;-))
> although i have a little coding experience, i do not have enough time =
to solve that problem, sorry...
> but: if someone of the coders is interested in that problem, i can =
give you all the needed information...
>=20
> ------
>=20
> and: if you can't code it, you have to solder it... ;-))
>=20
> greetings
>=20
> florian
>=20
>=20


_________________________________________________________________________=
_____
UNICEF bittet um Spenden fur die Kinder im Irak! Hier online an
UNICEF spenden: https://spenden.web.de/unicef/special/?mc=3D021101



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The =
debugger=20
for complex code. Debugging C/C++ programs can leave you feeling lost =
and=20
disoriented. TotalView can help you find your way. Available on major =
UNIX=20
and Linux platforms. Try it free. www.etnus.com
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
