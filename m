From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: WHEA Support in Linux
Date: Tue, 26 Feb 2013 21:32:35 -0500
Message-ID: <20130227023235.GB29624@gchen.bj.intel.com>
References: <loom.20130226T053540-195@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:12915 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755377Ab3B0Cep (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 26 Feb 2013 21:34:45 -0500
Content-Disposition: inline
In-Reply-To: <loom.20130226T053540-195@post.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Manish <manishmj1111@gmail.com>
Cc: linux-acpi@vger.kernel.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2013 at 04:40:37AM +0000, Manish wrote:
> Date:	Tue, 26 Feb 2013 04:40:37 +0000 (UTC)
> From: Manish <manishmj1111@gmail.com>
> To: linux-acpi@vger.kernel.org
> Subject: WHEA Support in Linux
> User-Agent: Loom/3.14 (http://gmane.org/)
>=20
> Can anyone please help me with details regarding the support for WHEA (Wi=
ndows
> Hardware Error Architecture) in Linux.
> WHEA is supported in ACPI 5.0 specification.
Linux since 3.1(in fact, earlier than it in different style) has supported
WHEA.
>=20
> I'm getting the following message in dmesg log from RHEL:
> "ERST: Could not register with persistent Store"
>=20
You don't compile pstore support/not loaded it as a module/no NVRAM, UEFI
runtime space etc. to support pstore.

> Can anyone please let me know the scenarios in which this message comes.
>=20
> Thanks,
> Manish.
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRLXBDAAoJEI01n1+kOSLHJ0YP/2jycdffJFc7sUncGrXScCAU
4whpdinu99T5GCwgF8Xcm/2zKg2jF2+liFqHmhmSs3QVqYd7WNrKpMeayVB1it+z
Zvzvw9sqrf1FI46lfCxRZrTMFOfr5fKLvI8zHQpWqlqiN15IocLjiZM4j8antne0
4sVZJn9jlq0PC1IexNT6XAHQrYcVe1tx1XkmUHrLGDTNFNotrj1iplBXwTEycUdH
Mj/Pgh2ZH8xL6Z3kgFl5W4Na1tS8jMT7kK/xiCvwyPTgjsW0QUGgyWt7jL+4Ikl7
pPdhgMkY0eOYEbin8KklhFIe5emVMd8blRbQrsM8dXfts82fYTFkuRS47QHFVpD5
otD7qWHV/bOqelJFFAGLTeG4v10IofUmcv1kp0xkkjWvCsxVsRMjRQA0s9dOImQS
WuLgEmrxYHjxqXYZoDk1lkO976/KBxmM1y1eCj2Dk9Sk0Gsn18LVoVoNeKTNnVze
67b0oIdk/HQSRFv9wFEr96GwVKBIlOGijbn9KNnXiLsbGavDKH92teNypCB72pDX
BqQ3eSoeLDuMb7DZsyeZXt2BD0fFvDQKflXt6+LmznEBamxlQPB5eHhIWgwk1oJ6
YiOVBlky7+H2T4eWGXNBT8vyfVvYMg4bWwoDW9720fukRU9k717JUD5AtVrlOdi5
WmKPh40ifiyVfz24iclv
=slt5
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
