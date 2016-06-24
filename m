From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
Date: Sat, 25 Jun 2016 00:32:35 +0300
Message-ID: <20160624213235.GA8304@nest>
References: <20160610203210.GA2262@nest>
 <3027571.8eTQaleASL@vostro.rjw.lan>
 <20160611104922.GA2368@nest>
 <2544058.dYPSaC0ylY@vostro.rjw.lan>
 <744357E9AAD1214791ACBA4B0B9092633AA54819@SHSMSX101.ccr.corp.intel.com>
 <1AE640813FDE7649BE1B193DEA596E883BBCF836@SHSMSX101.ccr.corp.intel.com>
 <20160613100707.GA2365@nest>
 <1AE640813FDE7649BE1B193DEA596E883BBF7E94@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33935 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbcFXVck (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jun 2016 17:32:40 -0400
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BBF7E94@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24 Jun, Zheng, Lv wrote:
> Hi,
>=20
> > From: Andrey Skvortsov [mailto:andrej.skvortzov@gmail.com]
> > Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
> >=20
> > Hi Lv,
> >=20
> > On 13 Jun, Zheng, Lv wrote:
> > > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > > > owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> > > > Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
> > > >
> > > > On Saturday, June 11, 2016 01:49:22 PM Andrey Skvortsov wrote:
> > > > > On 10 Jun, Rafael J. Wysocki wrote:
> > > > > > On Friday, June 10, 2016 11:32:10 PM Andrey Skvortsov wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > On my laptop (DELL Vostro 1500) in v4.7-rc1 is broken suspend
> > to RAM.
> > > > > > > Laptop doesn't finish suspend to RAM process (disks are off, =
but
> > > > > > > WiFi and Power LEDs are still on). The only way to get it out=
 of
> > > > > > > this state, is to turn the power off.
> > > > > > >
> > > > > > > I've bisected the issue to commit 66b1ed5aa8dd25
> > > > > > > [ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset
> > support
> > > > > > > for acpi_hw_write()].
> > > > > > >
> > > > > > > If I revert this commit in v4.7-rc1 (or v4.7-rc2), suspend to=
 RAM
> > > > > > > is working again.
> > > > > > >
> > > > > > > The cause of this problem is that after this commit write to
> > PM1A
> > > > > > > Control Block (16-bit register) is done using two 8-bit write=
s.
> > > > > > > If I force this write to be 16-bit, then all is working as be=
fore.
> > > > > > >
> > > > > > > To get it working 'access_width' for PM1A Control Block needs=
 to
> > > > > > > be 2 (16-bit), but it's 1 (8-bit).
> > > [Lv Zheng]
> > > Could you send me the acpidump of the machine?
> > Here it is
> > https://dl.dropboxusercontent.com/u/24023626/dell_vostro_1500.acpid
> > ump.bin
> [Lv Zheng]=20
> I've been trying to download it these days but all failed.
> Could you send an off-list email to me with this attached?
Strange. I've check now. The link above is working, but I see that
part of the link above is moved to the next line.
Anyway I resend you all files off-list.


> > > > > > > The root of the problem seems to be not the commit
> > > > 66b1ed5aa8dd25
> > > > > > > itself, but the ACPI tables in BIOS where wrong access_width
> > > > > > > comes from. I fixed problem in FACP  table, put it in initrd =
to
> > > > > > > override FACP table from BIOS. This fixed the issue, suspend =
to
> > > > > > > RAM is working now again.
> > > > > > >
> > > > > > > But I'm not sure whether is this proper fix for this problem.
> > > > > > > Is there any place in the kernel, where such ACPI quirks are =
placed?
> > > [Lv Zheng]
> > > My question would be:
> > > Does Windows behave correctly for this table?
> > Yes, suspend to RAM is working under Windows Vista.
> > IIRC it worked under Windows XP too.
> >=20
> > > However there is a real case showing that there are real tables need =
us to
> > correctly support BitWidth/BitOffset.
> > > Here is the information for you to refer:
> > > http://permalink.gmane.org/gmane.linux.kernel.commits.head/313870
> > >
> > > > > >
> > > > > > Well, if the commit in question caused a problem to happen for
> > you,
> > > > > > it also might cause similar problems to happen elsewhere.
> > > > > >
> > > > > > It looks like we'll need to revert that commit.
> > > > > Hi,
> > > > >
> > > > > or maybe to reset access_width AnyAcc from FACP table only for
> > PM1A
> > > > > control register or even for all registers? This will fix the iss=
ue too.
> > > >
> > > > That's a good idea actually.
> > > >
> > > > > diff --git a/drivers/acpi/acpica/tbfadt.c
> > > > > b/drivers/acpi/acpica/tbfadt.c index 6208069..a476e94 100644
> > > > > --- a/drivers/acpi/acpica/tbfadt.c
> > > > > +++ b/drivers/acpi/acpica/tbfadt.c
> > > > > @@ -714,7 +714,14 @@ static void
> > acpi_tb_setup_fadt_registers(void)
> > > > >                         }
> > > > >                 }
> > > > >         }
> > > > >
> > > > > +       /*
> > > > > +        * Reset access_width in the GAS for PM1A control registe=
r to
> > > > > +        * undefined value. Because in some cases this field cont=
ains
> > > > > +        * wrong value.
> > > > > +        */
> > > > > +       acpi_gbl_FADT.xpm1a_control_block.access_width =3D 0;
> > > >
> > > > OK, let's see what Bob and Lv think about that.
> > > [Lv Zheng]
> > > There is a commit in 4.7-rc2:
> > >
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D
> > 7f9bef9d
> > > Have you tried if the problem still exists in 4.7-rc2?
> > I've just tried v4.7-rc3. It contains commit 7f9bef9d and the problem
> > exists there too.
> [Lv Zheng]=20
> IMO, for the time being, you can use quirks.
> Booting your kernel with the following parameters:
>=20
> acpi=3Drsdt
> Or
> acpi_force_32bit_fadt_addr
> Or
> Both

Rafael reverted commit, so I'm ok now.

Actually acpi_force_32bit_fadt_addr will not help here, because it's take
effect only if address64 !=3D address32. But here these addresses are
the same, therefore access_width is taken from extended address.

http://lxr.free-electrons.com/source/drivers/acpi/acpica/tbfadt.c#L576


acpi=3Drsdt helps. Thanks for the information about this option. I
missed it, when I read documentation.



--=20
Best regards,
Andrey Skvortsov



--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXbabzAAoJEAF8y6L1SLCtccoQAMd07cXcwDjcbW3RYszbWsw6
96MZUMkiXfKkI/Nyp3gXkaQKSx6rLHcZmfXOUMCVJU4GKEIS76yxCK29+1RvvpHt
kO/0o53VGjlBV/KB3jFb77x60RkA/h6xWf89+sTz+3T9lJBkEQE/rpEgrwKrua4F
2rdDtibOSzQpNKpeEpu0ZCxWwp/PNyCZxvZcPA7fIog41HrxQ+2nXHDRW1m002Nj
UZS2IUFflAskKyswNsfVKzO5qnWx+aYVkWcIK48aT0sgQWSnsjIDgWIhblJh4ZQr
PiljAJkLOJ4+ZDbZsVVpLbFLUR6dSYp+nHoAjQVcn4MSkcgxnHFAqNnyZZiQNBTQ
1bgh0Mcp2Qh6S8GsUSa6e1JhENj0JwqrSouXYFRXQ9iZrFZQr2PzydQDr0KXQjgg
l72eMo6smzgA9lhIlrUx1imHiIWIP4kY2qCv5uYoEzZGO55dzH99cwdOovswldmE
Ai9U1AEQmquyHBSd6HbTFYmp1YzVd8KqbaULimhWhccdtP9Z4+kl8tFgK07R4vhj
XfEipQlJ8Rm9wvXxpXPPky3vKh+DPd/jw99RDwE0SZwuqFEy3NTWP7DeH86rQOya
qjKnzziDrScjWF4+rSEFvIuiWByEujK35lyKzRhAMZRm8MJluKmt+SK+LTAl+HSN
VId8scJYzRsGOEPij88/
=+eNb
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
