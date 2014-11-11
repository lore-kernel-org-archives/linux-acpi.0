From: Mark Brown <broonie@kernel.org>
Subject: Re: [Linaro-acpi] [PATCH v10 1/1] Mailbox: Add support for Platform
 Communication Channel
Date: Tue, 11 Nov 2014 17:29:55 +0000
Message-ID: <20141111172955.GA3815@sirena.org.uk>
References: <1415371964-4451-1-git-send-email-ashwin.chaugule@linaro.org>
 <1415371964-4451-2-git-send-email-ashwin.chaugule@linaro.org>
 <5461E548.2040204@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CB6sVB09WZeKI1Ay"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33605 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbaKKRb0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Nov 2014 12:31:26 -0500
Content-Disposition: inline
In-Reply-To: <5461E548.2040204@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ashwin Chaugule <ashwin.chaugule@linaro.org>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "arnd@arndb.de" <arnd@arndb.de>, "patches@linaro.org" <patches@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lv.zheng@intel.com" <lv.zheng@intel.com>


--CB6sVB09WZeKI1Ay
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 11, 2014 at 10:30:32AM +0000, Sudeep Holla wrote:
> On 07/11/14 14:52, Ashwin Chaugule wrote:

> >+config PCC
> >+       bool "Platform Communication Channel Driver"
> >+       depends on ACPI

> I am bit confused here, though I prefer PCC to depend on ACPI, I have
> seen discussion in this thread about using PCC without ACPI, how will
> that work ?

We can always remove the dependency when someone adds the code to talk
to non-ACPI PCC devices.

--CB6sVB09WZeKI1Ay
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYkeSAAoJECTWi3JdVIfQASMH/1Z8iViPsbH8DR4dX8T2Dr2r
H4KUOd4OMM18y0+li1CcyZiHSQGusI8HakXnQpX53WLiirro8MImdN4UTvxSf15P
gG7/OzTkZRc9pBv09ytDA4WiOULrqyLII/UKDtyroUyq2XRnFSOOpzHm5StqH7sE
73GNtZXxifUfdCihDCXYcXWCU6O1y5M+937tGJfJ/6qwPmc4EnN54ExZwKF7T65I
qG8RsPoW8EMW4xRxEE2CQLedJt/ZtHAKv/fcQTLnkgBRTgJ6LDFmj+5dvF69fkFM
llUxatQuevFbNkEbPTTs99iYislhy+9r3I+PjzYOOxnZ6nl7XGOVPT1DLptuOR4=
=fnx4
-----END PGP SIGNATURE-----

--CB6sVB09WZeKI1Ay--
