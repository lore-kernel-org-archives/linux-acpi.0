From: Boszormenyi Zoltan <zboszor@pr.hu>
Subject: Re: [Bugfix v2] PCI, ACPI: Fix regressions caused by resource_size_t
 overflow with 32bit kernel
Date: Wed, 24 Jun 2015 10:25:46 +0200
Message-ID: <558A698A.9000508@pr.hu>
References: <1435131817-28167-1-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1435131817-28167-1-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Ingo Molnar <mingo@kernel.org>, Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
List-Id: linux-acpi@vger.kernel.org

2015-06-24 09:43 keltez=E9ssel, Jiang Liu =EDrta:
> Since commit 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource
> interfaces to simplify implementation"), x86 PCI ACPI host bridge dri=
ver
> validates ACPI resources by first converting an ACPI resource to
> a 'struct resource' structure and then applying checks against the
> converted resource structure. The 'start' and 'end' fields in 'struct
> resource' are defined to be type of resource_size_t, which may be 32 =
bits
> or 64 bits depending on CONFIG_PHYS_ADDR_T_64BIT.
>
> This may cause incorrect resource validation results with 32 bit kern=
els
> because 64bit ACPI resource descriptors may get truncated when conver=
ting
> to 32bit 'start' and 'end' fields in 'struct resource'. And eventuall=
y
> affects PCI resource allocation subsystem and causes some PCI devices
> unusable.
>
> So enhance the ACPI resource parsing interfaces to ignore ACPI resour=
ce
> descriptors with address/offset observe 4G when running in 32bit mode=
=2E
> This reverts to the behavior before commit 593669c2ac0f.
>
> This issue was triggered on a platform running 32bit kernel with an
> ACPI resource descriptor with address range [0x400000000-0xfffffffff]=
=2E
> Please refer to https://lkml.org/lkml/2015/6/19/277 for more informat=
ion.
>
> Reported-by: Boszormenyi Zoltan <zboszor@pr.hu>
> Fixes: 593669c2ac0f ("x86/PCI/ACPI: Use common ACPI resource interfac=
es to simplify implementation")
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Cc: stable@vger.kernel.org # 4.0
> ---
>
> Hi Zoltan,
> 	Could you please help to test this patch against the latest kernel?
> Thanks!
> Gerry

I will, thanks.

Best regards,
Zolt=E1n

>
> ---
>  drivers/acpi/resource.c |   24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 8244f013f210..f1c966e05078 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -193,6 +193,7 @@ static bool acpi_decode_space(struct resource_win=
 *win,
>  	u8 iodec =3D attr->granularity =3D=3D 0xfff ? ACPI_DECODE_10 : ACPI=
_DECODE_16;
>  	bool wp =3D addr->info.mem.write_protect;
>  	u64 len =3D attr->address_length;
> +	u64 start, end, offset =3D 0;
>  	struct resource *res =3D &win->res;
> =20
>  	/*
> @@ -204,9 +205,6 @@ static bool acpi_decode_space(struct resource_win=
 *win,
>  		pr_debug("ACPI: Invalid address space min_addr_fix %d, max_addr_fi=
x %d, len %llx\n",
>  			 addr->min_address_fixed, addr->max_address_fixed, len);
> =20
> -	res->start =3D attr->minimum;
> -	res->end =3D attr->maximum;
> -
>  	/*
>  	 * For bridges that translate addresses across the bridge,
>  	 * translation_offset is the offset that must be added to the
> @@ -214,12 +212,22 @@ static bool acpi_decode_space(struct resource_w=
in *win,
>  	 * primary side. Non-bridge devices must list 0 for all Address
>  	 * Translation offset bits.
>  	 */
> -	if (addr->producer_consumer =3D=3D ACPI_PRODUCER) {
> -		res->start +=3D attr->translation_offset;
> -		res->end +=3D attr->translation_offset;
> -	} else if (attr->translation_offset) {
> +	if (addr->producer_consumer =3D=3D ACPI_PRODUCER)
> +		offset =3D attr->translation_offset;
> +	else if (attr->translation_offset)
>  		pr_debug("ACPI: translation_offset(%lld) is invalid for non-bridge=
 device.\n",
>  			 attr->translation_offset);
> +	start =3D attr->minimum + offset;
> +	end =3D attr->maximum + offset;
> +
> +	win->offset =3D offset;
> +	res->start =3D start;
> +	res->end =3D end;
> +	if (sizeof(resource_size_t) < sizeof(u64) &&
> +	    (offset !=3D win->offset || start !=3D res->start || end !=3D r=
es->end)) {
> +		pr_warn("acpi resource window ([%#llx-%#llx] ignored, not CPU addr=
essable)\n",
> +			attr->minimum, attr->maximum);
> +		return false;
>  	}
> =20
>  	switch (addr->resource_type) {
> @@ -236,8 +244,6 @@ static bool acpi_decode_space(struct resource_win=
 *win,
>  		return false;
>  	}
> =20
> -	win->offset =3D attr->translation_offset;
> -
>  	if (addr->producer_consumer =3D=3D ACPI_PRODUCER)
>  		res->flags |=3D IORESOURCE_WINDOW;
> =20
