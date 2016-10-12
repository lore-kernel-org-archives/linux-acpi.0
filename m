From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Wed, 12 Oct 2016 02:35:42 +0200
Message-ID: <210901122.EBPz3PkSYu@vostro.rjw.lan>
References: <788f4bcd-605f-2694-5df5-ec7ef1bde233@arm.com> <CAJZ5v0gFy2_pV5zx2_zDm5fE4Q1bqatPRDUiF1gcTAvTvbSEbQ@mail.gmail.com> <20161011131558.rxa53oaom6gp7qnr@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart134213717.jqt8oobXYR"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:62911 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1752388AbcJLA27 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Oct 2016 20:28:59 -0400
In-Reply-To: <20161011131558.rxa53oaom6gp7qnr@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>


--nextPart134213717.jqt8oobXYR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Tuesday, October 11, 2016 03:15:58 PM Mark Brown wrote:
> On Tue, Oct 11, 2016 at 01:59:14PM +0200, Rafael J. Wysocki wrote:
> 
> > expect the mainline to accept this.  When in doubt about which way to
> > go, they should talk to the mainline in the first place or the
> > solution they choose may stay out of the tree forever (and become a
> > major pain to maintain going forward).
> 
> Realistically if people ship something in sufficient volume for people
> to care we're going to end up supporting them.

I wonder why the mainline doesn't boot on any flagship Android phones I'm
aware of, then. :-)

Thanks,
Rafael

--nextPart134213717.jqt8oobXYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJX/YVeAAoJEILEb/54YlRxUxIP/AyrmDa/0tc3T5/IuObtyYUF
/TvQxCogztCstmqPma9xStjjIHA5kJXB5fWTquFN7jU09Kvdo7oz3O0PmDHqvVJH
1d/0ZUZv/BkMtlk21cUALJfxs0oYxXALvl5OyiE1WxoDDOxD8biuzoC0z6gjoLay
sRnHLtMSCtjakOwiqxjaA87Hv9gJECMOUP3qLwRtuXbwFwBq29fN0LhaHjIjG8l/
4+5zHfHcXJs8wHqclqSX0xHwsUm73N/xKtEcREMo8YCY45neF97g6V4fwOw0NPUP
cN7fK61hqyIu4zAf2GBUtoM3dxdtFE8DzK/U4q/zIOUfFDfZRgIeiiX9eGi3EpDD
D2eeFwZKhr0e+3TZpsMe8vWqOV26cj3N6U5nXaCE6IK50JcKOyhea3I+GXlLTVVQ
YsA+5phUJzEuydSuj7G9vPph0stM5nWq3+tHi3+ahyiaiBWv/5cHVBCgRwXDRN0T
O3bnOgVWrwG450YAhPx2KUtLy1huFGkUrWKawjUQXkJ3WRN486KV9y+o6kKfh1+k
wPp/sNLy7NhswXdCGkF8HgI1zBtQfWnw65JZhxo30cy9MsqUWBUtre04KlJ0o7Lo
1NZvcdiLTyQLXxe3CDa+menJu3COWTZExd395OdV/1iaAAhI2yc/+DbLfNFIiMmd
4Ljtic3RFCk8uEFtHwNm
=LYCx
-----END PGP SIGNATURE-----

--nextPart134213717.jqt8oobXYR--

