From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] ACPI / Thermal / video: fix max_level incorrect value
Date: Wed, 25 May 2016 21:49:41 -0400
Message-ID: <4305.1464227381@turing-police.cc.vt.edu>
References: <4736.1463510462@turing-police.cc.vt.edu> <CAJZ5v0jrFoQxLY_ZQrP-HP888swZbvSJPM=xNopC5MgQgnSxNg@mail.gmail.com> <6459.1463698397@turing-police.cc.vt.edu> <7208.1463713500@turing-police.cc.vt.edu> <6674547c-cefb-1b93-893a-7c5909a180a7@intel.com> <2897.1463727728@turing-police.cc.vt.edu> <20160520071720.GA30152@aaronlu.sh.intel.com> <29833.1463789712@turing-police.cc.vt.edu> <20160521032933.GA12918@aaronlu.sh.intel.com> <20160521075500.GA22025@aaronlu.sh.intel.com>
 <20160525051526.GA18305@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1464227381_2073P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound.smtp.vt.edu ([198.82.183.121]:57340 "EHLO
	omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752724AbcEZBts (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 May 2016 21:49:48 -0400
In-Reply-To: <20160525051526.GA18305@aaronlu.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

--==_Exmh_1464227381_2073P
Content-Type: text/plain; charset=us-ascii

On Wed, 25 May 2016 13:15:26 +0800, Aaron Lu said:
> Valdis, can you please give the patch a try? Thanks.

Sorry, had a few days where actual work commitments and other
things got in the way... I tested this patch against next-20160524,
and can report that the problem is fixed, so feel free to
stick a "Tested-By:" on it....

> > Reported-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
> > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > ---
> >  drivers/acpi/acpi_video.c                         | 9 ++++++---
> >  drivers/thermal/int340x_thermal/int3406_thermal.c | 2 +-
> >  include/acpi/video.h                              | 6 ++++--
> >  3 files changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> > index 3d5b8a099351..c1d138e128cb 100644
> > --- a/drivers/acpi/acpi_video.c
> > +++ b/drivers/acpi/acpi_video.c


--==_Exmh_1464227381_2073P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Exmh version 2.5 07/13/2001

iQIVAwUBV0ZWNQdmEQWDXROgAQJpyhAAmQdXKFE/spa5R6sBGz/84mHfmUv9bZHM
7WDxnAayhnbbBqAyou+u6fGIVyBQxuMy1Ybj6zZa8Hx7/0fvEHRnjMc5ChOKqFGf
nb2r7Jd3RXPo4xDMK4HqGaZgmMg8HKSd0p3EO6LR8fWd7t0EIm9W2+mhGYOC8zyb
Gja6n8Iqjbd5GjwvNX6bDV8uCQ6P3i4Kh58aS7O1f8WuFN98G4qZpv5IzbIIxOvG
ZtdrqokL+oqBNwDHUIoQr8D1mikm0us1Ta5ckmWZEsthCzjBzNpTejqPwgnyGdUV
YeQVn6ScfSiql+ezZPYOP1+OJHe5gYtDKZnKye6TMeoSXuhEI3/CIhZxa+V+zKtK
Lwfs0QnVkiAxqjqoEQI4O4m+MnA3/hEoGnC1zuHQNw2dBrDSl9jXTGig1p6Q4Xpc
feAEyNBlCzU+7v651GcaKWXdcLOxw3DXIxYA2BLwMoJ/Dw9IJEt6toQBKWPs+36x
xBZZcD1XVILS0jWFCLJ0nKB72H/Hj1P5Gk/8DIQoa6jsyUxGobDYNjuoa4c5d33Y
5I3DB6T4zxovAxfrjMHQevu9dhGo4NdG6YuPMedg5o9HzWsfRahG7kG7DeBwiabC
uscyx+mdaczqZoh/O5rHkrAKpEdkXRPTdqVsiOa02IIoDZumRNjMdsma6P37+ylx
9ipz68Jh8Ec=
=FGrA
-----END PGP SIGNATURE-----

--==_Exmh_1464227381_2073P--
