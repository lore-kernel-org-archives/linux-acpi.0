From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: acpi: broken suspend to RAM with v4.7-rc1
Date: Sat, 11 Jun 2016 13:56:17 +0200
Message-ID: <2544058.dYPSaC0ylY@vostro.rjw.lan>
References: <20160610203210.GA2262@nest> <3027571.8eTQaleASL@vostro.rjw.lan> <20160611104922.GA2368@nest>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1624913.HDR8dQKlmh"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48456 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751173AbcFKLwT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Jun 2016 07:52:19 -0400
In-Reply-To: <20160611104922.GA2368@nest>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Bob Moore <robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, devel@acpica.org, linux-kernel@vger.kernel.orgBob Moore <robert.moore@intel.com>


--nextPart1624913.HDR8dQKlmh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Saturday, June 11, 2016 01:49:22 PM Andrey Skvortsov wrote:
> On 10 Jun, Rafael J. Wysocki wrote:
> > On Friday, June 10, 2016 11:32:10 PM Andrey Skvortsov wrote:
> > > Hi,
> > > 
> > > On my laptop (DELL Vostro 1500) in v4.7-rc1 is broken suspend to RAM.
> > > Laptop doesn't finish suspend to RAM process (disks are off, but WiFi
> > > and Power LEDs are still on). The only way to get it out of this
> > > state, is to turn the power off.
> > > 
> > > I've bisected the issue to commit 66b1ed5aa8dd25
> > > [ACPICA: ACPI 2.0, Hardware: Add access_width/bit_offset support for acpi_h=
> > > w_write()].
> > > 
> > > If I revert this commit in v4.7-rc1 (or v4.7-rc2), suspend to RAM is
> > > working again.
> > > 
> > > The cause of this problem is that after this commit write to PM1A Control B=
> > > lock
> > > (16-bit register) is done using two 8-bit writes. If I force this write
> > > to be 16-bit, then all is working as before.
> > > 
> > > To get it working 'access_width' for PM1A Control Block needs to be 2 (16-b=
> > > it), but it's=20
> > > 1 (8-bit).
> > > 
> > > The root of the problem seems to be not the commit 66b1ed5aa8dd25 itself, b=
> > > ut the ACPI
> > > tables in BIOS where wrong access_width comes from. I fixed problem in FACP=
> > >  table,
> > > put it in initrd to override FACP table from BIOS. This fixed the issue,
> > > suspend to RAM is working now again.
> > > 
> > > But I'm not sure whether is this proper fix for this problem.
> > > Is there any place in the kernel, where such ACPI quirks are placed?
> > 
> > Well, if the commit in question caused a problem to happen for you, it also
> > might cause similar problems to happen elsewhere.
> > 
> > It looks like we'll need to revert that commit.
> Hi,
> 
> or maybe to reset access_width AnyAcc from FACP table only for PM1A control
> register or even for all registers? This will fix the issue too.

That's a good idea actually.

> diff --git a/drivers/acpi/acpica/tbfadt.c b/drivers/acpi/acpica/tbfadt.c
> index 6208069..a476e94 100644
> --- a/drivers/acpi/acpica/tbfadt.c
> +++ b/drivers/acpi/acpica/tbfadt.c
> @@ -714,7 +714,14 @@ static void acpi_tb_setup_fadt_registers(void)
>                         }
>                 }
>         }
> 
> +       /*
> +        * Reset access_width in the GAS for PM1A control register to
> +        * undefined value. Because in some cases this field contains
> +        * wrong value.
> +        */
> +       acpi_gbl_FADT.xpm1a_control_block.access_width = 0;

OK, let's see what Bob and Lv think about that.

--nextPart1624913.HDR8dQKlmh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJXW/xnAAoJEILEb/54YlRxnBMP/jAyrgz1fSDFs6kfyCafM14c
GZq1AuUGHAL8GRCmovXraIlGocPRG/ypIVUf8WB6UF5JJQQOuI0WqdNmgiqhLXoB
P6Lkf2E2XVyqbV8n+uoUZejweKNrCFnznwmDZ+xAdEgvjw/S6djt8dm+xK1B/OHj
DjuPePd4b/sHm6Ts8oOtEV1cAL87KSq4t9bpPQx2KBokBEH0lE/9GyUzm2RVma1G
KPNqSCntb1JXq4Q1IHNWvr3uOxHZvlc7icIdZvxT0m43ZgwkC0fJpglctzNPyv0z
MbeC4rutI5J3+nLm5E7tMHq2aGSh+Jp5pd0iYbs4Aj4bgAWI2ntJQEiuydv/abQd
PUxBBFZf1GmSEiIyhFgcI2YAYuWeEMoTUa8IgX0lYCCR1a9WxJtDMAJNbGXVjcpk
gpyH6SCsjs2q58RcvFabZb7CkoHphT/BOsT0Cbwmogd5VA5KOu/NX6n8YYqV/3MV
Jp5FEPVuGp0GYRLVcO/muc0n/WdZVjovQWxH0slO9coNm55Xja8FAzUcCoN6Au/k
PVhk8sap5MRHQrOLgMCHaPXRhxFBHpywW63DxhpjpNS97P10J37gYZLQuiJSMlEI
PI4kg+0Ppsi7Gp1GM9YJ3NTXjgmtoqbScKEGahiqFxArcD35kGM1wFt50M75R5YX
BvYykUlfySIrJoPhgX1T
=cjnz
-----END PGP SIGNATURE-----

--nextPart1624913.HDR8dQKlmh--

