From: Mark Brown <broonie@kernel.org>
Subject: Re: next-20170815 build: 2 failures 4 warnings (next-20170815)
Date: Tue, 15 Aug 2017 12:16:12 +0100
Message-ID: <20170815111612.esq73hxowbw2mehj@sirena.org.uk>
References: <E1dhZPk-0002d9-9k@optimist>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xqegarazqzvkdxmo"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:45690 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbdHOLQ2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Aug 2017 07:16:28 -0400
Content-Disposition: inline
In-Reply-To: <E1dhZPk-0002d9-9k@optimist>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: kernel-build-reports@lists.linaro.org, linaro-kernel@lists.linaro.org, linux-next@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org


--xqegarazqzvkdxmo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 15, 2017 at 11:49:36AM +0100, Build bot for Mark Brown wrote:

Today's -next fails to build on arm64 due to:

> 	arm64-allmodconfig
> 	arm64-defconfig
> ../drivers/acpi/spcr.c:168:1: error: expected expression before '<<' token
> ../drivers/acpi/spcr.c:198:1: error: expected expression before '>>' token

caused by f69ba1326ac33b (Merge branch 'acpi-spcr' into linux-next)
which has an unresolved conflict in it.

--xqegarazqzvkdxmo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmS1/sACgkQJNaLcl1U
h9AkaQf/TXBGGh+HRb8qMiqXhsa4KXS03aV8a4B381n1K5lMnIrLbqrJB/yGrSYd
cE9X4tTexhMZSspiX3pQ1B19sb43yGEES2fGRIIALupDiUXotyvbRmw8SWrwZumG
MDt6fRsP3NUX319vUPqPPqkmi2FxdLbYN8zysXoTz34uWX9CPqhe4G6/XFrjh2jR
RFaO7StNYfwtnJH1ZuR72pfVNqrBRzy+bYhLpRlIUkEuRVWRfpmtXPrtzKqS6fqV
UW8emKN89M9YPTLgtedG6XUVrN0/8JAVM28DefV49l3i4aE8uxIpqTfn9lgP7cYR
CapiQjjqivuZ04HexTN5RpemcwV0qA==
=LX6G
-----END PGP SIGNATURE-----

--xqegarazqzvkdxmo--
