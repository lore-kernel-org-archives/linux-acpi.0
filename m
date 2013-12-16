From: "Chen, Gong" <gong.chen@linux.intel.com>
Subject: Re: [PATCH v3] ACPI, APEI: Cleanup alignment related codes for APEI
Date: Mon, 16 Dec 2013 09:39:34 -0500
Message-ID: <20131216143934.GB8397@gchen.bj.intel.com>
References: <20131114122956.GE13376@pd.tnic>
 <1384494356-4034-1-git-send-email-gong.chen@linux.intel.com>
 <20131216141906.GC4922@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:1210 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753755Ab3LPO5p (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 16 Dec 2013 09:57:45 -0500
Content-Disposition: inline
In-Reply-To: <20131216141906.GC4922@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2013 at 03:19:06PM +0100, Borislav Petkov wrote:
> Date: Mon, 16 Dec 2013 15:19:06 +0100
> From: Borislav Petkov <bp@alien8.de>
> To: "Chen, Gong" <gong.chen@linux.intel.com>
> Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org
> Subject: Re: [PATCH v3] ACPI, APEI: Cleanup alignment related codes for A=
PEI
> User-Agent: Mutt/1.5.21 (2010-09-15)
>=20
> On Fri, Nov 15, 2013 at 12:45:56AM -0500, Chen, Gong wrote:
> > diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> > index 26311f2..bf30a12 100644
> > --- a/drivers/acpi/apei/erst.c
> > +++ b/drivers/acpi/apei/erst.c
> > @@ -611,7 +611,7 @@ static void __erst_record_id_cache_compact(void)
> >  		if (entries[i] =3D=3D APEI_ERST_INVALID_RECORD_ID)
> >  			continue;
> >  		if (wpos !=3D i)
> > -			memcpy(&entries[wpos], &entries[i], sizeof(entries[i]));
> > +			entries[wpos] =3D entries[i];
>=20
> Why is it ok to drop the memcpy here and do a normal access?
>=20
> __erst_record_id_cache_add_one still has a memcpy-like access.
>=20
> What is the difference with all those accesses to erst_record_id_cache
> and why doesn't it need the unaligned helpers?
>=20
> This all needs to be explained in detail in the commit message.
>=20
> Thanks.
>=20
erst record id cache is implemented in the memory to increase the access
speed via caching ERST content, so it doesn't matter with firmware access.

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSrxCmAAoJEI01n1+kOSLHuAIQAIOR+TZGS6AkFlltEMYCMu9q
mt8gEW9Fgygp52JpBkjje5Cavgi4MihDSvPAp5RKjnSdOCrD6rfCSwYKI3cUAIbe
MNfr/yiQTSUR0299Wo57KI9wwdgE+v69kpwVXPyM5irAr1AysM0z0SzMX1obyqIO
+HGs8VgkVvcTppjbjxD1UoGMIe4ryFB2DqaGrF+IlSl54Wbku7SnL6HmkU9E6C44
HkVxiFZUuVbfxCZ/QtBOuk6mj2kqxBZ+eC+/qke1hGEimdipPq/V86EBTkP+E83N
z8yPJ3YIhltCj2li2I+AMqLWYMrmqnEFodl+Q7BvoszsGRwugokFgJoe69VNlpCD
MHYJ/TR5AatUaO5PZ1mIj1LmF5m8qrtbexSS6vA7oCnmRnfF5pAK1jbZKEpLkZD5
49Zm+f34Yl97xfFAxsIF1RLqtfQiv1k+uOBdRvIxwFRTFshGqcH4Wldp7iQcCOtS
UrWHUA8Ur6N8fbEKKSM92x14cyWRbm5YOqPRXMLqbTxPhCbi9k4q6pnNaN3MDZmd
8tnQOoI/ufVQCY/O+jz37/1EUxnL4u/JxJ+ClFFloOidimb5HLgxJM3J2WN9yIs0
d9Q8L6WxXrSgZFvmHGo5YCk9XU+gSoklbK/KMdeF1AJJN7PUk1GRTic7/HUl8eyZ
oFpo7+KFpp2loxuLxaWD
=W/PP
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
