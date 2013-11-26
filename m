From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH v2 2/2] ACPI, APEI, GHES: Cleanup ghes codes for memory
 error handling
Date: Tue, 26 Nov 2013 01:54:57 -0500
Message-ID: <20131126065456.GB26098@gchen.bj.intel.com>
References: <1385363701-12387-1-git-send-email-gong.chen@linux.intel.com>
 <1385363701-12387-2-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13696 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753487Ab3KZHMB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Nov 2013 02:12:01 -0500
Content-Disposition: inline
In-Reply-To: <1385363701-12387-2-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: tony.luck@intel.com, bp@alien8.de, naveen.n.rao@linux.vnet.ibm.com
Cc: linux-acpi@vger.kernel.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2013 at 02:15:01AM -0500, Chen, Gong wrote:
> Date: Mon, 25 Nov 2013 02:15:01 -0500
> From: "Chen, Gong" <gong.chen@linux.intel.com>
> To: tony.luck@intel.com, bp@alien8.de, naveen.n.rao@linux.vnet.ibm.com
> Cc: linux-acpi@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>
> Subject: [PATCH v2 2/2] ACPI, APEI, GHES: Cleanup ghes codes for memory
>  error handling
> X-Mailer: git-send-email 1.8.4.3
>=20
> Cleanup the logic for function ghes_handle_memory_failure. Just
> make it simpler and cleaner.
>=20
> v2 -> v1: fix a compile error & some minor changes.
>=20
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> ---
>  drivers/acpi/apei/ghes.c | 36 ++++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index ce3683d..46766ef 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -413,27 +413,31 @@ static void ghes_handle_memory_failure(struct acpi_=
generic_data *gdata, int sev)
>  {
>  #ifdef CONFIG_ACPI_APEI_MEMORY_FAILURE
>  	unsigned long pfn;
> +	int flags =3D -1;
>  	int sec_sev =3D ghes_severity(gdata->error_severity);
>  	struct cper_sec_mem_err *mem_err;
>  	mem_err =3D (struct cper_sec_mem_err *)(gdata + 1);
> =20
> -	if (sec_sev =3D=3D GHES_SEV_CORRECTED &&
> -	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED) &&
> -	    (mem_err->validation_bits & CPER_MEM_VALID_PA)) {
> -		pfn =3D mem_err->physical_addr >> PAGE_SHIFT;
> -		if (pfn_valid(pfn))
> -			memory_failure_queue(pfn, 0, MF_SOFT_OFFLINE);
> -		else if (printk_ratelimit())
> -			pr_warn(FW_WARN GHES_PFX
> -			"Invalid address in generic error data: %#llx\n",
> -			mem_err->physical_addr);
> -	}
> -	if (sev =3D=3D GHES_SEV_RECOVERABLE &&
> -	    sec_sev =3D=3D GHES_SEV_RECOVERABLE &&
> -	    mem_err->validation_bits & CPER_MEM_VALID_PA) {
> -		pfn =3D mem_err->physical_addr >> PAGE_SHIFT;
> -		memory_failure_queue(pfn, 0, 0);
> +	if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))
> +		return;
> +
> +	pfn =3D mem_err->physical_addr >> PAGE_SHIFT;
> +	if (!pfn_valid(pfn)) {
> +		pr_warn_ratelimited(FW_WARN GHES_PFX
> +		"Invalid address in generic error data: %#llx\n",
> +		mem_err->physical_addr);
> +		return;
>  	}
> +
> +	/* iff following two events can be handled properly by now */
> +	if (sec_sev =3D=3D GHES_SEV_CORRECTED &&
> +	    (gdata->flags & CPER_SEC_ERROR_THRESHOLD_EXCEEDED))
> +		flags =3D MF_SOFT_OFFLINE;
> +	if (sev =3D=3D GHES_SEV_RECOVERABLE && sec_sev =3D=3D GHES_SEV_RECOVERA=
BLE)
> +		flags =3D 0;
> +
> +	if (flags !=3D -1)
> +		memory_failure_queue(pfn, 0, flags);
>  #endif
>  }
> =20

Hi, Boris

In this patch so-called cleanup includes an implied PFN check for UC error
but missed in current codes.

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSlEXAAAoJEI01n1+kOSLHQ3gP/RD4S0LJe2gcnEjLaW8aCsX6
g5lbiiXp6CSASZ4z35QTdQqMCpaaf7KIA8FJ/KThDoMjFKAXUD7QbMM/S/PyoxDL
Jr+UnIsGRXLAV1NDHneZVsGQyBx37a4rmuzWXdXbqErm3681nwc5Ca6aNFYlv5Oj
L4vqqx3rpAYRm/HdlweHCtX73Dko82HEknjFpAE3lgs9S5XAsqP4w9AVjIBXTX/v
r41SU91gmXAQ3hOu/yuC8u5XhiVIp18sHhC678lHydrlfMntLE647dGTZPICGkUP
udT/fcdAxHJf3KeroSxkPzDxAi40b3QcuNoBwZw9XeBzh61KJI74P+N1l9U6YT0i
upgV4Ceapto7LGn5hlAp/I0B/oteb7inzC1QdEGRzfkJ558pO6oq3eQXNvINJZoe
EGAryq6538ZIVLMMBmQGlG7+/n+PjTnsaFAWfFc1Lc87+hSCGvVej392XDWsvYm1
7xlF8m8Snf1h+Ac3SWTUXVW3T+QHdQQvp+VpzlUpNta6hGTA/ZSETnFOlFQjpbdw
IcSeHg7V6BN3J2aAb60Xj4+gQwH/xoeMpm6/nVJhFJh8JvFyhmU0QWLW6+R9421C
CePVLzId6Rffi8V8MGTOnjiXrMWBO4ETy7vWzOYJ7OFNqVboKTUkIwfhGITTvqbo
5cRKmG8WLqiF6Jt+Srpa
=uUyt
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
