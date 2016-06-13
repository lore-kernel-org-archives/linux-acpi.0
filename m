From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
Date: Mon, 13 Jun 2016 13:07:07 +0300
Message-ID: <20160613100707.GA2365@nest>
References: <20160610203210.GA2262@nest>
 <3027571.8eTQaleASL@vostro.rjw.lan>
 <20160611104922.GA2368@nest>
 <2544058.dYPSaC0ylY@vostro.rjw.lan>
 <744357E9AAD1214791ACBA4B0B9092633AA54819@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BBCF836@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36139 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964862AbcFMKHM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jun 2016 06:07:12 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BBCF836@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lv,

On 13 Jun, Zheng, Lv wrote:
> > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
> >=20
> > On Saturday, June 11, 2016 01:49:22 PM Andrey Skvortsov wrote:
> > > On 10 Jun, Rafael J. Wysocki wrote:
> > > > On Friday, June 10, 2016 11:32:10 PM Andrey Skvortsov wrote:
> > > > > Hi,
> > > > >
> > > > > On my laptop (DELL Vostro 1500) in v4.7-rc1 is broken suspend to =
RAM.
> > > > > Laptop doesn't finish suspend to RAM process (disks are off, but
> > > > > WiFi and Power LEDs are still on). The only way to get it out of
> > > > > this state, is to turn the power off.
> > > > >
> > > > > I've bisected the issue to commit 66b1ed5aa8dd25
> > > > > [ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset support
> > > > > for acpi_hw_write()].
> > > > >
> > > > > If I revert this commit in v4.7-rc1 (or v4.7-rc2), suspend to RAM
> > > > > is working again.
> > > > >
> > > > > The cause of this problem is that after this commit write to PM1A
> > > > > Control Block (16-bit register) is done using two 8-bit writes.
> > > > > If I force this write to be 16-bit, then all is working as before.
> > > > >
> > > > > To get it working 'access_width' for PM1A Control Block needs to
> > > > > be 2 (16-bit), but it's 1 (8-bit).
> [Lv Zheng]=20
> Could you send me the acpidump of the machine?
Here it is
https://dl.dropboxusercontent.com/u/24023626/dell_vostro_1500.acpidump.bin

> > > > >
> > > > > The root of the problem seems to be not the commit
> > 66b1ed5aa8dd25
> > > > > itself, but the ACPI tables in BIOS where wrong access_width
> > > > > comes from. I fixed problem in FACP  table, put it in initrd to
> > > > > override FACP table from BIOS. This fixed the issue, suspend to
> > > > > RAM is working now again.
> > > > >
> > > > > But I'm not sure whether is this proper fix for this problem.
> > > > > Is there any place in the kernel, where such ACPI quirks are plac=
ed?
> [Lv Zheng]=20
> My question would be:
> Does Windows behave correctly for this table?
Yes, suspend to RAM is working under Windows Vista.
IIRC it worked under Windows XP too.

> However there is a real case showing that there are real tables need us t=
o correctly support BitWidth/BitOffset.
> Here is the information for you to refer:
> http://permalink.gmane.org/gmane.linux.kernel.commits.head/313870
>=20
> > > >
> > > > Well, if the commit in question caused a problem to happen for you,
> > > > it also might cause similar problems to happen elsewhere.
> > > >
> > > > It looks like we'll need to revert that commit.
> > > Hi,
> > >
> > > or maybe to reset access_width AnyAcc from FACP table only for PM1A
> > > control register or even for all registers? This will fix the issue t=
oo.
> >=20
> > That's a good idea actually.
> >=20
> > > diff --git a/drivers/acpi/acpica/tbfadt.c
> > > b/drivers/acpi/acpica/tbfadt.c index 6208069..a476e94 100644
> > > --- a/drivers/acpi/acpica/tbfadt.c
> > > +++ b/drivers/acpi/acpica/tbfadt.c
> > > @@ -714,7 +714,14 @@ static void acpi_tb_setup_fadt_registers(void)
> > >                         }
> > >                 }
> > >         }
> > >
> > > +       /*
> > > +        * Reset access_width in the GAS for PM1A control register to
> > > +        * undefined value. Because in some cases this field contains
> > > +        * wrong value.
> > > +        */
> > > +       acpi_gbl_FADT.xpm1a_control_block.access_width =3D 0;
> >=20
> > OK, let's see what Bob and Lv think about that.
> [Lv Zheng]=20
> There is a commit in 4.7-rc2:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?i=
d=3D7f9bef9d
> Have you tried if the problem still exists in 4.7-rc2?
I've just tried v4.7-rc3. It contains commit 7f9bef9d and the problem
exists there too.

--=20
Best regards,
Andrey Skvortsov



--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXXoXLAAoJEAF8y6L1SLCtl0QQANCMPsvVqS5z2uRaj/Hww+Ig
DDg4HT70WEJB6ORdR8MzaNS6iiUWOYXgsj7DcN0/b3SwCXwKs7WSfJHzHYhu2CUY
lmUHYHM59W7o53PvPJUZfjUi/Rflm7HjCa50YiaiUJ9mc7rbkkaxVwax4RKkULqw
PwJM/doRkl2PgSB/pfMjA1lsikXzXCtfCgsOwDIV3cZv9OFDTq0yVRayEzvDeB+w
gTBhl04zAvGWxc6XWgLRLvsvb9pKrrKxWk0omHnqxokcaUTx9XAYcz+TzgcK1Oz0
nNcdZIZTdRHUv0y8n9RApLVdWkGhzVYGYhcJfNVnM7vmlZentCLAssay5HPByEdm
EVxJ7jvvDWYNtbJICzfxOxE4Eh8R08kzPOa+lrAz7gP9bt1MQnvq+TmFQbDcYHy/
lrlD8GxE6ekzHP77MJDXBqdFbhnegkMZZZUOljS3CpO23AdWvebqbMDE9yyf2B79
taJaXbD8Y3y1S2Pg3IkOXOAjKlfjz2k1kpriQT1lE8Y2J2NMns9AshF0Sl158EWZ
p0eshDEDlcw0AV50gIoTXvNLuAfF/rzqbiYtnfitunn6q1yvxbLIPUIRHcurNiZh
7Upyugum5ozopYQ4L+5QOksicb5zVbl0hipbDwGIyUDYXiovX7O4sWuYh+I8d5hm
yN46kZx8kEqFEUL1MLIz
=EJ2b
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
