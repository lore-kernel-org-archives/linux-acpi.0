From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
Date: Wed, 10 Aug 2016 20:51:33 +0300
Message-ID: <20160810175133.GA6361@nest>
References: <20160610203210.GA2262@nest>
 <3027571.8eTQaleASL@vostro.rjw.lan>
 <20160611104922.GA2368@nest>
 <2544058.dYPSaC0ylY@vostro.rjw.lan>
 <744357E9AAD1214791ACBA4B0B9092633AA54819@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BBCF836@SHSMSX101.ccr.corp.intel.com>
 <20160613100707.GA2365@nest>
 <1AE640813FDE7649BE1B193DEA596E883BBF7E94@SHSMSX101.ccr.corp.intel.com>
 <20160624213235.GA8304@nest>
 <1AE640813FDE7649BE1B193DEA596E883BC0A4BE@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36750 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752546AbcHJSNh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Aug 2016 14:13:37 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BC0A4BE@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05 Aug, Zheng, Lv wrote:
> Hi, Andrey
>=20
> > From: Andrey Skvortsov [mailto:andrej.skvortzov@gmail.com]
> > Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
> >=20
> > On 24 Jun, Zheng, Lv wrote:
> > > Hi,
> > >
> > > > From: Andrey Skvortsov [mailto:andrej.skvortzov@gmail.com]
> > > > Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
> > > >
> > > > Hi Lv,
> > > >
> > > > On 13 Jun, Zheng, Lv wrote:
> > > > > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > > > > > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > > > > > Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
> > > > > >
> > > > > > On Saturday, June 11, 2016 01:49:22 PM Andrey Skvortsov wrote:
> > > > > > > On 10 Jun, Rafael J. Wysocki wrote:
> > > > > > > > On Friday, June 10, 2016 11:32:10 PM Andrey Skvortsov wrote:
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > On my laptop (DELL Vostro 1500) in v4.7-rc1 is broken
> > suspend
> > > > to RAM.
> > > > > > > > > Laptop doesn't finish suspend to RAM process (disks are o=
ff,
> > but
> > > > > > > > > WiFi and Power LEDs are still on). The only way to get it=
 out of
> > > > > > > > > this state, is to turn the power off.
> > > > > > > > >
> > > > > > > > > I've bisected the issue to commit 66b1ed5aa8dd25
> > > > > > > > > [ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset
> > > > support
> > > > > > > > > for acpi_hw_write()].
> > > > > > > > >
> > > > > > > > > If I revert this commit in v4.7-rc1 (or v4.7-rc2), suspen=
d to
> > RAM
> > > > > > > > > is working again.
> > > > > > > > >
> > > > > > > > > The cause of this problem is that after this commit write=
 to
> > > > PM1A
> > > > > > > > > Control Block (16-bit register) is done using two 8-bit w=
rites.
> > > > > > > > > If I force this write to be 16-bit, then all is working a=
s before.
> > > > > > > > >
> > > > > > > > > To get it working 'access_width' for PM1A Control Block
> > needs to
> > > > > > > > > be 2 (16-bit), but it's 1 (8-bit).
> > > > > [Lv Zheng]
> > > > > Could you send me the acpidump of the machine?
> > > > Here it is
> > > >
> > https://dl.dropboxusercontent.com/u/24023626/dell_vostro_1500.acpid
> > > > ump.bin
> > > [Lv Zheng]
> > > I've been trying to download it these days but all failed.
> > > Could you send an off-list email to me with this attached?
> > Strange. I've check now. The link above is working, but I see that
> > part of the link above is moved to the next line.
> > Anyway I resend you all files off-list.
> >=20
> >=20
> > > > > > > > > The root of the problem seems to be not the commit
> > > > > > 66b1ed5aa8dd25
> > > > > > > > > itself, but the ACPI tables in BIOS where wrong access_wi=
dth
> > > > > > > > > comes from. I fixed problem in FACP  table, put it in ini=
trd to
> > > > > > > > > override FACP table from BIOS. This fixed the issue, susp=
end
> > to
> > > > > > > > > RAM is working now again.
> > > > > > > > >
> > > > > > > > > But I'm not sure whether is this proper fix for this prob=
lem.
> > > > > > > > > Is there any place in the kernel, where such ACPI quirks =
are
> > placed?
> > > > > [Lv Zheng]
> > > > > My question would be:
> > > > > Does Windows behave correctly for this table?
> > > > Yes, suspend to RAM is working under Windows Vista.
> > > > IIRC it worked under Windows XP too.
> > > >
> > > > > However there is a real case showing that there are real tables n=
eed
> > us to
> > > > correctly support BitWidth/BitOffset.
> > > > > Here is the information for you to refer:
> > > > >
> > http://permalink.gmane.org/gmane.linux.kernel.commits.head/313870
> > > > >
> > > > > > > >
> > > > > > > > Well, if the commit in question caused a problem to happen =
for
> > > > you,
> > > > > > > > it also might cause similar problems to happen elsewhere.
> > > > > > > >
> > > > > > > > It looks like we'll need to revert that commit.
> > > > > > > Hi,
> > > > > > >
> > > > > > > or maybe to reset access_width AnyAcc from FACP table only for
> > > > PM1A
> > > > > > > control register or even for all registers? This will fix the=
 issue too.
> > > > > >
> > > > > > That's a good idea actually.
> > > > > >
> > > > > > > diff --git a/drivers/acpi/acpica/tbfadt.c
> > > > > > > b/drivers/acpi/acpica/tbfadt.c index 6208069..a476e94 100644
> > > > > > > --- a/drivers/acpi/acpica/tbfadt.c
> > > > > > > +++ b/drivers/acpi/acpica/tbfadt.c
> > > > > > > @@ -714,7 +714,14 @@ static void
> > > > acpi_tb_setup_fadt_registers(void)
> > > > > > >                         }
> > > > > > >                 }
> > > > > > >         }
> > > > > > >
> > > > > > > +       /*
> > > > > > > +        * Reset access_width in the GAS for PM1A control reg=
ister
> > to
> > > > > > > +        * undefined value. Because in some cases this field =
contains
> > > > > > > +        * wrong value.
> > > > > > > +        */
> > > > > > > +       acpi_gbl_FADT.xpm1a_control_block.access_width =3D 0;
> > > > > >
> > > > > > OK, let's see what Bob and Lv think about that.
> > > > > [Lv Zheng]
> > > > > There is a commit in 4.7-rc2:
> > > > >
> > > >
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D
> > > > 7f9bef9d
> > > > > Have you tried if the problem still exists in 4.7-rc2?
> > > > I've just tried v4.7-rc3. It contains commit 7f9bef9d and the probl=
em
> > > > exists there too.
> > > [Lv Zheng]
> > > IMO, for the time being, you can use quirks.
> > > Booting your kernel with the following parameters:
> > >
> > > acpi=3Drsdt
> > > Or
> > > acpi_force_32bit_fadt_addr
> > > Or
> > > Both
> >=20
> > Rafael reverted commit, so I'm ok now.
> >=20
> > Actually acpi_force_32bit_fadt_addr will not help here, because it's ta=
ke
> > effect only if address64 !=3D address32. But here these addresses are
> > the same, therefore access_width is taken from extended address.
> [Lv Zheng]=20
> This sounds strange.
> My recent investigation shows that Windows may favor 32bit fadt address.
> So we need to get this quirk working.
> I filed a bug here, hope you can help me to dig this a bit further:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D151501

Hi Lv,

That's putty. I uploaded requested acpidump -c off output to bugzilla.


--=20
Best regards,
Andrey Skvortsov



--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXq2mlAAoJEAF8y6L1SLCtVrMQANuLZY0v1AAqECE5STEArXAn
hk1x2903TpxBrr1RutkfZyUU81bNkJd2pyQoopsXMDYrMOiYxsqmX0n4N9FwvROh
9ufv6ewexVTp24xAXubMajK2PmzxmaqsFYXbisIzU27pCDiTrkSIqLQAmMtTZECk
ozwmlOeQIPXnX4ZM1HfbVtX3hyaI7llYFiAju/S8EJSF5AxOc2BHdeloxO68+nIO
3jSiCg53tbtlBl6BSAaB5KaUlsssb3ir/IrAKO8Dfx8KOoZ2Tu4akJMucxx56tJB
ZiFfM8ckZmIPRHQ8kdVbHopu95FFizWmtoHcxHmPaCDLE5UMLgSxMNdCFlkIvb1i
vPYconGDfTNCVXTWFwBqI6IOlOgPs7J2vhQd4TpE22VkswePl50nwh1EHr9GDm6u
dy/QeqdvKsSQosUTFpziUK7SaaNf6jzy+dFfgpVNyVB6X4hYgF4h7sLmby48z5eY
uAeZpwuiRtALR2CJzoqDvsB64qDy27wf7nu9XO8L8+mYQILyqP4w0Be40iQzf813
P8V0usbkJrLmHRKlgR0IyEosi2yCKv1NqAXaJ6oRsEEh6ds8T6XuvxjChdEISkpB
Eehs0m5lz245qgB+jwjUPXED5zxe3hxnbavD2pmL5ppLFeeePv6uRmo5VhL17xQ8
JkQ4qRqMJRXRAmLM5jJZ
=QlQs
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
