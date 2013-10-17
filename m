From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [Resend PATCH 5/5] IA64/PCI/ACPI: Rework PCI root bridge ACPI
 resource conversion
Date: Thu, 17 Oct 2013 14:09:19 +0800
Message-ID: <525F7F0F.5010306@intel.com>
References: <1381493941-4650-1-git-send-email-tianyu.lan@intel.com> <1381493941-4650-6-git-send-email-tianyu.lan@intel.com> <20131016235541.GD17866@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20131016235541.GD17866@google.com>
Sender: linux-ia64-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: tony.luck@intel.com, lenb@kernel.org, rjw@sisk.pl, yinghai@kernel.org, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 2013=E5=B9=B410=E6=9C=8817=E6=97=A5 07:55, Bjorn Helgaas wrote:
> On Fri, Oct 11, 2013 at 08:19:01PM +0800, tianyu.lan@intel.com wrote:
>> From: Lan Tianyu <tianyu.lan@intel.com>
>>
>> Using ACPI resource functions to convert ACPI resource to generic re=
source
>>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>> This patch just passes through compilation test due to no ia64 machi=
ne on hand.
>>
>>  arch/ia64/pci/pci.c | 38 +++++++++++++++++++++-----------------
>>  1 file changed, 21 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
>> index 2326790..14fa175 100644
>> --- a/arch/ia64/pci/pci.c
>> +++ b/arch/ia64/pci/pci.c
>> @@ -232,8 +232,9 @@ out:
>>  	return ~0;
>>  }
>> =20
>> -static acpi_status resource_to_window(struct acpi_resource *resourc=
e,
>> -				      struct acpi_resource_address64 *addr)
>> +static acpi_status resource_to_window(struct acpi_resource *ares,
>> +				      struct acpi_resource_address64 *addr,
>> +				      struct resource *res)
>>  {
>>  	acpi_status status;
>> =20
>> @@ -244,7 +245,7 @@ static acpi_status resource_to_window(struct acp=
i_resource *resource,
>>  	 *	- producers, i.e., the address space is routed downstream,
>>  	 *	  not consumed by the bridge itself
>>  	 */
>> -	status =3D acpi_resource_to_address64(resource, addr);
>> +	status =3D acpi_dev_resource_address_space_full(ares, addr, res);
>>  	if (ACPI_SUCCESS(status) &&
>>  	    (addr->resource_type =3D=3D ACPI_MEMORY_RANGE ||
>>  	     addr->resource_type =3D=3D ACPI_IO_RANGE) &&
>> @@ -255,51 +256,54 @@ static acpi_status resource_to_window(struct a=
cpi_resource *resource,
>>  	return AE_ERROR;
>>  }
>> =20
>> -static acpi_status count_window(struct acpi_resource *resource, voi=
d *data)
>> +static acpi_status count_window(struct acpi_resource *ares, void *d=
ata)
>>  {
>>  	unsigned int *windows =3D (unsigned int *) data;
>>  	struct acpi_resource_address64 addr;
>> +	struct resource res;
>>  	acpi_status status;
>> =20
>> -	status =3D resource_to_window(resource, &addr);
>> +	status =3D resource_to_window(ares, &addr, &res);
>>  	if (ACPI_SUCCESS(status))
>>  		(*windows)++;
>> =20
>>  	return AE_OK;
>>  }
>> =20
>> -static acpi_status add_window(struct acpi_resource *res, void *data=
)
>> +static acpi_status add_window(struct acpi_resource *ares, void *dat=
a)
>>  {
>>  	struct pci_root_info *info =3D data;
>> -	struct resource *resource;
>> +	struct resource *resource =3D &info->res[info->res_num];
>>  	struct acpi_resource_address64 addr;
>>  	acpi_status status;
>> -	unsigned long flags, offset =3D 0;
>> +	unsigned long offset =3D 0;
>>  	struct resource *root;
>> =20
>>  	/* Return AE_OK for non-window resources to keep scanning for more=
 */
>> -	status =3D resource_to_window(res, &addr);
>> +	status =3D resource_to_window(ares, &addr, resource);
>>  	if (!ACPI_SUCCESS(status))
>>  		return AE_OK;
>> =20
>> -	if (addr.resource_type =3D=3D ACPI_MEMORY_RANGE) {
>> -		flags =3D IORESOURCE_MEM;
>> +	if (resource->flags & IORESOURCE_MEM) {
>>  		root =3D &iomem_resource;
>>  		offset =3D addr.translation_offset;
>> -	} else if (addr.resource_type =3D=3D ACPI_IO_RANGE) {
>> -		flags =3D IORESOURCE_IO;
>> +	} else if (resource->flags & IORESOURCE_IO) {
>>  		root =3D &ioport_resource;
>>  		offset =3D add_io_space(info, &addr);
>>  		if (offset =3D=3D ~0)
>>  			return AE_OK;
>> +
>> +		/*
>> +		 * io space address translation offset depends
>> +		 * on the return value of add_io_space(). So
>> +		 * Repopulate resource->start and end here.
>=20
> "Repopulate" makes it sound like "resource->start" got clobbered
> somewhere.  But it didn't.  I think it's just that each bridge can
> support its own I/O port range, and the PCI port numbers reported
> in the acpi_resource may not be distinct, and add_io_space() adds
> an offset so all the I/O port ranges fit into one global I/O port
> space.
>=20
> For example, I think these two bridges have the same port numbers
> (0x0-0xfff) in their acpi_resource, but the second has an offset
> of 0x1000000 in the system I/O port space, and I think this offset
> is what add_io_space() returns:
>=20
>   HWP0002:00: host bridge window [io  0x0000-0x0fff]	   (PCI [0x0-0xf=
ff])
>   HWP0002:09: host bridge window [io  0x1000000-0x1000fff] (PCI [0x0-=
0xfff])
>=20
>> +		 */
>> +		resource->start =3D addr.minimum + offset;
>> +		resource->end =3D resource->start + addr.address_length - 1;
>=20
> Can't we use this:
>=20
> 		resource->start +=3D offset;
> 		resource->end +=3D offset;
>=20
> to avoid breaking the encapsulation of struct acpi_resource_address64=
?

resource->start has been populated with "addr.minimum +
addr.translation_offset" in the acpi_dev_resource_address_space().
continuing to add the offset to resource->start seems not right.

The add_io_space() accepts translation_offset and then ioremap it to
mmio address. Add the result to io_space array and assign a space
number. Left shift the space number 24 bits as the return offset of
add_io_space().

When one io port address is accessed, __ia64_mk_io_addr() will do
reverse operations and find associated mmio address.


>=20
>>  	} else
>>  		return AE_OK;
>> =20
>> -	resource =3D &info->res[info->res_num];
>>  	resource->name =3D info->name;
>> -	resource->flags =3D flags;
>> -	resource->start =3D addr.minimum + offset;
>> -	resource->end =3D resource->start + addr.address_length - 1;
>>  	info->res_offset[info->res_num] =3D offset;
>> =20
>>  	if (insert_resource(root, resource)) {
>> --=20
>> 1.8.2.1
>>


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-ia64" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
