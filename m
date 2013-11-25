From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH 1/2] ACPI, APEI, GHES: Remove strict check for memory
 error handling
Date: Mon, 25 Nov 2013 01:26:06 -0500
Message-ID: <20131125062606.GA15621@gchen.bj.intel.com>
References: <1385099825-31765-1-git-send-email-gong.chen@linux.intel.com>
 <20131125060823.GA2233@naverao1-tp.in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:19139 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750793Ab3KYGnf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 25 Nov 2013 01:43:35 -0500
Content-Disposition: inline
In-Reply-To: <20131125060823.GA2233@naverao1-tp.in.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: tony.luck@intel.com, bp@alien8.de, linux-acpi@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2013 at 11:38:23AM +0530, Naveen N. Rao wrote:
> Date: Mon, 25 Nov 2013 11:38:23 +0530
> From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
> To: "Chen, Gong" <gong.chen@linux.intel.com>
> Cc: tony.luck@intel.com, bp@alien8.de, linux-acpi@vger.kernel.org
> Subject: Re: [PATCH 1/2] ACPI, APEI, GHES: Remove strict check for memory
>  error handling
> User-Agent: Mutt/1.5.21 (2010-09-15)
>=20
> On 2013/11/22 12:57AM, Chen Gong wrote:
> > Usually SCI is employed to handle corrected error, especially
> > for memory corrected error but in fact SCI still can be used
> > to handle any error like memory uncorrected error if BIOS
> > enable it. For this situation, memory uncorrected error
> > should be logged as corrected error does, too.
> >=20
> > Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> > ---
> >  arch/x86/include/asm/mce.h            | 3 +--
> >  arch/x86/kernel/cpu/mcheck/mce-apei.c | 6 ++----
> >  drivers/acpi/apei/ghes.c              | 3 +--
> >  3 files changed, 4 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> > index cbe6b9e..94b263f 100644
> > --- a/arch/x86/include/asm/mce.h
> > +++ b/arch/x86/include/asm/mce.h
> > @@ -244,7 +244,6 @@ static inline void mcheck_intel_therm_init(void) { }
> >   */
> > =20
> >  struct cper_sec_mem_err;
> > -extern void apei_mce_report_mem_error(int corrected,
> > -				      struct cper_sec_mem_err *mem_err);
> > +extern void apei_mce_report_mem_error(struct cper_sec_mem_err *mem_err=
);
> > =20
> >  #endif /* _ASM_X86_MCE_H */
> > diff --git a/arch/x86/kernel/cpu/mcheck/mce-apei.c b/arch/x86/kernel/cp=
u/mcheck/mce-apei.c
> > index cd8b166..f09da48 100644
> > --- a/arch/x86/kernel/cpu/mcheck/mce-apei.c
> > +++ b/arch/x86/kernel/cpu/mcheck/mce-apei.c
> > @@ -37,13 +37,11 @@
> > =20
> >  #include "mce-internal.h"
> > =20
> > -void apei_mce_report_mem_error(int corrected, struct cper_sec_mem_err =
*mem_err)
> > +void apei_mce_report_mem_error(struct cper_sec_mem_err *mem_err)
> >  {
> >  	struct mce m;
> > =20
> > -	/* Only corrected MC is reported */
> > -	if (!corrected || !(mem_err->validation_bits &
> > -				CPER_MEM_VALID_PHYSICAL_ADDRESS))
> > +	if (!(mem_err->validation_bits & CPER_MEM_VALID_PHYSICAL_ADDRESS))
> >  		return;
>=20
> This won't be enough. Further down, you'll see that all memory errors
> get logged as corrected errors due to the hardcoded MCE status. A lot
> more work will be needed if we have to log GHES errors through mcelog
> properly.
>=20
> - Naveen
>=20
Sure. In fact, the most valuable information from CPER is physical
address and most other data are faked or only little values. But
at least we can make it more precisely.

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSku1+AAoJEI01n1+kOSLHuu4QAIEKaYRVntLygn4r6DkqqXXQ
ONaDoHvZJSRUaEN/K8/Mt+9MaRq64CoRx9SWQzR3hpVP+TBjK77vWxG54PzFXIVa
mrKEdpefv23gqXJnpzRznRmYiLIqk7gK2FCetMZwkBHeQ9olspAFfuwKRL3sL6rP
tEeZI3sjWDQ3ddjqaOWO5N+8xWGSZ4ZpYq/sCd1HD5No29UyrU0VRZ/fxhI2M7HV
y8duLs5YsM5MOkJQdI7Vwfebg/QAVhesMADuIFvevtzN4GHVKTu2W5ccn9YJx46c
zIV9U6zF5I8D/83JqfYDxbH9y3jtDNEGTnhx1UB6D03XCspDOQfCpwM+FDqgom5O
3rjRGYZx6vYbzXODi64cMakLkK3i74M/CnXAi/+xxo+qSOdu8mMLzNc46ztajKaY
y+6tVxPHss6p/lOayE3Q8uweByfcVrL5vgknHLGQFrZK3/yLp8TxY4MRBN1ihBfT
2TFdb54tggNzn8JsLsjFB6T4vG12owRukYiEsArT/+NwjAJ10LQXlBkTw5X9GQZb
Gzmx7EnWQFQvMF9IREQIGtQlqbvj2/bCNOH3x8QeyXCF13WfydjxA8ChHyJwWGO7
gEvH/E99rCH4XANaCwxgVlLCjEJ9yDzsy3WDEJhnt7WR4fwPADo5ccsx3EUObnPl
S9tbaziFIcbz34mqU1/u
=O/hM
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
