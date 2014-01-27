From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ACPI: Flag use of ACPI and ACPI idioms for power
 supplies to regulator API
Date: Mon, 27 Jan 2014 10:43:50 +0000
Message-ID: <20140127104350.GV11727@sirena.org.uk>
References: <1390782734-10131-1-git-send-email-broonie@kernel.org>
 <20140127092509.24844e25@endymion.delvare>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pAMbS1LL1U6QDnK3"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:59958 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310AbaA0KoD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jan 2014 05:44:03 -0500
Content-Disposition: inline
In-Reply-To: <20140127092509.24844e25@endymion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linaro-kernel@lists.linaro.org, Guenter Roeck <linux@roeck-us.net>


--pAMbS1LL1U6QDnK3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2014 at 09:25:09AM +0100, Jean Delvare wrote:
> On Mon, 27 Jan 2014 00:32:14 +0000, Mark Brown wrote:

> > control at all. This means that if for some reason the regulator API is
> > enabled on such a system it should assume that any supplies that devices
> > need are provided by the system at all relevant times without any software
> > intervention.

> > Tell the regulator core to make this assumption by calling
> > regulator_has_full_constraints(). Do this as soon as we know we are using

> I think it makes sense to have this included in stable kernel trees?

Yes, that should be safe.

--pAMbS1LL1U6QDnK3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5jhjAAoJELSic+t+oim9VbgP/AmYCdNzyojY6ZXcsiyr6YWh
tTcMWbkpSzJII+2pG2tBajRP3aSjQCpp6GRAsqkiSKhtuu0m/4kKkpR82DTwy+7P
rF1qTnuT7D0R1e+lAvVFU6cVoZRyBu/A12Gk9Wpb9+IjOZHQO2gbLOcxTprBLibU
C7F96/X3yt6Vi3b24hWVZ3QZcfY/vOzUnKKkRUdVMVGC7uM4gmKLYwxCam4nhaJl
N1IR52pajPbjJExVGycpflWFG+uBiZqWLtDhNdcIpERhDlLDZwZN+9vl/xPjVW3v
zdQj9Q2uiKiOtl9n/oGRa9PExxnPBfbiZQ2cTtth+OW0t3vqmetGx9G2neocERFl
WHPTpPzaMgnDwvVCExBgsJ9U/FjamCgMStCbiR21PUxXgzAohZ8DEr9lsHfTc87C
KxZlC0OAo5g41+q5+dZi+Ph1AhtJeje0KpsECmOPkvsQvmbv5zDxkMOKHke4IisO
ERgf3rR5STcVp1i6xL2TGIEw2jyJitNQFfuWRg8G6n5RN6PEIis9RG5rEcNB2fTK
CiwBWolj5LFnDGToNSdIyU78t5b3qlT2WnCKwUjq35+VEbeE/rnn6ZPVVGADIjAV
4LLpkoTKkeUvQLBqEB59Uw+7vZE2x2REgv4c3T1eOAHq4oEaDmluek6BWAXqYyF8
snnVlvRFToPY7QfhuYuw
=HAGY
-----END PGP SIGNATURE-----

--pAMbS1LL1U6QDnK3--
