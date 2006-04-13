From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Hibernate
Date: Thu, 13 Apr 2006 21:26:37 +1000
Message-ID: <200604132126.42755.ncunningham@cyclades.com>
References: <7736DD1D5D6EDD4081B590872B56DCCC0C29F913@gvlexch01.gvl.is.l-3com.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1806675.i5zNTMrh7t";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:58051 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S964881AbWDML2H (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Apr 2006 07:28:07 -0400
In-Reply-To: <7736DD1D5D6EDD4081B590872B56DCCC0C29F913@gvlexch01.gvl.is.l-3com.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Cleaveland, AJ Allan @ IS" <Allan.J.Cleaveland@l-3com.com>
Cc: linux-acpi@vger.kernel.org

--nextPart1806675.i5zNTMrh7t
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Allan.

On Wednesday 12 April 2006 22:50, Cleaveland, AJ Allan @ IS wrote:
> I'm trying to get hibernate to work on CentOS 4.  What I really want to do
> is use hibernate to start-up the machine every time.  To do this I would
> create an "image" to come out of hibernate with and set the machine to
> always think it's coming out of hibernate, no matter how it was actually
> shut down.  It would always use my "image", even if it was placed in
> hibernate when it shut down.  Without rewriting other people's code does
> anyone know of a way to do this?
>
> Thank you,
> Allan

I'm not sure I understand what you're saying correctly, but it sounds to me=
=20
like you want something like the KeepImage feature in Suspend2. This featur=
e=20
lets you suspend once, and subsequently simply powerdown rather than=20
rewriting the image. To use this mode reliably, any filesystems mounted whe=
n=20
the image is created have to be immutable. This is because the image will=20
include information about the filesystems such as superblocks, inodes,=20
dentries and so on, and these data structures must match the data on disk.

On resume, you can mount other filesystems (and unmount them prior to power=
ing=20
down again), so it is possible to save state.

Is that the sort of thing you're after? If not, could you give further=20
details?

Regards,

Nigel

--nextPart1806675.i5zNTMrh7t
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBEPjVyN0y+n1M3mo0RAv7AAJ4wOr2gNGYAlPL64nzXFEhFw1P44wCfWyX5
GC3qplZnTJ469rv6qFM1xzQ=
=Hhj9
-----END PGP SIGNATURE-----

--nextPart1806675.i5zNTMrh7t--
