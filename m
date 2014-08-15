From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 19/19] Documentation: ACPI for ARM64
Date: Sat, 16 Aug 2014 00:19:25 +0100
Message-ID: <20140815231925.GO17528@sirena.org.uk>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <8599266.1aeEWcB8r7@wuerfel>
 <CAOesGMiOzRYmmYcBV=eFr8U-e_BJAUg9gpnT0DPwJuyxBz9-1g@mail.gmail.com>
 <201408152149.44283.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7993313755426903187=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <201408152149.44283.arnd@arndb.de>
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@v>
List-Id: linux-acpi@vger.kernel.org


--===============7993313755426903187==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wK+SlNydXbKOQbu4"
Content-Disposition: inline


--wK+SlNydXbKOQbu4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 15, 2014 at 09:49:44PM +0200, Arnd Bergmann wrote:

> Agreed. I think we had already concluded previously when discussing this
> patch that the clock management in APCI-5.1 should not be used on ARM64,
> but I think there is a problem one level deeper: The 5.0 and 5.1 versions
> apparently add a lot of new features that are meant for either ARM64
> servers or embedded x86 machines. These two typically have conflicting
> requirements, and it would be better for the specification itself to
> provide clearer statements to which parts apply in what use case rather
> than us (the Linux people) making claims about what parts of the spec
> are acceptable or not.

> There are already two specified classes of systems, the legacy x86
> and itanium machines, and the "reduced hardware" profile, which
> apparently covers both of the new types of machines mentioned above.

We also have legacy machines taking bits of the new stuff to contend
with.

> What would be the process to get a clarification into the next version
> of ACPI that makes them more distinct?

I agree with this, I actually had some patches come in this week which
seem to be worse than anything we've talked about and were intended just
key off DMI data instead of any form of platform data AFAICT.  The
pushback was that the Windows driver was doing this and the BIOS wasn't
about to change for us.  I'm not really convinced that waving some Linux
internal document about ARM servers at them is going to be terribly
persuasive to get them to improve future systems.

--wK+SlNydXbKOQbu4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT7pV6AAoJELSic+t+oim9aFQP/iXmbmf42doQixzEgPKk/Vk0
3OOHfqmFojPRd+6alpyhZ29Cd8b7/rMZv6hiXED3cnJ5RTuiPgZqPAcuP7GGf1dv
uiJiAUOExgKxegVs3c1iYsOCPSAkvWxzZWchVRO/nGQgD+wo/GpnldOLDj2l2B9C
8TKp4SrmWcVtCME83J+4hD7Q+DADOLGXjXU93HZXE/WhEFVNOy0pG+GDHCYdjeKm
Bud6w+NwX7+PiKaoX+/aaNeLdmB0VeV1itYvHtG4bn2Y1YJCW6vcILW6IPUhuyDn
S9Kx1YRf5Z5ciP5dYdaoek0E+pdQSSik2QiWbaMu+V9qRbptQ5cw26p3GGmpPSGv
xBz77ukdiHsiTyez5XPgwQcSbV9zIKdxijntHphWiY1VjHSfzE9Xb00Az0JXTSKZ
y0SYM4r+9ahI2/XG+DPSQCq5DYfHxzLP8aUdeNtnMwJdB6mRy8mFxFA3HbCJ20Yl
k25mOwtPNqQKEgfTjw+cy+GR/CRwH3btClTCaSmPuqMx7BxCbbt3ERT1SC9ZfhmM
j4RnA82IGWWIIN3FRYSsQnfKuwVbeluw7GzLhltzpcW5jDgTj0KofN1FRG/hJzrM
rjESx2RO10AqeQewnVZT6n4teK4Os6TAbR8VKsuck+HJ2COHRVwdGUmaEkCP5SjD
YVPicPIbYdop8RGrCBFE
=o/fs
-----END PGP SIGNATURE-----

--wK+SlNydXbKOQbu4--


--===============7993313755426903187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7993313755426903187==--
