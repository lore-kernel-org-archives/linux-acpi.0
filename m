From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: Status of ACPI on IBM T40p
Date: Thu, 5 Feb 2004 08:50:08 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <571ACEFD467F7749BC50E0A98C17CDD8D5FED2@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alexander Gran <alex-4mRm4CWMOdkHuPwBo6/EyUB+6BGkLq7r@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

> Fan isn't recognized.=20
ACPI can't control fan in many IBM systems, including R40, T40. I guess
it's the same situation in your T40p.

>Power-button is recognized, but gives no events.
That's interesting; would you please give some detail info? Did it work
before? I didn't see the error in T40.

> C-states are not working right:
> The CPU has C0-C3. C0 is full speed, the rest is slower. According to
the
> ACPI
> documentation the CPU should switch automagically to the slower modes
> after
> some time of inactivaty. However it cannot controll busmaster PCI
> transfers
> in C3. Now some driver doesn't gets busmaster right, and due to this,
the
> cpu
> never go's to C3 [Hope I got this right, I am no acpi master..](my
went to
> C3
> after some fiddeling with suspend (see later) and the PCI-Bus crashed,
> hence
> I know. If my CPU uses C3, laptop_mode and backlight  mostly dimmed, I
> reached 5h+ :)
we have discussed the problem before. USB caused bus master activities.
without USB devices, my T40 can enter C3

> Other things that don't work:
> When suspending, the USB-drivers don't get it right, and do not work
after
> resuming. Unloading them before suspending and loading them afterwards
> doesn't help either. Additionally there seems to be issues with the
PCI
> bus.
> I got random errors (everything between kernel-oops, error-loops and
> warnings) when reinserting the uhci_hcd module.
I got the same error in T40. If I didn't include USB module, it went
away. So I'm not sure if it's an ACPI error.

> After resuming my power LED is not switched on (not so problematic),
and
> the
> notebook doesn't ask for a password (Really problematic).
Actually LED is not on after resuming in windows under T40, so in my
point of view, it's not severe.

> The e1000 module still needs the unload/load procedure.
>=20
> Hope I'm right on this list. Tell me If I'd cc to an other one,
please.
> Include my in your cc's please, as I'm not reading this list.
>=20
> regards
> Alex
>=20
> - --
> Some operating systems are called `user friendly',
> 	Linux however is `expert friendly'.
> Encrypted Mails welcome.
> PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID:
0x6D7DD291
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (GNU/Linux)
>=20
> iD8DBQFAIPyk/aHb+2190pERAjhgAKCkYnYnJcTJMFQc7YY4sGNWRVh4dwCgkdQX
> hAR99v74cSPS4JsYv+vuz54=3D
> =3DI96u
> -----END PGP SIGNATURE-----
>=20
>=20
>=20
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
