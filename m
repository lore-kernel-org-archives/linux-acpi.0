From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 5/5] ACPI: Switch to use generic guid_t in
 acpi_evaluate_dsm()
Date: Wed, 31 May 2017 21:21:04 +0100
Message-ID: <20170531202104.qrvypvoze4kbiqf6@sirena.org.uk>
References: <20170531194152.65927-1-andriy.shevchenko@linux.intel.com>
 <20170531194152.65927-6-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wbp5mjqldnf7cqab"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:47900 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbdEaUV1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 31 May 2017 16:21:27 -0400
Content-Disposition: inline
In-Reply-To: <20170531194152.65927-6-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, "Rafael J . Wysocki " <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Borislav Petkov <bp@suse.de>, intel-gfx@lists.freedesktop.org, Amir Goldstein <amir73il@gmail.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Ben Skeggs <bskeggs@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Yisen Zhuang <yisen.zhuang@huawei.com>, Liam Girdwood <lgirdwood@gmail.com>


--wbp5mjqldnf7cqab
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 31, 2017 at 10:41:52PM +0300, Andy Shevchenko wrote:
> acpi_evaluate_dsm() and friends take a pointer to a raw buffer of 16
> bytes. Instead we convert them to use guid_t type. At the same time we
> convert current users.

Acked-by: Mark Brown <broonie@kernel.org>

--wbp5mjqldnf7cqab
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkvJbAACgkQJNaLcl1U
h9ASJQf/b3RRs13+3Kq8UzmsY0whMcBjn5HvZAvHzH28D1rGWNe3G7a8YVgET5g/
cNweYaT9Pzuell4maLmxgoAo2jYvXh5vpE3Q4BS1E3ZuGhambXIaOgGMR9eDDqto
Akq7q3IrsKl6SmXldHWwIdIW2awBiTVZaQMyr9VEYFgZyF0BO3XkS/gXHCwo/o2P
fAmLB9N2LL9p8TzpIJelbkrVbH1JXkrsDQeIwInVQcj72bAux32T0EDMHHNYH6Qp
rekVP2OK6wDVSflWj8AOb4LzhjyGnya0/ZOAvWPaoMcfMPYF6x+WSbLc3y9snV+R
GwdMMY+n1Ni5nE8Ehsu1BVpN3R/rMA==
=xjjo
-----END PGP SIGNATURE-----

--wbp5mjqldnf7cqab--
