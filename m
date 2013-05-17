From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH 1/2] ACPI/APEI: Add parameter check before error injection
Date: Fri, 17 May 2013 01:09:32 -0400
Message-ID: <20130517050932.GA30122@gchen.bj.intel.com>
References: <1368671347-22415-1-git-send-email-gong.chen@linux.intel.com>
 <1368671347-22415-2-git-send-email-gong.chen@linux.intel.com>
 <20130516110503.GB31373@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:20256 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490Ab3EQFPv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 May 2013 01:15:51 -0400
Content-Disposition: inline
In-Reply-To: <20130516110503.GB31373@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2013 at 01:05:03PM +0200, Borislav Petkov wrote:
> Date: Thu, 16 May 2013 13:05:03 +0200
> From: Borislav Petkov <bp@alien8.de>
> To: Chen Gong <gong.chen@linux.intel.com>
> Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org
> Subject: Re: [PATCH 1/2] ACPI/APEI: Add parameter check before error
>  injection
> User-Agent: Mutt/1.5.21 (2010-09-15)
>=20
> On Wed, May 15, 2013 at 10:29:06PM -0400, Chen Gong wrote:
> > When param1 is enabled in EINJ but not assigned with a valid
> > value, sometimes it will cause the error like below:
> >=20
> > APEI: Can not request [mem 0x7aaa7000-0x7aaa7007] for APEI EINJ Trigger
> > registers
> >=20
> > It is because some firmware will access target address specified in
> > param1 to trigger the error when injecting memory error. This will
> > cause resource conflict with regular memory. So It must be removed
> > from trigger table resources, but uncorrected param1/param2
> > combination will stop this action. Add extra check to avoid
> > happening this error.
> >=20
> > Signed-off-by: Chen Gong <gong.chen@linux.intel.com>
> > ---
> >  drivers/acpi/apei/einj.c |   29 +++++++++++++++++++++++++----
> >  kernel/resource.c        |    1 +
> >  2 files changed, 26 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> > index 8d457b5..015546e 100644
> > --- a/drivers/acpi/apei/einj.c
> > +++ b/drivers/acpi/apei/einj.c
> > @@ -32,6 +32,7 @@
> >  #include <linux/seq_file.h>
> >  #include <linux/nmi.h>
> >  #include <linux/delay.h>
> > +#include <linux/mm.h>
> >  #include <acpi/acpi.h>
> > =20
> >  #include "apei-internal.h"
> > @@ -511,11 +512,31 @@ static int __einj_error_inject(u32 type, u64 para=
m1, u64 param2)
> >  /* Inject the specified hardware error */
> >  static int einj_error_inject(u32 type, u64 param1, u64 param2)
> >  {
> > -	int rc;
> > +	int rc =3D 0;
> > +	unsigned long pfn;
> > +	bool checkparam =3D false;
> > +	u64 param2_mask =3D 0xfffffffffffff000;
> > =20
> > -	mutex_lock(&einj_mutex);
> > -	rc =3D __einj_error_inject(type, param1, param2);
> > -	mutex_unlock(&einj_mutex);
> > +	/* ensure param1/param2 existed & injection is memory related */
> > +	if (param_extension || acpi5) {
> > +		if (type & 0x80000000) {
>=20
> 		if (type & BIT(31)) {
>=20
> better readable.
>=20
> even better if you define what bit 31 is
>=20
> #define INJ_TYPE BIT(31)
>=20
> > +			if (vendor_flags =3D=3D SETWA_FLAGS_MEM)
> > +				checkparam =3D true;
> > +		} else if (type & 0x38)
>=20
> what is 0x38? Also a macro define with readable name pls.
>=20
> > +			checkparam =3D true;
> > +	}
> > +	if (checkparam) {
> > +		pfn =3D PFN_DOWN(param1 & param2);
> > +		if (!page_is_ram(pfn) ||
> > +			((param2 & param2_mask) !=3D param2_mask))
>=20
> Hmm, shouldn't this be:
>=20
> 			(param2 & param2_mask) !=3D param2
>=20
> ?
>=20
> > +			rc =3D -EINVAL;
> > +	}
>=20
> This checkparam variable looks unneeded to me:
>=20
> 		if (type & INJ_TYPE) {
> 			if (vendor_flags =3D=3D SETWA_FLAGS_MEM || type & 0x38) {
> 				...
>=20
> Ok, I went and rewrote the function to show you what I mean. I've
> also reversed the logic to flatten the indentation level (completely
> untested, of course):
>=20
> static int einj_error_inject(u32 type, u64 param1, u64 param2)
> {
>        int rc;
>        unsigned long pfn;
>=20
>        /* ensure param1/param2 exist and we inject to real memory */
>        if (!(param_extension || acpi5))
> 	       goto inject;
>=20
> 	if (type & INJ_TYPE)
> 		if (vendor_flags !=3D SETWA_FLAGS_MEM)
> 			goto inject;
> 	else if (!(type & THREE_BIT_MASK))
> 		goto inject;
>=20
> 	pfn =3D PFN_DOWN(param1 & param2);
> 	if (!page_is_ram(pfn) || ((param2 & PAGE_MASK) !=3D param2))
> 		return -EINVAL;
>=20
>  inject:
> 	mutex_lock(&einj_mutex);
> 	rc =3D __einj_error_inject(type, param1, param2);
> 	mutex_unlock(&einj_mutex);
>=20
> 	return rc;
> }
>=20
> --=20
> Regards/Gruss,
>     Boris.
>=20
> Sent from a fat crate under my desk. Formatting is fine.
> --

Hi, Boris

Thanks for your review. I agree with you about readability enhancement.
IMHO, I don't think your attached patch has obvious improvment. I paste
my updated patch here and please continue to review. I will send updated
patch based on your further review.

In this patch, I update previous confused definition at the same time.
They are very little and no ill-efect so I don't write a new patch
for it.

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index 8d457b5..dba59be 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -32,6 +32,7 @@
 #include <linux/seq_file.h>
 #include <linux/nmi.h>
 #include <linux/delay.h>
+#include <linux/mm.h>
 #include <acpi/acpi.h>

 #include "apei-internal.h"
@@ -41,6 +42,11 @@
 #define SPIN_UNIT              100                     /* 100ns */
 /* Firmware should respond within 1 milliseconds */
 #define FIRMWARE_TIMEOUT       (1 * NSEC_PER_MSEC)
+#define ACPI5_VENDOR_BIT       BIT(31)
+#define PAGE_MASK              0xfffffffffffff000
+#define MEM_ERROR_MASK         (ACPI_EINJ_MEMORY_CORRECTABLE | \
+                               ACPI_EINJ_MEMORY_UNCORRECTABLE | \
+                               ACPI_EINJ_MEMORY_FATAL)

 /*
  * ACPI version 5 provides a SET_ERROR_TYPE_WITH_ADDRESS action.
@@ -367,7 +373,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 =
type,
         * This will cause resource conflict with regular memory.  So
         * remove it from trigger table resources.
         */
-       if ((param_extension || acpi5) && (type & 0x0038) && param2) {
+       if ((param_extension || acpi5) && (type & MEM_ERROR_MASK) && param2=
) {
                struct apei_resources addr_resources;
                apei_resources_init(&addr_resources);
                trigger_param_region =3D einj_get_trigger_parameter_region(
@@ -427,7 +433,7 @@ static int __einj_error_inject(u32 type, u64 param1, u6=
4 param2)
                struct set_error_type_with_address *v5param =3D einj_param;
tototototoram->type =3D type;
-               if (type & 0x80000000) {
+               if (type & ACPI5_VENDOR_BIT) {
                        switch (vendor_flags) {
                        case SETWA_FLAGS_APICID:
                                v5param->apicid =3D param1;
@@ -512,6 +518,25 @@ static int __einj_error_inject(u32 type, u64 param1, u=
64 param2)
 static int einj_error_inject(u32 type, u64 param1, u64 param2)
 {
        int rc;
+       unsigned long pfn;
+       bool checkparam;
+
+       /* ensure param1/param2 existed & injection is memory related */
+       if (param_extension || acpi5) {
+               checkparam =3D false;
+               if (type & ACPI5_VENDOR_BIT) {
+                       if (vendor_flags =3D=3D SETWA_FLAGS_MEM)
+                               checkparam =3D true;
+               } else if (type & MEM_ERROR_MASK)
+                       checkparam =3D true;
+
+               if (checkparam) {
+                       pfn =3D PFN_DOWN(param1 & param2);
+                       if (!page_is_ram(pfn) ||
+                               ((param2 & PAGE_MASK) !=3D PAGE_MASK))
+                               return -EINVAL;
+               }
+       }

        mutex_lock(&einj_mutex);
        rc =3D __einj_error_inject(type, param1, param2);
@@ -590,7 +615,7 @@ static int error_type_set(void *data, u64 val)
         * Vendor defined types have 0x80000000 bit set, and
         * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
         */
-       vendor =3D val & 0x80000000;
+       vendor =3D val & ACPI5_VENDOR_BIT;
        tval =3D val & 0x7fffffff;

        /* Only one error type can be specified */
diff --git a/kernel/resource.c b/kernel/resource.c
index d738698..77bf11a 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -409,6 +409,7 @@ int __weak page_is_ram(unsigned long pfn)
 {
        return walk_system_ram_range(pfn, 1, NULL, __is_ram) =3D=3D 1;
 }
+EXPORT_SYMBOL_GPL(page_is_ram);

 void __weak arch_remove_reservations(struct resource *avail)
 {

--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRlbuMAAoJEI01n1+kOSLHF6YQALTKY9v6eelTZAXVzJZEaSjN
/gTkN681tp1JX3G5soA7MByk9SBP6o2iPo5pKbpBX5ZKe6L9GX0BZH1vL/atgi/0
oLbTfuO8FifbYRUu31cgNgfa8y+J2rqgKojM4k6ezCk61fA8X2tDEBcV1ak/VD3z
3O/MWzUQ/v2ggdqTywz7k9EX7OSqO2+ZKCd4iCn/gdGr1k/Fee0K9eJLXA9knHQo
o7ohgdvOC5+zhYhhGLgyUp8tF2zZXh6a8acwcxRdtCRQoQqe/b5LMnq/t5R3Rnn9
+qOLKuQ9Uwb4SR7TAFw4KIYdHvCqFf2HeFDEY8DqIUELVhPz8kiDNqLJ81IZTGBb
ylebcJ92srNLJVds/2FnDfujyrkOcRFRsc8YhqDJLfpyxEoY4syGsXsvItUl0YeG
GRH/ovrPg/ckRkcJ8rjy+yfo/HS59GiZQQdEPTFBp2wnwo+U/iq9LyICb1fmyq+3
7S7cARyF5OIZsKASH9QLSBmjD4K/uX9xY75yjVonfGsG3kkJHrFB4GpBWfTrwxBR
X+TQj75iJezjB8hULwQsro6CZe0bF0llSWYr9eNSC6iQVqeAFot7VIsYeHSQTGEm
wSkRX9OcbKLCvxifOFOjlF8i5KkjLdVTFJdl0dlch7He1pfFbiy0aIiDBkiJbebR
NZBSXikF9WO8MoZiAJMT
=CsCe
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
