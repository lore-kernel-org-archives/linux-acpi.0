From: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7BvVK+yQ3ZXh@public.gmane.org>
Subject: Re: Fix wake GPE enabling
Date: Thu, 8 Apr 2004 08:45:21 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040408064521.GA7674@dominikbrodowski.de>
References: <37F890616C995246BE76B3E6B2DBE055442912@orsmsx403.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <37F890616C995246BE76B3E6B2DBE055442912-sBd4vmA9Se7vCEQmvpVV9VDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 07, 2004 at 02:34:43PM -0700, Moore, Robert wrote:
>=20
> No, this does not fit the model correctly.
>=20
> It is the responsibility of the upper software to selectively enable the
> devices which are to be used for wakeup.  This is one of the functions
> of the AcpiGpeEnable interface.  The ACPI CA core cannot just blindly
> enable all "wake" GPEs.

However, the ACPI subsystem, and I do not care whether it is the CA core or
any other part, currently does not enable any(!) wake GPEs.

-> wake_enable is not touched directly,
-> events/evgpeblk.c does not care, and according to your opinion, should
   not care.
-> acpi_enable_gpe is _only_ called by drivers/acpi/ec.c, which means it is
   _not_ called for buttons, which are very clearly needed in most cases to
   wake up a system.

At least for buttons, the ACPI subsystem should enable their wake
functionality, e.g. the wake GPEs, unconditionally. Having to manually enter
"echo powerbutton > /proc/acpi/wakeup_devices", as the patch in bug #1415
suggests, seems to be overly complicated. However, having this file as
override might be a valid option, I agree.

> The ACPI CA core simply identifies the "wake" GPEs in order to leave
> them disabled during runtime.
>=20
> Therefore, in (1) and (2) below, this is the correct behavior.  No
> "wake" GPEs are enabled.

IMHO, (2) is not correct behavior. It is a different thing to
- disable wake GPEs during runtime,
and
- mark wake GPEs as runtime GPEs, which is what the current code does.

Also, as it has been experienced by Linus, for example[*], some "wake" GPEs=
 are also useful to
have during runtime, so the code in acpi_enable_gpe() which disables a GPE
marked as "wake" is flawed. IMO it should be able to set it to both RUNTIME=
 and
WAKE, if it's runtime, enable it during runtime, if it's wake, enable it for
wakeup.

[*] And that's the reason the acpi_disable_wake_gpes_during_runtime flag is
_not_ set to true in Linux 2.6.5, in contrast to the original ACPI patch
sent out. And I'm glad it is this way: with this flag set, my notebook's
keyboard stops functioning...

	Dominik

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAdPUAZ8MDCHJbN8YRAqB0AJ9wq2idazJLo3Kccz7UKW3UF8zsaACfRoN0
HIpYDC4p1FEARjYbTYiHMcA=
=lvQ7
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
