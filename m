From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Tue, 11 Oct 2016 15:15:58 +0200
Message-ID: <20161011131558.rxa53oaom6gp7qnr@sirena.org.uk>
References: <788f4bcd-605f-2694-5df5-ec7ef1bde233@arm.com>
 <CAJZ5v0iYPbLry-ZKeFqvm4Jeg24J7E6vQzV56jCh2N5fU6AQsw@mail.gmail.com>
 <0e56c5b2-0042-28e5-7445-6fe8422c728e@arm.com>
 <CAJZ5v0hy8V_WUuzOtT4oPt_hPRDUMHR5UYxVD0X3bVQe5AJf9Q@mail.gmail.com>
 <8999b937-4c06-6d82-aef5-6b7700a2a10c@arm.com>
 <CAJZ5v0g3MCBXXOn_txBE4E1-rjjwyXDu=wq=oD7xgXy=rhpm0w@mail.gmail.com>
 <957adfe3-5a17-47d5-f48c-2d47f727c387@arm.com>
 <CAJZ5v0hKnXiKTuQ5Ds57gnVQU3cEFj_YCaZn-he4x7tO8YdDrg@mail.gmail.com>
 <b4f0bedf-2473-b629-7dbb-90709c74226a@arm.com>
 <CAJZ5v0gFy2_pV5zx2_zDm5fE4Q1bqatPRDUiF1gcTAvTvbSEbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yepyhfdvlrx652vv"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:47570 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751593AbcJKNRh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Oct 2016 09:17:37 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gFy2_pV5zx2_zDm5fE4Q1bqatPRDUiF1gcTAvTvbSEbQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>


--yepyhfdvlrx652vv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 11, 2016 at 01:59:14PM +0200, Rafael J. Wysocki wrote:

> expect the mainline to accept this.  When in doubt about which way to
> go, they should talk to the mainline in the first place or the
> solution they choose may stay out of the tree forever (and become a
> major pain to maintain going forward).

Realistically if people ship something in sufficient volume for people
to care we're going to end up supporting them.

--yepyhfdvlrx652vv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX/OYNAAoJECTWi3JdVIfQfqQIAITTBLqsex/wfviWESBgYab8
v1fSW/7fc3HOBXZ6j5z0AW9w6HnZdNvf+aTjGVrpbSbPlEqpAw6lIDpgas9jm33t
PjeU6TLPV9hFV6SvFF/3swceKYvhEycHntIX/RZ/+aHol60R/Yft8yiNOK2BaQUv
5sdZbrSQqkGaDgH1uBKepj22KyypYkMT+N53kNZAG4RQACbjMfT69GQhffxBCgZA
t9ukhI351VlzOqAq91a7xioH+uIYHqyWUyRSrytCS1M5U7hcgu0Rf5Atibae+m0d
fJuOPR4Rd/37Qaod4hveZurOiN+OU2Zt6GIvu+eUuM/wzk1WLWpHisYrlNFuJXA=
=tDKK
-----END PGP SIGNATURE-----

--yepyhfdvlrx652vv--
