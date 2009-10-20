From: Andrey Rahmatullin <wrar@altlinux.org>
Subject: Re: [PATCH 2/2] eeepc-laptop: don't enable camera at startup if
 it's already on.
Date: Tue, 20 Oct 2009 15:41:43 +0600
Message-ID: <20091020094143.GJ19095@wrars-comp.wrarsdomain>
References: <1255724567-25597-1-git-send-email-corentincj@iksaif.net>
 <1255724567-25597-2-git-send-email-corentincj@iksaif.net>
 <1255724567-25597-3-git-send-email-corentincj@iksaif.net>
 <20091020083555.GG19095@wrars-comp.wrarsdomain>
 <9b2b86520910200204n2089bcf1h2535e56d2ec4156e@mail.gmail.com>
 <20091020092402.GI19095@wrars-comp.wrarsdomain>
 <9b2b86520910200238u66af0d34v99931cf86507d5ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vwmj/TXzE7NEH899"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from k66.ru ([87.224.128.21]:63517 "EHLO k66.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbZJTJlk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Oct 2009 05:41:40 -0400
Content-Disposition: inline
In-Reply-To: <9b2b86520910200238u66af0d34v99931cf86507d5ff@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: Corentin Chary <corentincj@iksaif.net>, lenb@kernel.org, linux-acpi@vger.kernel.org, Luca Niccoli <lultimouomo@gmail.com>, Len Brown <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>


--Vwmj/TXzE7NEH899
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2009 at 10:38:17AM +0100, Alan Jenkins wrote:
> yes but if you are missing the original "enable camera by default"
> patch  *which has already been merged* then you are almost certainly
> also missing the patch to enable autosuspend on uvcvideo by default.
No, I'm not missing it, I'm using .32-rc5

> Yeah, powertop's autosuspend recommendation is a bit outdated.
So, can I safely ignore it and assume all is right when I use latest
kernels?

> Here's a link to the original thread.
> <http://lkml.indiana.edu/hypermail/linux/kernel/0906.0/02603.html>.
OK, I'll read it, thanks.

--=20
WBR, wRAR (ALT Linux Team)

--Vwmj/TXzE7NEH899
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBCAAGBQJK3YXWAAoJEOih81koZvPBIMYH/RJQaaeqTRRFdsxBry38jhqK
NraoLs4353VgSChrbGc2iB8kdoXLDOUxhYGrfH2VON5f6aSb/lqQWPiLIc3PFj+y
Xdjxtn8+ptWvwyXUJpbaFbunRupDTr2YXl8H0FSK0HXmiAYz8CpH5ciL9CTAFaIz
qXXurbecEoRbUZ8Un5cjBvtOPqyZpOwSObiCriMRuGOaQG2z6g+7PD5iaIKhvKwK
TEQCiD8yoOCG6Ao4E5As+4vxhp/9gBh8nH9BeYIM0+BYuv5PplrthkbwPHUOHSNe
r8yiq/sGAO7fKgGCZ/AL/j7C+bgwhKJ/DUcCcUiOo0etwPwp68d4+1EvsTjhAIw=
=JAXF
-----END PGP SIGNATURE-----

--Vwmj/TXzE7NEH899--
