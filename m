From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [Resend PATCH 3/5] ACPI: Add new acpi_dev_resource_address_space_full()
 function
Date: Thu, 17 Oct 2013 11:29:39 +0800
Message-ID: <525F59A3.4000803@intel.com>
References: <1381493941-4650-1-git-send-email-tianyu.lan@intel.com> <1381493941-4650-4-git-send-email-tianyu.lan@intel.com> <20131016231836.GC17866@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:21796 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761650Ab3JQDkF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Oct 2013 23:40:05 -0400
In-Reply-To: <20131016231836.GC17866@google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: lenb@kernel.org, rjw@sisk.pl, yinghai@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 2013=E5=B9=B410=E6=9C=8817=E6=97=A5 07:18, Bjorn Helgaas wrote:
> On Fri, Oct 11, 2013 at 08:18:59PM +0800, tianyu.lan@intel.com wrote:
>> From: Lan Tianyu <tianyu.lan@intel.com>
>>
>> Make acpi_dev_resource_address_space() to accept struct
>> acpi_resource_address64 as param and rename it to *_full.
>>
>> This is for some cases that acpi address info is also needed
>> after convert from acpi resouce to generic resource.
>=20
> s/resouce/resource/
>=20
>> Add acpi_dev_resource_addres_space() again as a wrapper of new
>=20
> acpi_dev_resource_address_space() (spelled wrong above).
>=20
>> function for original users.
>>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>>  drivers/acpi/resource.c | 53 ++++++++++++++++++++++++++++++++++----=
-----------
>>  include/linux/acpi.h    |  3 +++
>>  2 files changed, 40 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index 84bc3db..2e395ba 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -162,19 +162,21 @@ bool acpi_dev_resource_io(struct acpi_resource=
 *ares, struct resource *res)
>>  EXPORT_SYMBOL_GPL(acpi_dev_resource_io);
>> =20
>>  /**
>> - * acpi_dev_resource_address_space - Extract ACPI address space inf=
ormation.
>> + * acpi_dev_resource_address_space_full - Extract ACPI address spac=
e information.
>>   * @ares: Input ACPI resource object.
>> + * @addr: Output ACPI resource address64 space object.
>>   * @res: Output generic resource object.
>>   *
>>   * Check if the given ACPI resource object represents an address sp=
ace resource
>> - * and if that's the case, use the information in it to populate th=
e generic
>> - * resource object pointed to by @res.
>> + * and if that's the case, convert it to ACPI resource address64 sp=
ace object
>> + * pointed to by @addr and use the information to populate the gene=
ric resource
>> + * object pointed to by @re.
>=20
> s/@re/@res/ or maybe even just use this:
>=20
> "If @ares is an address space resource, convert it to an
> acpi_resource_address64 and use that to populate the generic @res."
>=20
>>   */
>> -bool acpi_dev_resource_address_space(struct acpi_resource *ares,
>> +bool acpi_dev_resource_address_space_full(struct acpi_resource *are=
s,
>> +				     struct acpi_resource_address64 *addr,
>>  				     struct resource *res)
>>  {
>>  	acpi_status status;
>> -	struct acpi_resource_address64 addr;
>>  	bool window;
>>  	u64 len;
>>  	u8 io_decode;
>> @@ -188,29 +190,29 @@ bool acpi_dev_resource_address_space(struct ac=
pi_resource *ares,
>>  		return false;
>>  	}
>> =20
>> -	status =3D acpi_resource_to_address64(ares, &addr);
>> +	status =3D acpi_resource_to_address64(ares, addr);
>>  	if (ACPI_FAILURE(status))
>>  		return true;
>=20
> You didn't actually change this, but it looks wrong to return "true"
> here, because we haven't filled in "res".  Returning "true" will caus=
e
> acpi_dev_process_resource() to call acpi_dev_new_resource_entry() wit=
h
> a struct resource that's full of zeroes.
>=20
> I think the best fix would be to remove this code just above:
>=20
>         switch (ares->type) {
>         case ACPI_RESOURCE_TYPE_ADDRESS16:
>         case ACPI_RESOURCE_TYPE_ADDRESS32:
>         case ACPI_RESOURCE_TYPE_ADDRESS64:
>                 break;
>         default:
>                 return false;
>         }
>=20
> and return "false" if acpi_resource_to_address64() fails.

Yes, Just check acpi_resource_to_address64() and it only processes
ACPI_RESOURCE_TYPE_ADDRESS16, ACPI_RESOURCE_TYPE_ADDRESS32 and
ACPI_RESOURCE_TYPE_ADDRESS64. If other type,  it will return false.
I will change it.

>=20
>> =20
>> -	res->start =3D addr.minimum + addr.translation_offset;
>> -	res->end =3D addr.maximum + addr.translation_offset;
>> -	window =3D addr.producer_consumer =3D=3D ACPI_PRODUCER;
>> +	res->start =3D addr->minimum + addr->translation_offset;
>> +	res->end =3D addr->maximum + addr->translation_offset;
>> +	window =3D addr->producer_consumer =3D=3D ACPI_PRODUCER;
>> =20
>> -	switch(addr.resource_type) {
>> +	switch (addr->resource_type) {
>>  	case ACPI_MEMORY_RANGE:
>> -		len =3D addr.maximum - addr.minimum + 1;
>> +		len =3D addr->maximum - addr->minimum + 1;
>>  		res->flags =3D acpi_dev_memresource_flags(len,
>> -						addr.info.mem.write_protect,
>> +						addr->info.mem.write_protect,
>>  						window);
>> =20
>> -		if (addr.info.mem.caching =3D=3D ACPI_PREFETCHABLE_MEMORY)
>> +		if (addr->info.mem.caching =3D=3D ACPI_PREFETCHABLE_MEMORY)
>>  			res->flags |=3D IORESOURCE_PREFETCH;
>>  		break;
>>  	case ACPI_IO_RANGE:
>> -		io_decode =3D addr.granularity =3D=3D 0xfff ?
>> +		io_decode =3D addr->granularity =3D=3D 0xfff ?
>>  				ACPI_DECODE_10 : ACPI_DECODE_16;
>> -		res->flags =3D acpi_dev_ioresource_flags(addr.minimum,
>> -						       addr.maximum,
>> +		res->flags =3D acpi_dev_ioresource_flags(addr->minimum,
>> +						       addr->maximum,
>>  						       io_decode, window);
>>  		break;
>>  	case ACPI_BUS_NUMBER_RANGE:
>> @@ -222,6 +224,25 @@ bool acpi_dev_resource_address_space(struct acp=
i_resource *ares,
>> =20
>>  	return true;
>>  }
>> +EXPORT_SYMBOL_GPL(acpi_dev_resource_address_space_full);
>> +
>> +/**
>> + * acpi_dev_resource_address_space - Extract ACPI address space inf=
ormation.
>> + * @ares: Input ACPI resource object.
>> + * @res: Output generic resource object.
>> + *
>> + * Check if the given ACPI resource object represents an address sp=
ace resource
>> + * and if that's the case, use the information in it to populate th=
e generic
>> + * resource object pointed to by @res.
>=20
> "If @ares is an address space resource, use it to populate the generi=
c @res."
>=20
>> + */
>> +bool acpi_dev_resource_address_space(struct acpi_resource *ares,
>> +				     struct resource *res)
>> +{
>> +	struct acpi_resource_address64 addr;
>> +
>> +	return acpi_dev_resource_address_space_full(ares, &addr,
>> +							 res);
>> +}
>>  EXPORT_SYMBOL_GPL(acpi_dev_resource_address_space);
>> =20
>>  /**
>> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
>> index a5db4ae..1f6701e 100644
>> --- a/include/linux/acpi.h
>> +++ b/include/linux/acpi.h
>> @@ -260,6 +260,9 @@ bool acpi_dev_resource_memory(struct acpi_resour=
ce *ares, struct resource *res);
>>  bool acpi_dev_resource_io(struct acpi_resource *ares, struct resour=
ce *res);
>>  bool acpi_dev_resource_address_space(struct acpi_resource *ares,
>>  				     struct resource *res);
>> +bool acpi_dev_resource_address_space_full(struct acpi_resource *are=
s,
>> +				struct acpi_resource_address64 *addr,
>> +				struct resource *res);
>>  bool acpi_dev_resource_ext_address_space(struct acpi_resource *ares=
,
>>  					 struct resource *res);
>>  unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 sha=
reable);
>> --=20
>> 1.8.2.1
>>


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
