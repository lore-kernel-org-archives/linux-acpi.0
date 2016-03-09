From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH v2 2/2] ACPI, APEI, ERST: Fixed leaked resources in
 erst_init
Date: Wed, 9 Mar 2016 09:12:07 +0800
Message-ID: <20160309011207.GB19756@gchen-ros.bj.intel.com>
References: <1457452332-2673-1-git-send-email-johunt@akamai.com>
 <1457452332-2673-3-git-send-email-johunt@akamai.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:8982 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752660AbcCIBQi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 8 Mar 2016 20:16:38 -0500
Content-Disposition: inline
In-Reply-To: <1457452332-2673-3-git-send-email-johunt@akamai.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joshua Hunt <johunt@akamai.com>
Cc: gong.chen@intel.com, linux-acpi@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org, ying.huang@intel.com, tony.luck@intel.com, linux-kernel@vger.kernel.org


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 08, 2016 at 10:52:12AM -0500, Joshua Hunt wrote:
> Date:	Tue,  8 Mar 2016 10:52:12 -0500
> From: Joshua Hunt <johunt@akamai.com>
> To: gong.chen@intel.com, linux-acpi@vger.kernel.org, rjw@rjwysocki.net,
>  lenb@kernel.org, ying.huang@intel.com
> Cc: tony.luck@intel.com, linux-kernel@vger.kernel.org, Joshua Hunt
>  <johunt@akamai.com>
> Subject: [PATCH v2 2/2] ACPI, APEI, ERST: Fixed leaked resources in
>  erst_init
> X-Mailer: git-send-email 1.7.9.5
>=20
> erst_init currently leaks resources allocated from its call to
> apei_resources_init(). The data allocated there gets copied
> into apei_resources_all and can be freed when we're done with it.
>=20
> Signed-off-by: Josh Hunt <johunt@akamai.com>

Reviewed-by: Chen, Gong <gong.chen@linux.intel.com>


--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW33hnAAoJEI01n1+kOSLH1GIP/3J0211OtVhokJJy2fN50Zf4
T0RRy+QA9fBWjl3GpY9eqqnqUxswqeB44IO0KGUIyBisp1chGZE3Fbb8aoNPCjlu
YIg4k0lAm4EyrypyIA+DOJf3X0U0ab+o67yH8++SzaX/RejOli2t6FLxLgJM8oWt
EZz+nf/Xod0yABspZYB36muTAe0BiEdWT5+J5IffsUfythxnnR//Vf7qtKW0/XmR
NvydO8L17BZVwAUu69TvqdeFpsa/XqkBLQPTcdDjC5En6i5DEHVv/cmITOCXRSkv
Xlnnc1jvFtMU2oXpPIeHl843Zv4cPcYLVls3quaY8/VCjX/hsZqm+Y/nxiaIENxA
XhxucEOd61A5QQrXPW19YNEEllLVvTgYbzkQzUDbzSseDUK01dS5hoapsoe5KpmV
yAeCGmBD2du36uheDQakItJc8GoznFpggbkttRNTfzQ8+miy6YqHCxZkcfnFWt3c
r6svhFQivWo86YdPElqz19qX59IeC4tkX1Lbdjlzxcs6Z5I2PWLxnfgt3Jll42RL
wUfRtaEjzYRkmdKpI0sHI3j1i0G/2TVoebOSqyaPTgm25S6alk81g4wCna36xLI8
spoDHvCzL0iJtd+j/g6JdeWGfm2sVmcZPEQ04L86JMXojfVFttcm/q2Q2csp4leM
WV3nCgGSs6s5l4kKNTme
=vlud
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
