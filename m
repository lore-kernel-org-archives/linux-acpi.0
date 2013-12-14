From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ACPI, APEI, GHES: Remove strict check for memory
 error handling
Date: Sat, 14 Dec 2013 08:42:56 -0500
Message-ID: <20131214134256.GC2823@gchen.bj.intel.com>
References: <1385363701-12387-1-git-send-email-gong.chen@linux.intel.com>
 <529463BD.3070305@linux.vnet.ibm.com>
 <20131126093136.GA27271@gchen.bj.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:10574 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753397Ab3LNOBB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Dec 2013 09:01:01 -0500
Content-Disposition: inline
In-Reply-To: <20131126093136.GA27271@gchen.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, tony.luck@intel.com, bp@alien8.de, linux-acpi@vger.kernel.org


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2013 at 04:31:36AM -0500, Chen, Gong wrote:
> Date:	Tue, 26 Nov 2013 04:31:36 -0500
> From: "Chen, Gong" <gong.chen@linux.intel.com>
> To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> Cc: tony.luck@intel.com, bp@alien8.de, linux-acpi@vger.kernel.org
> Subject: Re: [PATCH v2 1/2] ACPI, APEI, GHES: Remove strict check for
>  memory error handling
> User-Agent: Mutt/1.5.21 (2010-09-15)
>=20
> On Tue, Nov 26, 2013 at 02:32:53PM +0530, Naveen N. Rao wrote:
> > Date: Tue, 26 Nov 2013 14:32:53 +0530
> > From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> > To: "Chen, Gong" <gong.chen@linux.intel.com>, tony.luck@intel.com,
> >  bp@alien8.de
> > CC: linux-acpi@vger.kernel.org
> > Subject: Re: [PATCH v2 1/2] ACPI, APEI, GHES: Remove strict check for
> >  memory error handling
> > User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101
> >  Thunderbird/24.1.0
> >=20
> > On 11/25/2013 12:45 PM, Chen, Gong wrote:
> > >Usually SCI is employed to handle corrected error, especially
> > >for memory corrected error but in fact SCI still can be used
> > >to handle any error like memory uncorrected error even fatal
> > >error if BIOS enable it. For this kind of situation, it
> > >should be logged, too.
> > >
> > >v2 -> v1: make the event record more precisely
> > >
> > >Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> > >---
> > >  arch/x86/kernel/cpu/mcheck/mce-apei.c | 10 +++++++---
> > >  drivers/acpi/apei/ghes.c              |  3 +--
> > >  2 files changed, 8 insertions(+), 5 deletions(-)
> > >
> > >diff --git a/arch/x86/kernel/cpu/mcheck/mce-apei.c b/arch/x86/kernel/c=
pu/mcheck/mce-apei.c
> > >index de8b60a..d137ab8 100644
> > >--- a/arch/x86/kernel/cpu/mcheck/mce-apei.c
> > >+++ b/arch/x86/kernel/cpu/mcheck/mce-apei.c
> > >@@ -33,6 +33,7 @@
> > >  #include <linux/acpi.h>
> > >  #include <linux/cper.h>
> > >  #include <acpi/apei.h>
> > >+#include <acpi/ghes.h>
> > >  #include <asm/mce.h>
> > >
> > >  #include "mce-internal.h"
> > >@@ -41,14 +42,17 @@ void apei_mce_report_mem_error(int corrected, stru=
ct cper_sec_mem_err *mem_err)
> > >  {
> > >  	struct mce m;
> > >
> > >-	/* Only corrected MC is reported */
> > >-	if (!corrected || !(mem_err->validation_bits & CPER_MEM_VALID_PA))
> > >+	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
> > >  		return;
> > >
> > >  	mce_setup(&m);
> > >  	m.bank =3D 1;
> > >-	/* Fake a memory read corrected error with unknown channel */
> > >+	/* Fake a memory read error with unknown channel */
> > >  	m.status =3D MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV | 0x=
9f;
> > >+	if (corrected >=3D GHES_SEV_RECOVERABLE)
> > >+		m.status |=3D MCI_STATUS_UC;
> > >+	if (corrected >=3D GHES_SEV_PANIC)
> > >+		m.status |=3D MCI_STATUS_PCC;
> >=20
> > Hmm... so you only fill up the most basic information from the cper
> > record. In the absence of 'S', 'AR' bits, I am not sure how useful
> > this is - except for logging the error through /dev/mcelog for
> > legacy users. If that is the intent, you have my
> >=20
> > Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> >=20
> >=20
> > - Naveen
> >=20
>=20
> Thanks for your ACK. We want to record more information but you know
> UEFI/CPER is not related to MCE in essentially. So we can't figure
> out all necessary information to construct MCE record. IOW, we can
> just apply the most valuable information like physical address and
> fake other fields. From this point of view, this kind of H/W error
> event report method is still not perfect.

Hi, Boris

Will you pick up this patch in your RAS request pull?

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSrGBgAAoJEI01n1+kOSLHuzkP/3rma1KuvIZpS9Sv2Iy6nEZI
C3CMVfQqxqmkWkVujjKtYBESef7nUjmysZW93A0FtAjrBJGoMqf81LHHhvvChIzZ
vXXu1Smg/CuLpw5gmACH+39pyB4A6IA+uGZC2QCqiF0GLmTqBR4fdnaaEeD0C2wm
KIlKZUp5+aWHIL/DT+Oix8V5s+MreBxoOTTfNMm7dNPTUYNehM/U23vim7QxacVe
fzlerSm8dgSbLozHVauPqXlKtrFcVhXsTqUylUJHcfd7nkJzTo2jiQaLd2Fl7zyY
j7/rkI2lLbsS6Wscbmn25iUffZX7Ymc3cS0hXuZz2eJ4MuPlHI6HpXPJZRdVnn92
ztnuKGqBmOoFRTcK2iF0aKCMb+Plxn8TZjTuqtPpqa8GTJCJxgrZE55LUKEBRnl6
JVKU7GW9WyWUwlB1nZ9VvL8veWLXZM5WhKFl3P7leKpfrI7bBGigD1DS14tJEY5+
v/aa5pKx+FhUbaa5vlaEZyM7Tqx++afEo+BQgmaZgvx4FTgu4pv+UhVibTeIzHsK
yOnvnpfHxNI/rGqYjmgjBqjxaTz7No2ki/PCE7P9DOzEIXpx2pn09IjD7O2hpPGX
N4+KWDqiiBimfZuY8bmCY1M85j/Pmd9pPrW9/fXx7zfANi4vQVgB104GSphEjcxm
rXv9AlXKT/WuLjrSrBQ/
=X9hT
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
