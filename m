From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [patch 2/2 v2] ACPI, extlog: remove unneeded NULL check
Date: Sun, 10 Nov 2013 21:04:44 -0500
Message-ID: <20131111020444.GA1740@gchen.bj.intel.com>
References: <20131107072230.GA32127@gchen.bj.intel.com>
 <20131108082449.GA19368@elgon.mountain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11170 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018Ab3KKCU5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Nov 2013 21:20:57 -0500
Content-Disposition: inline
In-Reply-To: <20131108082449.GA19368@elgon.mountain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Tony Luck <tony.luck@gmail.com>, kernel-janitors@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2013 at 12:24:49AM -0800, Dan Carpenter wrote:
> Date: Fri, 8 Nov 2013 00:24:49 -0800 (PST)
> From: Dan Carpenter <dan.carpenter@oracle.com>
> To: Len Brown <lenb@kernel.org>, "Chen, Gong" <gong.chen@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org,
>  Tony Luck <tony.luck@gmail.com>, kernel-janitors@vger.kernel.org
> Subject: [patch 2/2 v2] ACPI, extlog: remove unneeded NULL check
> USER-AGENT: Mutt/1.5.21 (2010-09-15)
>=20
> We dereference extlog_l1_addr before checking if is NULL.  It turns out
> "extlog_l1_addr" pointer can never be NULL when this function is called
> so I have removed the check.
>=20
> We can remove the "elog_addr" check as well.
>=20
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: remove the elog_addr check as well.
>=20
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index a6869e1..17da458 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -310,10 +310,8 @@ static void __exit extlog_exit(void)
>  {
>  	mce_unregister_decode_chain(&extlog_mce_dec);
>  	((struct extlog_l1_head *)extlog_l1_addr)->flags &=3D ~FLAG_OS_OPTIN;
> -	if (extlog_l1_addr)
> -		acpi_os_unmap_memory(extlog_l1_addr, l1_size);
> -	if (elog_addr)
> -		acpi_os_unmap_memory(elog_addr, elog_size);
> +	acpi_os_unmap_memory(extlog_l1_addr, l1_size);
> +	acpi_os_unmap_memory(elog_addr, elog_size);
>  	release_mem_region(elog_base, elog_size);
>  	release_mem_region(l1_dirbase, l1_size);
>  	kfree(elog_buf);

Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSgDs8AAoJEI01n1+kOSLHihoP/jd+q/1487/RHPbTRQrS2+sH
sGKcjvMdPh6WO6X9NyOuaiH20AZHB/0XaiLZPGs92PDRE6ElZwCKed6AEaqym/21
rOd8hCrlzVTnqmrpWlfWDao86+UapRBEAAjP3aDnk/Uu/hEea2wZr9Bi745SFZ/i
a82vG4VZXQnQWQmXXyD57VOqCZ2SmViL4E382Kfm4FDif0Q7f3AN3kA+fFjM/acr
TYf8fDdADmLj/I7FPE+bWHChdT9h1Sy9UHGxmaduEV1skz39WqX4R35TmIsoAXvG
zPBxDthnysWx0zBdbtGuDThWyEX3B5sZvoas9JfC9DjhfRS3JWmIqmkFnBPZ6WEE
0OY5CbRJl8uFpd+pThMvrPNhlSJw/XEy953t0QB/ynpbVLEV2DlMqPNbd9FFB9s7
Tc5B/yD9cgRkznRT3qxpXaCv+bzfGGwa9AHcq/7JM/ucZxiaWFmouatRkft/rUWy
DTmi2l574xDwVcFCot+oi8iCDehgvnk63QYoGGzB/glAszDaBPzz7WO+Cpe1x25g
aNKglvpYwjVmFs2WUVzKLKJjcpsuM+DcoqifmjFQ1wAHxjE9snxIXWfmOf/aOpVA
6kyo3anRM7/cJRlX5C0sX+xYMFuV36gvii+5lwWm7vNLWSUY2vwzXEFysQcgMVI1
921tithvHtDaGPG9oSwn
=T046
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
