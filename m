From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Hibernate
Date: Fri, 14 Apr 2006 07:15:15 +1000
Message-ID: <200604140715.19206.ncunningham@cyclades.com>
References: <7736DD1D5D6EDD4081B590872B56DCCC0C29F91A@gvlexch01.gvl.is.l-3com.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1400471.DLmHoFsluM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:4006 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964971AbWDMVQz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Apr 2006 17:16:55 -0400
In-Reply-To: <7736DD1D5D6EDD4081B590872B56DCCC0C29F91A@gvlexch01.gvl.is.l-3com.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Cleaveland, AJ Allan @ IS" <Allan.J.Cleaveland@l-3com.com>
Cc: linux-acpi@vger.kernel.org

--nextPart1400471.DLmHoFsluM
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

On Thursday 13 April 2006 23:19, Cleaveland, AJ Allan @ IS wrote:
> Nigel,
>
>     Thank you for the suggestion.  I will look into it.  It sounds like it
> might work, though since this is likely to be used by us in a variety of
> settings, it may also be too restrictive for some of our uses.

Yes, the 'normal' thing is just to write the image everytime you suspend. F=
or=20
Suspend2, this usually takes 20s absolute tops (depends on the amount of=20
memory in use, cpu and disk speeds). The in-kernel swsusp is a lot slower. =
I=20
haven't had the chance to test Rafael's userspace swsusp yet, but Pavel is=
=20
claiming it's a lot closer to Suspend2 speed.

Regards,

Nigel

--nextPart1400471.DLmHoFsluM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEPr9nN0y+n1M3mo0RApMEAJ41xIeZCa+D+odEk1RQr6/isiVSpwCggRnD
1mx9DP6GALJfUj1hz+yIYio=
=XX7o
-----END PGP SIGNATURE-----

--nextPart1400471.DLmHoFsluM--
