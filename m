From: Li Shaohua <shaohua.li@intel.com>
Subject: Re: [PATCH 4/5]ACPI PNP driver
Date: Thu, 21 Oct 2004 14:03:14 +0800
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1098338594.6132.234.camel@sli10-desk.sh.intel.com>
References: <1098327568.6132.226.camel@sli10-desk.sh.intel.com>
	 <417750B6.7000409@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S270311AbUJUGMb@vger.kernel.org>
In-Reply-To: <417750B6.7000409@kolumbus.fi>
To: Mika =?ISO-8859-1?Q?Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Adam Belay <ambx1@neo.rr.com>, Matthieu <castet.matthieu@free.fr>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2004-10-21 at 14:01, Mika Penttil=C3=A4 wrote:
> Li Shaohua wrote:
>=20
> >Hi,
> >This patch provides an ACPI based PNP driver. It is based on Matthie=
u
> >Castet's original work. With this patch, legacy device drivers (flop=
py
> >ACPI driver, COM ACPI driver, and ACPI motherboard driver) which
> >directly use ACPI can be removed, since now we have unified PNP
> >interface for legacy devices.
> >
> >Thanks,
> >Shaohua
> >
> >Signed-off-by: Li Shaohua <shaohua.li@intel.com>
> >
> >The patch depends on previous 3 patches.
> >
> >--- 2.6/drivers/pnp/isapnp/Kconfig.stg3	2004-10-18 17:34:17.59171204=
0
> >+0800
> >+++ 2.6/drivers/pnp/isapnp/Kconfig	2004-10-18 17:36:19.173228840 +08=
00
> > =20
> >
> Are you supposed to list here _every_ device to which not to bind? Is=
=20
> this feasible? Maybe take another approach and bind to the "default"=20
> acpi pnp driver if no specific driver found ?
>=20
> +static char excluded_id_list[] =3D
> +	"PNP0C0A," /* Battery */
> +	"PNP0C0C,PNP0C0E,PNP0C0D," /* Button */
> +	"PNP0C09," /* EC */
> +	"PNP0C0B," /* Fan */
> +	"PNP0A03," /* PCI root */
> +	"PNP0C0F," /* Link device */
> +	"PNP0000," /* PIC */
> +	"PNP0100," /* Timer */
> +	;
We can't distinguish if a device has driver. Driver can be loaded as a
module. The devices listed here are mainly be controlled by ACPI core o=
r
can't be controlled by PNP like PIC. This should be a short list.

Thanks,
Shaohua
