From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Tue, 11 Oct 2016 15:26:44 +0200
Message-ID: <20161011132644.cbdyz57nd2ilfu64@sirena.org.uk>
References: <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon>
 <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon>
 <CAJZ5v0ixapEyg6dhhH=9xQbQ+yxr30pCxaJdK9LQg1jEyNUvkw@mail.gmail.com>
 <20161006213704.4idjpln4kdodwqj4@sirena.org.uk>
 <20161011130120.GF24347@remoulade>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nbpis2eozpyn7gjg"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:47666 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750846AbcJKN1A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Oct 2016 09:27:00 -0400
Content-Disposition: inline
In-Reply-To: <20161011130120.GF24347@remoulade>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>


--nbpis2eozpyn7gjg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 11, 2016 at 02:01:21PM +0100, Mark Rutland wrote:
> On Thu, Oct 06, 2016 at 11:37:04PM +0200, Mark Brown wrote:

> > There's nothing stopping these systems defining a DSD that contains a
> > DTB which overrides some or all of the ACPI if the system supports it
> > (or otherwise providing both system descriptions).=20

> Please, no. We very deliberately avoided this mix-and-match scheme for ar=
m64
> (it was proposed in discussions several times), because it suffers form w=
orse
> issues than PRP (since you can't corss-reference between DT and ACPI).

Right, I was mainly thinking of the all case here rather than the some
case.  It's not clear to me that we're not going to end up with the
mixed case anyway as a result of the FPGA work but that's definitely not
my preferred option.

> The arm64 kernel needs a DTB to pass some OS-specific stuff like bootargs=
, but
> when using ACPI almost everything else is ignored -- we don't unflatten t=
he
> tree and we don't instanciate devices from it.

The important thing here is that that DTB can in fact be a real DT
rather than just the stub and in that case the kernel can pick and
choose (and by default it'll just ignore the ACPI if it can though
some of the distros change that default).

--nbpis2eozpyn7gjg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX/OiUAAoJECTWi3JdVIfQxR4H/1cl8kdCSxuBpi7w2cpwVjZx
Rq2w+YRwjVsVOK4nAkXcBrywQTZyVRKPWYlhHwIn3BBfgzgZC7w28zqYqbM2cqlj
/I6GAtoHJtWaYxjZGnSERD1VTTrArEf+xsT99PvMfj0iO2j1pEyk3C3WEVLQo5R5
fcDUbaxmWSFTa8HWjT8nPAM4Kc740J28ZIWBRxgkR8j2HlinOQyaDhubRJ1kLR8J
C/eL3y9YDi9xNDYYK4C0Fa1FtMnvhhh9My7gYBEHtWYRCyYTp9epkQuTvDBySylv
UxYkgg3psFSgGwILLGLAqy9pBHozHBchKxpAgMuoB1Nq9nnGdg2QPX7EX6STqGA=
=IWNy
-----END PGP SIGNATURE-----

--nbpis2eozpyn7gjg--
