From: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Subject: Re: Re: [patch 1/1] thinkpad fn+fx key driver
Date: Thu, 23 Sep 2004 14:31:07 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1095942667.5402.71.camel@sunshine>
References: <F7DC2337C7631D4386A2DF6E8FB22B300179B935@hdsmsx401.amr.corp.intel.com>
	 <20040923112457.GB1083@ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xt+Dw7Mdo3C7gxbzOEOf"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20040923112457.GB1083-+ZI9xUNit7I@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, akpm-3NddpPZAyC0@public.gmane.org, erik-aH8aFkyL5XJBDgjK7y7TUQ@public.gmane.org, ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--=-xt+Dw7Mdo3C7gxbzOEOf
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2004-09-23 at 13:24 +0200, Vojtech Pavlik wrote:
> On Thu, Sep 23, 2004 at 01:16:57AM -0400, Brown, Len wrote:

[...]

> There are several ways to make both the keyboard and ACPI keys work as
> intended:
>=20
> 1) Extend acpid to listen on all /dev/input/event keyboard devices and
>    call scripts when the keys are pressed. No change to the kernel.
>=20
> 2) Change ACPI to use the Input API, and add possibility to map ACPI
>    events in the keymap. Then have acpid listen to those.
>=20
> 3) Change ACPI to use the Input API and use the power.ko module for
>    mapping the keys to system state change actions.
>=20
> 4) Change ACPI to use the Input API and have a daemon that handles
>    all extra keys, including sound volume and application keys, possibly
>    using D-bus to send the events to the desktop environment.
>=20
> 5) Change power.ko to just generate ACPI events for the keys. Handle
>    the events via acpid.
>=20
> I probably prefer 4), although all make sense. I think 3) is only useful
> for embedded systems, because it's not configurable enough. 2) would
> probably not work when in X, because it relies on the console subsystem.

Since I am working on a project (Input Abstraction Layer) which is
exactly what Pavlik mentioned with 4) I wanted to raise my voice. It is
a daemon which can easily be enhanced by modules which are dynamically
loaded. There are going to be three different module types: Input,
output and in/output modules.

Input modules simply gather events and send them via D-Bus to clients
(for example: module for normal ACPI events).

Output modules do not gather data but can receive messages from clients
and react on these messages (for example: module for the new sony_acpi
driver).

In- & Output modules do both (for example: module for the toshiba_acpi
driver).

I'm blogging about the development on http://thesis.nouse.net. Expect a
first version within the next four weeks.

   Timo

..............................................................
Timo H=F6nig <thoenig at nouse dot net>
..................................................:: gpg ::...
Fingerprint: 0998 0ACA A1D2 2612 4D96 DD8B E03F 084B B305 4066

--=-xt+Dw7Mdo3C7gxbzOEOf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBUsIL4D8IS7MFQGYRAh2gAJ9Q9ifLVRZWB/P32YGkMRBZgDb7MACcC9NP
2thLD3uYGrcUqcMxsKOl9E8=
=pCfx
-----END PGP SIGNATURE-----

--=-xt+Dw7Mdo3C7gxbzOEOf--



-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
