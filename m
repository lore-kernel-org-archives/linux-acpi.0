From: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Subject: Re: Re: DSDT Change (Compaq Presario 2100)
Date: Sat, 29 May 2004 13:45:47 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200405291345.51712.andre@eisenbach.com>
References: <200405280621.29874.andre@eisenbach.com> <c9am7j$nng$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_/ZPuAIwtN19D+SF";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <c9am7j$nng$1@sea.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Erik Meitner <usenet-cuDg6iFcrsRAfugRpC6u6w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--Boundary-02=_/ZPuAIwtN19D+SF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Samstag Mai 29 2004 11:53 schrieb Erik Meitner:
> > Well, tonight, while recompiling the DSDT a few times to remove warnings
> > and errors, I stumbled across this (in method SMSL
> >
> > If (0x01)
> > {
> > 	Store (\_SB.PCI0.ISA.EC0.TTDC, TRDC)
> > 	Store ("AC remove! Set Throttle Duty Cycle ---: ", Debug)
> > 	Store (TRDC, Debug)
> > 	Store (0x01, TREN)
> > }
>
> The DSDT for my laptop has the exact same code.

That piece of code is the state cange code (i.e. when you unplug the AC cor=
d).=20
There is another place you need to change, which initializes the behaviour=
=20
when you boot with the power cable already unplugged.

The method is _REG. Here is the code

                                Store (0x01, \_SB.PCI0.PMU.CRUN)
                                If (0x01)
                                {
                                    Store (\_SB.PCI0.ISA.EC0.TTDC, TRDC)
                                    Store (0x01, TREN)
                                }

Once again change "If (0x01)" to "If (0x00)".

> > In any case, I changed "If (0x01)" to "If (0x00)" and voila, I am typing
> > this email from KDE with the power cord unplugged - no slowdown at all.
>
> I have verified that this works for my machine also.

Thats great news!

> Am I correct in assuming that TREN is "Throttle Enable"(boolean value)
> and TRDC is "Throttle Duty-cycle"? What other TRDC values might make
> sense other than 0x0 ?

I think you're right about TREN and TRDC.=20
That method of throttling the CPU is not a good method apparently. It also=
=20
doesn't save battery (at least for me). Instead, use "PowerNOW" if you have=
=20
an AMD chip. It's built into the 2.6+ kernels (cpufreq) and works like a=20
champ for me.  And unlike the DSDT based throtteling, you can control it!

Cheers,
    Andr=E9

--Boundary-02=_/ZPuAIwtN19D+SF
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAuPZ/5DBE808V5icRAvLgAKCIgxYCKePQdcMgnL8+sMId16VGUACfaK1t
4M9T+M7sGWizhTJBbj69WJg=
=dwzB
-----END PGP SIGNATURE-----

--Boundary-02=_/ZPuAIwtN19D+SF--


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
