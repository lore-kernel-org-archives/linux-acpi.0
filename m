From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala-ORSVBvAovxo@public.gmane.org>
Subject: Re: Re: [PATCH] smsc-ircc2: Add PnP support.
Date: Sat, 20 Nov 2004 13:43:27 +0200
Message-ID: <20041120114327.GA11797@sci.fi>
References: <E1CVAfT-0002n9-Rn@rhn.tartu-labor> <419E16E5.1000601@free.fr> <419E17FF.1000503@free.fr> <Pine.SOC.4.61.0411191822030.9059@math.ut.ee> <419E2D2B.4020804@free.fr> <Pine.SOC.4.61.0411191934070.29328@math.ut.ee> <419E3B7A.4000904@free.fr> <Pine.SOC.4.61.0411200102580.12992@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.SOC.4.61.0411200102580.12992-ptEonEWSGqKptlylMvRsHA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Meelis Roos <mroos-Y27EyoLml9s@public.gmane.org>
Cc: matthieu castet <castet.matthieu-GANU6spQydw@public.gmane.org>, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jean Tourrilhes <jt-yAE0UhLNZJawPNPzzlOzwdBPR1lH4CV8@public.gmane.org>, Adam Belay <ambx1-IBH0VoN/3vPQT0dZR+AlfA@public.gmane.org>, "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Nov 20, 2004 at 01:09:36AM +0200, Meelis Roos wrote:
>=20
> I tried it with pnpbios (acpi=3Doff) and it started to work after auto =
and=20
> activate (but not with auto alone):
>=20
> nartsiss:/# modprobe smsc-ircc2
> found SMC SuperIO Chip (devid=3D0x5a rev=3D00 base=3D0x002e): LPC47N227
> smsc_superio_flat(): IrDA not enabled
> smsc_superio_flat(): fir: 0x00, sir: 0x00, dma: 15, irq: 0, mode: 0x02
> FATAL: Error inserting smsc_ircc2=20
> (/lib/modules/2.6.10-rc2/kernel/drivers/net/irda/smsc-ircc2.ko): No suc=
h=20
> device
> nartsiss:/# echo activate > resources
> pnp: Device 00:0f activated.
> nartsiss:/# modprobe smsc-ircc2
> found SMC SuperIO Chip (devid=3D0x5a rev=3D00 base=3D0x002e): LPC47N227
> smsc_superio_flat(): fir: 0x2e8, sir: 0x100, dma: 03, irq: 5, mode: 0x0=
e
> SMsC IrDA Controller found
>  IrCC version 2.0, firport 0x2e8, sirport 0x100 dma=3D3, irq=3D5
> No transceiver found. Defaulting to Fast pin select
> IrDA: Registered device irda0

It is using the legacy probe instead of the pnp probe. Did you actually=20
apply the pnp patch?

I'm not entirely sure what has been discussed since somebody removed=20
me from the CC list...

--=20
Ville Syrj=E4l=E4
syrjala-ORSVBvAovxo@public.gmane.org
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
