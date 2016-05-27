From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v2 08/13] ACPICA: Hardware: Add optimized access bit
 width support
Date: Fri, 27 May 2016 03:14:26 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BBB0C0C@SHSMSX101.ccr.corp.intel.com>
References: <cover.1462331120.git.lv.zheng@intel.com>
 <cover.1462418912.git.lv.zheng@intel.com>
 <fe932d47355c652fa7114c369a427b44626da92a.1462418912.git.lv.zheng@intel.com>
 <5745FA2C.8020303@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5745FA2C.8020303@oracle.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, Ian Jackson <ian.jackson@eu.citrix.com>, Jan Beulich <jbeulich@suse.com>, xen-devel <xen-devel@lists.xen.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Boris Ostrovsky
> Sent: Thursday, May 26, 2016 3:17 AM
> Subject: Re: [PATCH v2 08/13] ACPICA: Hardware: Add optimized access bit
> width support
> 
> On 05/05/2016 12:58 AM, Lv Zheng wrote:
> > ACPICA commit c49a751b4dae7baec1790748a2b4b6e8ab599f51
> >
> > For Access Size = 0, it actually can use user expected access bit width.
> > This patch implements this.
> >
> > Besides of the ACPICA upstream commit, this patch also includes a fix fixing
> > the issue reported by the FreeBSD community.
> > The old register descriptors are translated in acpi_tb_init_generic_address()
> > with access_width being filled with 0. This breaks code in
> > acpi_hw_get_access_bit_width() when the registers are 16-bit IO ports and
> their
> > bit_width fields are filled with 16. The rapid fix is meant to make code
> > written for acpi_hw_get_access_bit_width() regression safer before the issue
> is
> > correctly fixed from acpi_tb_init_generic_address(). Reported by
> > John Baldwin <jhb@freebsd.org>, fixed by Lv Zheng <lv.zheng@intel.com>,
> tested
> > by Jung-uk Kim <jkim@freebsd.org>.
> >
> > Link: https://github.com/acpica/acpica/commit/c49a751b
> > Reported-by: John Baldwin <jhb@freebsd.org>
> > Tested-by Jung-uk Kim <jkim@freebsd.org>.
> > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> > Signed-off-by: Bob Moore <robert.moore@intel.com>
> > ---
> >  drivers/acpi/acpica/hwregs.c |   49
> ++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 47 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
> > index 035fb52..892e677 100644
> > --- a/drivers/acpi/acpica/hwregs.c
> > +++ b/drivers/acpi/acpica/hwregs.c
> > @@ -51,6 +51,10 @@ ACPI_MODULE_NAME("hwregs")
> >
> >  #if (!ACPI_REDUCED_HARDWARE)
> >  /* Local Prototypes */
> > +static u8
> > +acpi_hw_get_access_bit_width(struct acpi_generic_address *reg,
> > +			     u8 max_bit_width);
> > +
> >  static acpi_status
> >  acpi_hw_read_multiple(u32 *value,
> >  		      struct acpi_generic_address *register_a,
> > @@ -65,6 +69,48 @@ acpi_hw_write_multiple(u32 value,
> >
> >
> /***************************************************************
> ***************
> >   *
> > + * FUNCTION:    acpi_hw_get_access_bit_width
> > + *
> > + * PARAMETERS:  reg                 - GAS register structure
> > + *              max_bit_width       - Max bit_width supported (32 or 64)
> > + *
> > + * RETURN:      Status
> > + *
> > + * DESCRIPTION: Obtain optimal access bit width
> > + *
> > +
> ****************************************************************
> **************/
> > +
> > +static u8
> > +acpi_hw_get_access_bit_width(struct acpi_generic_address *reg, u8
> max_bit_width)
> > +{
> > +	u64 address;
> > +
> > +	if (!reg->access_width) {
> > +		/*
> > +		 * Detect old register descriptors where only the bit_width field
> > +		 * makes senses. The target address is copied to handle
> possible
> > +		 * alignment issues.
> > +		 */
> > +		ACPI_MOVE_64_TO_64(&address, &reg->address);
> > +		if (!reg->bit_offset && reg->bit_width &&
> > +		    ACPI_IS_POWER_OF_TWO(reg->bit_width) &&
> > +		    ACPI_IS_ALIGNED(reg->bit_width, 8) &&
> > +		    ACPI_IS_ALIGNED(address, reg->bit_width)) {
> > +			return (reg->bit_width);
> > +		} else {
> > +			if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
> > +				return (32);
> 
> This (together with "... Add access_width/bit_offset support in
> acpi_hw_write") breaks Xen guests using older QEMU which doesn't support
> 4-byte IO accesses.
> 
> Why not return "reg->bit_width?:max_bit_width" ? This will preserve
> original behavior.
[Lv Zheng] 

Let me ask 2 questions:

A. Was this a bug of the older qemu?
If so, you only need a quirk mechanism for old qemu to work.
And it would be better to provide the quirk inside of the older qemu.

B. Could you provide the detailed register description?
The case I saw from the freebsd community around the qemu is a bit_width = 16 case.
Which is a conversion result of acpi_tb_init_generic_address().
Thus:
1. reg->access_width is always 0
2. reg->bit_offset is always 0
3. reg->bit_width is either 8 or 16
So they can be covered by this check:
if (reg->access_width) {
    if (!reg->bit_offset && reg->bit_width &&
        ACPI_IS_POWER_OF_TWO(reg->bit_width) &&
        ACPI_IS_ALIGNED(reg->bit_width, 8))
I just enhanced it with the address check: ACPI_IS_ALIGNED(address, reg->bit_width)

For your case, what the values of "address/access_width" are?
Can it be fixed by:
1. Either removing ACPI_IS_ALIGNED(address, reg->bit_width), or
2. moving the entire check out of if (!reg->access_width) to form:
if (!reg->bit_offset && reg->bit_width &&
    ACPI_IS_POWER_OF_TWO(reg->bit_width) &&
    ACPI_IS_ALIGNED(reg->bit_width, 8) &&
    ACPI_IS_ALIGNED(address, reg->bit_width)) {
    return (reg->bit_width);
} else if (reg->access_width) {
    return (1 << (reg->access_width + 2));
} else {
    if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
        return (32);
    } else {
        return (max_bit_width);
    }
}

Thanks
-Lv

> 
> -boris
> 
> > +			} else {
> > +				return (max_bit_width);
> > +			}
> > +		}
> > +	} else {
> > +		return (1 << (reg->access_width + 2));
> > +	}
> > +}
> > +
> >
> +/**************************************************************
> ****************
> > + *
> >   * FUNCTION:    acpi_hw_validate_register
> >   *
> >   * PARAMETERS:  reg                 - GAS register structure
> > @@ -122,8 +168,7 @@ acpi_hw_validate_register(struct
> acpi_generic_address *reg,
> >
> >  	/* Validate the bit_width, convert access_width into number of bits */
> >
> > -	access_width = reg->access_width ? reg->access_width : 1;
> > -	access_width = 1 << (access_width + 2);
> > +	access_width = acpi_hw_get_access_bit_width(reg, max_bit_width);
> >  	bit_width =
> >  	    ACPI_ROUND_UP(reg->bit_offset + reg->bit_width, access_width);
> >  	if (max_bit_width < bit_width) {
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
