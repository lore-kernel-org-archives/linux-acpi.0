From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 5 Oct 2016 17:21:17 +0200
Message-ID: <20161005152117.uhti7yewxwt5nvwn@sirena.org.uk>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sysa3d5e5pvexrxz"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35968 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754236AbcJEPVg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Oct 2016 11:21:36 -0400
Content-Disposition: inline
In-Reply-To: <20161005114129.GI1765@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, linux-acpi@vger.kernel.org, rafael@kernel.org, mark.rutland@arm.com, robh@kernel.org, ahs3@redhat.com


--sysa3d5e5pvexrxz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 05, 2016 at 02:41:29PM +0300, Mika Westerberg wrote:

> The whole purpose of PRP0001 ID is to allow DT bindings to be reused in
> ACPI systems, so that the drivers can just call device_property_* and
> get the properties regardless of the underlying firmware interface.

> Are you saying that's not wanted?

The idea was to allow the reuse of simple leaf drivers, as soon as you
get into things where you need to refer to other nodes it becomes much
less clear.

--sysa3d5e5pvexrxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX9RpqAAoJECTWi3JdVIfQU4QIAIXIaxoV3elLLszKPB9Lbq1I
1U1/2TmCpCHe4f/SGtUMeHcwL/OgvbI2XtmOPhh5xCJf5EC6W0FSNHu8cJVs3vLC
+HCUUVqzQfyEklS8RGdKuh5qNEHBmNDy+DY4YYeq0F4rH9fwrM2NpUYzpUX2Lq29
eDy/B9pB+re+LeMK2SeqzebBPLA7HT0mTQMppWbWBWUSxEs5mSbFqOUYEEspNwVG
v/PjHdv8gjAo45cQtoY5hsK4QbKJO61b58d0kZeuqA+YXzpaSrpwPMGiYG+pMY84
WovgkB60ReBmx+/ZL0ehPynvTDxMWwCs4YkpRqNfH2lvh/w3Zv11zndAPyH0Wxk=
=edJj
-----END PGP SIGNATURE-----

--sysa3d5e5pvexrxz--
