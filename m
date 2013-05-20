From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH 1/2] ACPI/APEI: Add parameter check before error injection
Date: Sun, 19 May 2013 22:13:45 -0400
Message-ID: <20130520021345.GA11819@gchen.bj.intel.com>
References: <1368671347-22415-1-git-send-email-gong.chen@linux.intel.com>
 <1368671347-22415-2-git-send-email-gong.chen@linux.intel.com>
 <20130516110503.GB31373@pd.tnic>
 <20130517050932.GA30122@gchen.bj.intel.com>
 <20130517090716.GA23035@pd.tnic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48504 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755191Ab3ETCUN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 May 2013 22:20:13 -0400
Content-Disposition: inline
In-Reply-To: <20130517090716.GA23035@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, linux-acpi@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2013 at 11:07:16AM +0200, Borislav Petkov wrote:
> Date:	Fri, 17 May 2013 11:07:16 +0200
> From: Borislav Petkov <bp@alien8.de>
> To: tony.luck@intel.com, linux-acpi@vger.kernel.org
> Subject: Re: [PATCH 1/2] ACPI/APEI: Add parameter check before error
>  injection
> User-Agent: Mutt/1.5.21 (2010-09-15)
>=20
> On Fri, May 17, 2013 at 01:09:32AM -0400, Chen Gong wrote:
> > IMHO, I don't think your attached patch has obvious improvment. I
> > paste my updated patch here and please continue to review. I will send
> > updated patch based on your further review.
>=20
> I already did my review. Having a bool checkparam and querying it
> straight afterwards is clumsy code. Also you're adding a redundant
> definiton of PAGE_MASK even though it already exists in the kernel.
> Maybe you should've grepped the sources first...
>=20
> Not to mention that this check seems wrong:
>=20
> 	((param2 & PAGE_MASK) !=3D PAGE_MASK)

Oops, it's my fault. I missed this stupid error. One reason is I like
to use Ctrl + P in VIM to match words, meanwhile, I often set ignorecase
in VIM so that I hitted this fault.

I accept your suggestion and resend it soon.


--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRmYbZAAoJEI01n1+kOSLH0ywP/27mf9dA3y1pO6TTyfyYiRTk
NMS2MrAwPgKj2dqLitTjK3F6DX/fa8cTELlU2XqKgaW0RdbkCYGfpMxDouZiPFI4
5eDmX7SNI7lcoY8rcocNcIho3T7ptPwcUt9X6yd6SUyilIrIDwhjZSTK1zzM0Pfe
AG6TLTOFScEoJxk7ELmHohksW0GCb39/LSEsAebEk4GvMX8K6HofJGIMSSa7fxA6
PAAVIYtZ+ueKvHobPD1adWuH9PQxyEJauwYobmntanK6iSplyKZcUA8xo7iY4BmL
JyoNONoMAQFE9JsF104iQ65h/hnBN6jSbW98q2unU0mgPvBB5X4jUE9kBh5pBepz
Y2Lh80FAV3LBtTKarxVQu/6RcWZoumB/Y2D3jd2g9u479R49MFB/LrpytZBX3DdT
w06ermCIimxUH5L9spkO8kFu19W3TvN6qX0kMt5XKR+tXm8Yjzz/n3IBVC9V6N/a
0IlqzxmdxvX9ghnCJdrBphM48bRp3WfdR7dXEM8BRWPu9pagxqyZH1F3WJqdmD5p
atNenxzzsjhv+Ilxzc6UruRrHOJhzRqhKbrnVngjemy+r6YXvkNwXf4iXVL8caf/
wzmN7sxKe5+10HXqXvp/buspYxFPctYZbqdv0Y7t39BOns1tbeicGR6cw7G25CYB
mYXMBIMWk+GFmH8ZUybm
=y495
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
