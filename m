From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC part1 PATCH 0/7] Make ACPI core running on ARM64
Date: Fri, 6 Dec 2013 13:58:25 +0000
Message-ID: <20131206135825.GG29268@sirena.org.uk>
References: <1386088611-2801-1-git-send-email-hanjun.guo@linaro.org>
 <201312052325.02603.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9056985622669344600=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201312052325.02603.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, linaro-kernel@lists.linaro.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, patches@linaro.org, Olof Johansson <olof@lixom.net>, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linaro-acpi@lists.linaro.org, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Jon Masters <jonathan@jonmasters.org>, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>
List-Id: linux-acpi@vger.kernel.org


--===============9056985622669344600==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+zeCMqFCsETNqUaq"
Content-Disposition: inline


--+zeCMqFCsETNqUaq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 05, 2013 at 11:25:02PM +0100, Arnd Bergmann wrote:

> However, as I mentioned before I am much more worried about the parts that
> are not done (or not posted) yet and that will be required to actually
> have working support for a real server system. Until we know more about
> where this is heading, I think we should not merge any of the ARM specific
> parts of your patches. Any patches that are reasonable cleanups and bug
> fixes for the ACPI subsystem should of course get merged once they are
> reviewed.

OTOH if it's well encapsulated, is going to be required for any kind of
ACPI use and gets to the point where people are OK with it by itself
then I'm not sure what we'd gain by keeping it out of tree - it'd make
the real system patch sets bigger and harder to review.

--+zeCMqFCsETNqUaq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSodf+AAoJELSic+t+oim9qgEP/iRplnHmJFMJSO2Q6KWQVpc5
qNmfHc5VNI6fAKZWzkPiIQHnOzTWc9ml7j6Luh9RxvTAgYXStv3r7xi0X2t+Q4Ey
sD84Y21ZKvJU9cqL6usiCDnTtsbWhroT6RIwW0c20z1e84+58KSpdfuDotHkRQ9D
lTgvfdOkNI3CC8TnZKryAT+a7vkDwL66wqa38v2LNYfA9sdNqCeKy0Id8m0D6cU0
hjlS/kvF2eyzj8F0URIOUc+e+LpNIa8hsLRr0aduNlJzjh1O35MxfsEawN/zPPSZ
3mjLRstqCcdLx2SSU0TapD16BG3Nnxa+/i7b2JKLIAfVWro1Hbu7/nUdNNV3imVb
do81y04Oia9T23tjwgLSNzI0ArEXIjy9Gblmap5eUERyS0yDbkvk92iemJhuvaNe
lbmssaAB72gyE1tAR6P5kfBedjSsibPCFNq1Ar0Sw1d+TyyHSPEIOvzlC2Rkl7Lm
K2tx263IFkgxpkCtB2M+eZ9H7WCAn4Rqwto+T8OdqQKzDpLCte1UFSpXuoDYQql+
K8gJ4nE4mKIpUwc1uOCxGmyTRSax/5x0fQCCAwmfR2G6pJW2yW6fgZDLNEduuVXN
NdzKnnvSvkdDzYSIXTM8Wg/rFBdiLNPKco9E7/DvTnFgXHTJZf+FMxFFmoQfZgG9
2dq5fwliLomvW5dxIUKt
=PlnU
-----END PGP SIGNATURE-----

--+zeCMqFCsETNqUaq--


--===============9056985622669344600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9056985622669344600==--
