From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 00/15] ACPI graph support
Date: Thu, 6 Oct 2016 12:40:58 +0200
Message-ID: <20161006104058.uqdkv3pfihicxyfv@sirena.org.uk>
References: <1475621148-21427-1-git-send-email-sakari.ailus@linux.intel.com>
 <20161005092215.GA20248@red-moon>
 <20161005114129.GI1765@lahna.fi.intel.com>
 <20161005150641.GA22282@red-moon>
 <20161005153229.GO1765@lahna.fi.intel.com>
 <20161005161800.GA22433@red-moon>
 <CAJZ5v0jNSEQ6Uk4T-19jA=RV9pmRzojB4FBd=SFAo6VOj-SLLg@mail.gmail.com>
 <20161006085703.GA22776@red-moon>
 <20161006091133.GF30800@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3nugdhdd5kbwjh24"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:45760 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbcJFKlQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Oct 2016 06:41:16 -0400
Content-Disposition: inline
In-Reply-To: <20161006091133.GF30800@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Al Stone <ahs3@redhat.com>


--3nugdhdd5kbwjh24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 06, 2016 at 12:11:33PM +0300, Mika Westerberg wrote:

> One reason is that we have boards like Joule where developers are
> allowed to connect different peripherals using buses such as I2C and SPI
> where there is no native enumeration mechanism. This includes camera
> sensors and related so there needs to be a way for a developer to
> describe this in ACPI. Just as can be done when using ARM and DT.

One of my biggest concerns with this approach is that I'm really not
clear to me that that this has broad buy in from the x86/ACPI community
and therefore that we might end up needing to support several different
styles of ACPI bindings.  Reuse would be great but it can be confusing
if there's multiple different styles of bindings in use at the same
time.

The audio systems that have this issue (which include production laptops
and tablets with both Windows and ChromeOS) don't seem to be showing
much interest in reusing any of the DT work beyond the device level
properties and I didn't think the OS level support for using _DSD in
Windows was great.  There were also the pinctrl bindings which had some
issues too.

--3nugdhdd5kbwjh24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX9io3AAoJECTWi3JdVIfQbWsH/0obr4XZuNu4ETkqXCFgfNW6
StcDfbwXhwEzpH1cWl2o+pAevvE+N0sGO76USiGrJsWRQCEztEFIYwAR14SPENXV
03u/w1YEb/RkSyCd7HYUONsc3zVnvKWfGerMVCl83bOxVdKeGwOCbKksmSZsIm1/
b3/PutKQ/ZjbmKG8B18Zw9ERn5q08LUKyBGy46MF6e73LCG5qGUQ0hbbIoXRV4Zc
SHOFKH37Fzi6de5xiHyCCrMyZ6KOTI9GzSCrdozMgz2OLNrwXjMwigx8BQ/ltHyc
BsWZJUUCTdE3E+fo0Fz/ZxhplGDCc/Ycy7TZob3mZthazg0aNz8FrzTr3YCW1qQ=
=qBvS
-----END PGP SIGNATURE-----

--3nugdhdd5kbwjh24--
