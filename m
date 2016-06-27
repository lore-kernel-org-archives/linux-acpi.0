From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
Date: Mon, 27 Jun 2016 11:49:11 +0300
Message-ID: <20160627084911.GN13845@localhost.localdomain>
References: <20160610203210.GA2262@nest>
 <3027571.8eTQaleASL@vostro.rjw.lan>
 <20160611104922.GA2368@nest>
 <2544058.dYPSaC0ylY@vostro.rjw.lan>
 <744357E9AAD1214791ACBA4B0B9092633AA54819@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BBCF836@SHSMSX101.ccr.corp.intel.com>
 <20160613100707.GA2365@nest>
 <1AE640813FDE7649BE1B193DEA596E883BBF7E94@SHSMSX101.ccr.corp.intel.com>
 <20160624213235.GA8304@nest>
 <1AE640813FDE7649BE1B193DEA596E883BBFA365@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nb8zVy0QMK3AA1xu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BBFA365@SHSMSX101.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


--nb8zVy0QMK3AA1xu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 27 Jun, Zheng, Lv wrote:
> Hi,
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
> [Lv Zheng]=20
> Maybe this is just because of ISP firewall.
>=20
> > Anyway I resend you all files off-list.
> [Lv Zheng]=20
> Great!
>=20
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
> >=20
> > http://lxr.free-electrons.com/source/drivers/acpi/acpica/tbfadt.c#L576
> [Lv Zheng]=20
> In addition to the address check, we may add access width check here.
> I need to check this with the decision makers.
Make sense. But then it's necessary to set default access width for registe=
rs from
FADT for this check. Because in the old 32-bit part of FADT only address and
length are defined, but not access width.=20


> > acpi=3Drsdt helps. Thanks for the information about this option. I
> > missed it, when I read documentation.
> [Lv Zheng]=20
> Great to know that at least 1 quirk works.
> Back to this bug, it seems we should use fixed access_width for some pre-=
defined PM registers.
This is what I meant by suggesting to reset xpm1a's
access_width to zero (or maybe another registers from FADT too) in
acpi_tb_setup_fadt_registers (see quoted diff above from my previous answer=
).=20
If access_width is zero, then code works as before and access_width is=20
calculated by acpi_hw_get_access_bit_width (will return reg->bit_width or
max_bit_width(32) in our case).

Setting access_width to some pre-defined value is an option.
But it's not as flexible, because ACPI specification doesn't define
access width and some pre-defined PM registers have variable length
and only the minimal register length is defined (PM1A Control Reg, PM1B Con=
trol
Reg, PM1A event block, PM1B event block).

Previously you pointed to commit that requires usage of access
width field.
http://permalink.gmane.org/gmane.linux.kernel.commits.head/313870
I see it's related to APEI, therefore setting access_width for
registers in FADT will not affect it.


--=20
Best regards,
Andrey Skvortsov

--nb8zVy0QMK3AA1xu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJXcOiHAAoJEAF8y6L1SLCtL20QAKljmBmwnMqKdEipHWH4n96+
i7uTdLDraCMNelk1E9TFNZwVwUHjoOmxyBjv6Sqywrc04tbo21k32FhIaWR+DdrB
e2TPrHScjd2ULuUXxN19saLVEO/xQKcwBgKZhDBnUsA12p9GhIkGSwHiColHDEQz
9WpB8fIgXqnkbcZeg2RQTGIjd6MS9XIt/0vbt0SGDo6pdPjdFzsr+xAtiQa3wVVR
3FLtJQ1JJ8+JyfUI7VaAFRMeF3DqAfzSHXHPoS6pN5b2ViiIFJjBsETZwGouTNFB
3mJhPQPI5fjnVhid+ovDyYJyLQdfbz35yM3y/XYivBQmFZmG9hWpLAHq9xv+wYgy
RGdrvWHaojeM73VYFM/UZVXxdtTWXNz18OCBso72eHy4TKySL+cMl6Wbg8Kep+OP
07dHDgIwZZ7/qZzh0W1yUmFgl4atjv4NwGidF+0N4T4yXCu4iieROm5rSrEFt26S
HFvxre712ChE0oPThBnFEXY1/6syAcUbCi1ffSJwYJd2eeq5TAEw4xrfs6Fu88jZ
JgUEjaOsit8Q9tNWNOEH2A7B7T+2v3EA0FdYYaDwq/jEhSmTfjvY176KYtbG1FQ0
MRm6zP+ni/MpNucx3OzbevF4FluXlZENx8l6id2OX6upQ+DGE+CzrKtknFdbq3UQ
tXCTRyzlc27cmjb7eCCB
=Cbtb
-----END PGP SIGNATURE-----

--nb8zVy0QMK3AA1xu--
