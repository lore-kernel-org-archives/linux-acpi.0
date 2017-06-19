From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v2] platform/x86: wmi-bmof: New driver to expose embedded Binary WMI MOF metadata
Date: Mon, 19 Jun 2017 18:19:36 +0200
Message-ID: <201706191819.37016@pali>
References: <cd020900567e5c26af29e0735a3945a855d26a30.1496718529.git.dvhart@infradead.org> <201706191807.42574@pali> <074e9d5668864a81b255df178ed28814@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1529724.S0X51JoGHI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <074e9d5668864a81b255df178ed28814@ausx13mpc120.AMER.DELL.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: luto@kernel.org, platform-driver-x86@vger.kernel.org, andriy.shevchenko@linux.intel.com, luto@amacapital.net, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

--nextPart1529724.S0X51JoGHI
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Monday 19 June 2017 18:13:13 Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: Pali Roh=C3=A1r [mailto:pali.rohar@gmail.com]
> > Sent: Monday, June 19, 2017 11:08 AM
> > To: Andy Lutomirski <luto@kernel.org>
> > Cc: platform-driver-x86@vger.kernel.org; Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com>; Andy Lutomirski
> > <luto@amacapital.net>; Limonciello, Mario
> > <Mario_Limonciello@Dell.com>; Rafael Wysocki <rjw@rjwysocki.net>;
> > linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org Subject:
> > Re: [PATCH v2] platform/x86: wmi-bmof: New driver to expose
> > embedded Binary WMI MOF metadata
> >=20
> > On Tuesday 06 June 2017 05:16:44 Andy Lutomirski wrote:
> > > Many laptops (and maybe servers?) have embedded WMI Binary MOF
> > > metadata. We do not yet have open-source tools for processing the
> > >=20
> > > data, although one is in the works thanks to Pali:
> > > 	https://github.com/pali/bmfdec
> > >=20
> > > There is currently no interface to get the data in the first
> > > place. By exposing it, we facilitate the development of new
> > > tools.
> > >=20
> > > Signed-off-by: Andy Lutomirski <luto@kernel.org>
> > > Cc: Andy Lutomirski <luto@amacapital.net>
> > > Cc: Mario Limonciello <mario_limonciello@dell.com>
> > > Cc: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> > > Cc: linux-kernel@vger.kernel.org
> > > Cc: platform-driver-x86@vger.kernel.org
> > > Cc: linux-acpi@vger.kernel.org
> > > [dvhart: make sysfs mof binary read only, fixup comment block
> > > format] [dvhart: use bmof terminology and dev_err instead of
> > > dev_warn] Acked-by: Rafael J. Wysocki
> > > <rafael.j.wysocki@intel.com> Signed-off-by: Darren Hart (VMware)
> > > <dvhart@infradead.org> ---
> > >=20
> > > since-v1:
> > >  * address Pali's comments:
> > >    * update the cover letter for clarity and accuracy
> > >    * update mof->bmof and MOF to Binary MOF throughout the patch
> > >    * use dev_err instead of dev_warn in wmi_bmof_probe
> > > =20
> > >  drivers/platform/x86/Kconfig    |  12 ++++
> > >  drivers/platform/x86/Makefile   |   1 +
> > >  drivers/platform/x86/wmi-bmof.c | 125
> >=20
> > Another suggestion (unrelated to this patch): For working with
> > ACPI-WMI, this binary MOF buffer is not enough. It is needed also
> > content of _WDG buffer. What about exporting it too via sysfs?
> > Probably not part of of wmi-bmof driver, but wmi driver itself.
>=20
> I think this depends upon how the userspace access to WMI methods
> gets implemented, no?  If userpsace access to WMI methods show up as
> /dev/wmi-$GUID-$INSTANCE and those internally to the kernel map to
> the proper ASL methods for example, what you get from wmi-bmof
> should be enough shouldn't it?

Ok. Such interface for userspace application could be enough.

But for debugging purposes or writing new WMI driver it is needed to=20
have both _WDG + BMOF.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1529724.S0X51JoGHI
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAllH+ZkACgkQi/DJPQPkQ1JkGwCeI7GseCuij4vI9v59TXXGPEot
6vgAn3k0q0dSe4gDLyp3esZeVaBVLWaV
=6hOk
-----END PGP SIGNATURE-----

--nextPart1529724.S0X51JoGHI--
