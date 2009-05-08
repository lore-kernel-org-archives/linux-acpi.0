From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] x86/pci: do assign root bus res if _CRS is used
Date: Fri, 8 May 2009 16:40:10 -0600
Message-ID: <200905081640.12677.bjorn.helgaas@hp.com>
References: <49ED22EC.2040204@kernel.org> <200904291708.52830.bjorn.helgaas@hp.com> <200904300914.22772.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:37632 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbZEHWkQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 May 2009 18:40:16 -0400
In-Reply-To: <200904300914.22772.bjorn.helgaas@hp.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yhlu.kernel@gmail.com>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, Gary Hade <garyhade@us.ibm.com>, Alex Chiang <achiang@hp.com>, linux-acpi@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>

On Thursday 30 April 2009 09:14:21 am Bjorn Helgaas wrote:
> On Wednesday 29 April 2009 05:08:51 pm Bjorn Helgaas wrote:
> > On Monday 27 April 2009 08:07:01 pm Yinghai Lu wrote:
> > > On Mon, Apr 27, 2009 at 3:24 PM, Bjorn Helgaas <bjorn.helgaas@hp.=
com> wrote:
> > > > On Monday 27 April 2009 03:00:16 pm Yinghai Lu wrote:
> > > >> On Mon, Apr 27, 2009 at 1:39 PM, Bjorn Helgaas <bjorn.helgaas@=
hp.com> wrote:
> > > >> >> other system may have broken _CRS.
> > > >> >
> > > >> > Do you have examples of problems here, or are you just worri=
ed that
> > > >> > there *may* be problems?
> > > >> one system with three chains... with pci=3Duse_crs
> > > >> [ =A0 =A09.365669] pci_bus 0000:00: resource 0 io: =A0[0x00-0x=
3af]
> > > >> [ =A0 =A09.371065] pci_bus 0000:00: resource 1 io: =A0[0x3e0-0=
xcf7]
> > > >> [ =A0 =A09.376551] pci_bus 0000:00: resource 2 io: =A0[0x3b0-0=
x3bb]
> > > >> [ =A0 =A09.382028] pci_bus 0000:00: resource 3 io: =A0[0x3c0-0=
x3df]
> > > >> [ =A0 =A09.387513] pci_bus 0000:00: resource 4 io: =A0[0xd00-0=
xefff]
> > > >> [ =A0 =A09.393077] pci_bus 0000:00: resource 5 mem: [0x0a0000-=
0x0bffff]
> > > >> [ =A0 =A09.399084] pci_bus 0000:00: resource 6 mem: [0x0d0000-=
0x0dffff]
> > > >> [ =A0 =A09.405089] pci_bus 0000:00: resource 7 mem: [0xdd00000=
0-0xdfffffff]
> > > >> [ =A0 =A09.505332] pci_bus 0000:40: resource 0 io: =A0[0x5000-=
0x8fff]
> > > >> [ =A0 =A09.510991] pci_bus 0000:40: resource 1 mem: [0xdb00000=
0-0xdcffffff]
> > > >> [ =A0 =A09.553378] pci_bus 0000:80: resource 0 io: =A0[0x1000-=
0x4fff]
> > > >> [ =A0 =A09.559036] pci_bus 0000:80: resource 1 mem: [0xda00000=
0-0xdaffffff]
> > > >>
> > > >> without that: amd_bus.c will read that from pci conf space
> > > >> [ =A0 =A09.310965] pci_bus 0000:00: resource 0 io: =A0[0x9000-=
0xefff]
> > > >> [ =A0 =A09.316621] pci_bus 0000:00: resource 1 io: =A0[0x00-0x=
fff]
> > > >> [ =A0 =A09.322020] pci_bus 0000:00: resource 2 mem: [0xdd00000=
0-0xdfffffff]
> > > >> [ =A0 =A09.328373] pci_bus 0000:00: resource 3 mem: [0x0a0000-=
0x0bffff]
> > > >> [ =A0 =A09.334378] pci_bus 0000:00: resource 4 mem: [0xc000000=
0-0xd9ffffff]
> > > >> [ =A0 =A09.340731] pci_bus 0000:00: resource 5 mem: [0xf000000=
0-0xffffffff]
> > > >> [ =A0 =A09.347084] pci_bus 0000:00: resource 6 mem: [0x8400000=
00-0xfcffffffff]
> > > >> [ =A0 =A09.444440] pci_bus 0000:40: resource 0 io: =A0[0x5000-=
0x8fff]
> > > >> [ =A0 =A09.450099] pci_bus 0000:40: resource 1 io: =A0[0xf000-=
0xffff]
> > > >> [ =A0 =A09.455757] pci_bus 0000:40: resource 2 mem: [0xdb00000=
0-0xdcffffff]
> > > >> [ =A0 =A09.498118] pci_bus 0000:80: resource 0 io: =A0[0x1000-=
0x4fff]
> > > >> [ =A0 =A09.503777] pci_bus 0000:80: resource 1 mem: [0xda00000=
0-0xdaffffff]
> > > >
> > > > It's interesting that many of the differences involve the legac=
y
> > > > VGA I/O ports in the 0x3b0-0x3df range. =A0My guess is that the=
 AMD
> > > > chipset has special routing for those ranges. =A0If it didn't, =
it
> > > > would be difficult to support VGA devices under the other two
> > > > root bridges. =A0Maybe that VGA routing doesn't show up in the
> > > > bridge's PCI config space. =A0Can you tell from the ASL whether=
 the
> > > > root bridge _SRS/_PRS/_CRS methods handle the VGA ranges specia=
lly?
> > > >
> > > > One of the differences is that PCI config space shows a 64-bit =
region
> > > > (bus 0000:00 mem 0x840000000-0xfcffffffff) that doesn't show up=
 in
> > > > the _CRS info. =A0But the _CRS parsing depends on acpi_resource=
_to_address64(),
> > > > which doesn't know about the ACPI_RESOURCE_TYPE_EXTENDED_ADDRES=
S64
> > > > descriptors added in ACPI 3.0. =A0So this difference could be a=
 result
> > > > of that Linux bug. =A0It'd be interesting to see whether the te=
st patch
> > > > below makes a difference.
> > > will check it.
> >=20
> > Did you learn anything about this?  I have a PNPACPI patch to parse
> > these new descriptors, but I don't have any machines where I can te=
st
> > it.  If your box uses that descriptor, it'd be nice to test the pat=
ch
> > there.
>=20
> Oops, I should have just attached the PNPACPI patch in case anybody
> has a box where it can be tested.  One way to test it would be to
> compare the output of "grep . /sys/devices/pnp*/*/{id,resources,optio=
ns}"
> before and after the patch.  If a BIOS uses the new descriptors, we
> should see some new resources after the patch.

Did anything happen with this?

The longer we wait to make "use_crs" the default, the harder it
will be, so I'd like to push ahead.

Bjorn

> PNPACPI: parse Extended Address Space Descriptors
>=20
> From: Bjorn Helgaas <bjorn.helgaas@hp.com>
>=20
> Extended Address Space Descriptors are new in ACPI 3.0 and allow the
> BIOS to communicate device resource cacheability attributes (write-ba=
ck,
> write-through, uncacheable, etc) to the OS.
>=20
> Previously, PNPACPI ignored these descriptors, so if a BIOS used them=
,
> a device could be responding at addresses the OS doesn't know about.
> This patch adds support for these descriptors in _CRS and _PRS.  We
> don't attempt to encode them for _SRS (just like we don't attempt to
> encode the existing 16-, 32-, and 64-bit Address Space Descriptors).
>=20
> Unfortunately, I don't have a way to test this.
>=20
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>  drivers/pnp/pnpacpi/rsparser.c |   45 ++++++++++++++++++++++++++++++=
++++++++--
>  1 files changed, 43 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsp=
arser.c
> index adf1785..0864242 100644
> --- a/drivers/pnp/pnpacpi/rsparser.c
> +++ b/drivers/pnp/pnpacpi/rsparser.c
> @@ -287,6 +287,25 @@ static void pnpacpi_parse_allocated_address_spac=
e(struct pnp_dev *dev,
>  				ACPI_DECODE_16);
>  }
> =20
> +static void pnpacpi_parse_allocated_ext_address_space(struct pnp_dev=
 *dev,
> +						      struct acpi_resource *res)
> +{
> +	struct acpi_resource_extended_address64 *p =3D &res->data.ext_addre=
ss64;
> +
> +	if (p->producer_consumer =3D=3D ACPI_PRODUCER)
> +		return;
> +
> +	if (p->resource_type =3D=3D ACPI_MEMORY_RANGE)
> +		pnpacpi_parse_allocated_memresource(dev,
> +			p->minimum, p->address_length,
> +			p->info.mem.write_protect);
> +	else if (p->resource_type =3D=3D ACPI_IO_RANGE)
> +		pnpacpi_parse_allocated_ioresource(dev,
> +			p->minimum, p->address_length,
> +			p->granularity =3D=3D 0xfff ? ACPI_DECODE_10 :
> +				ACPI_DECODE_16);
> +}
> +
>  static acpi_status pnpacpi_allocated_resource(struct acpi_resource *=
res,
>  					      void *data)
>  {
> @@ -400,8 +419,7 @@ static acpi_status pnpacpi_allocated_resource(str=
uct acpi_resource *res,
>  		break;
> =20
>  	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
> -		if (res->data.ext_address64.producer_consumer =3D=3D ACPI_PRODUCER=
)
> -			return AE_OK;
> +		pnpacpi_parse_allocated_ext_address_space(dev, res);
>  		break;
> =20
>  	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
> @@ -630,6 +648,28 @@ static __init void pnpacpi_parse_address_option(=
struct pnp_dev *dev,
>  					   IORESOURCE_IO_FIXED);
>  }
> =20
> +static __init void pnpacpi_parse_ext_address_option(struct pnp_dev *=
dev,
> +						    unsigned int option_flags,
> +						    struct acpi_resource *r)
> +{
> +	struct acpi_resource_extended_address64 *p =3D &r->data.ext_address=
64;
> +	unsigned char flags =3D 0;
> +
> +	if (p->address_length =3D=3D 0)
> +		return;
> +
> +	if (p->resource_type =3D=3D ACPI_MEMORY_RANGE) {
> +		if (p->info.mem.write_protect =3D=3D ACPI_READ_WRITE_MEMORY)
> +			flags =3D IORESOURCE_MEM_WRITEABLE;
> +		pnp_register_mem_resource(dev, option_flags, p->minimum,
> +					  p->minimum, 0, p->address_length,
> +					  flags);
> +	} else if (p->resource_type =3D=3D ACPI_IO_RANGE)
> +		pnp_register_port_resource(dev, option_flags, p->minimum,
> +					   p->minimum, 0, p->address_length,
> +					   IORESOURCE_IO_FIXED);
> +}
> +
>  struct acpipnp_parse_option_s {
>  	struct pnp_dev *dev;
>  	unsigned int option_flags;
> @@ -711,6 +751,7 @@ static __init acpi_status pnpacpi_option_resource=
(struct acpi_resource *res,
>  		break;
> =20
>  	case ACPI_RESOURCE_TYPE_EXTENDED_ADDRESS64:
> +		pnpacpi_parse_ext_address_option(dev, option_flags, res);
>  		break;
> =20
>  	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
