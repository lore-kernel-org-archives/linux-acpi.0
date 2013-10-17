From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [Resend PATCH 2/5] ACPI/Resource: Add address translation support
Date: Thu, 17 Oct 2013 11:10:42 +0800
Message-ID: <525F5532.7060209@intel.com>
References: <1381493941-4650-1-git-send-email-tianyu.lan@intel.com> <1381493941-4650-3-git-send-email-tianyu.lan@intel.com> <20131016230515.GB17866@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36273 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761745Ab3JQDVE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Oct 2013 23:21:04 -0400
In-Reply-To: <20131016230515.GB17866@google.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: lenb@kernel.org, rjw@sisk.pl, yinghai@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 2013=E5=B9=B410=E6=9C=8817=E6=97=A5 07:05, Bjorn Helgaas wrote:
> On Fri, Oct 11, 2013 at 08:18:58PM +0800, tianyu.lan@intel.com wrote:
>> From: Lan Tianyu <tianyu.lan@intel.com>
>>
>> According ACPI 5.0 spec Section 19.1.8
>=20
> This section reference is wrong.  Table 5-133 (on page 243) does
> point to Section 19.1.8, but that section is only the ASL grammar
> description and doesn't have any useful information about what
> _TRA means.
>=20
> A more useful reference (and the source of the quote below) is
> Section 6.4.3.5.1.
>=20
>> "For bridges, translate addresses across the bridge, this is the
>> offset that must be added to the address on the secondary side
>> to obtain the address on the primary side. Non-bridge devices
>> must list 0."
>=20
> You didn't quote this correctly.  Here's a copy/paste from the spec:
>=20
>     For bridges that translate addresses across the bridge, this is
>     the offset that must be added to the address on the secondary sid=
e
>     to obtain the address on the primary side. Non-bridge devices mus=
t
>     list 0 for all Address Translation offset bits.
>=20
>> This patch is to add address translation offset to the start/end
>> of struct resource in the acpi_dev_resource_address_space().
>> Further more, non-bridge device's translation_offset should 0.
>> So this change will affect other devices.
>>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>=20
> I like the patch, though :)  With the above corrections,

Hi Bjorn:
	Thanks for review. I will correct them.

>=20
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>=20
>> ---
>>  drivers/acpi/resource.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>> index 929f416..84bc3db 100644
>> --- a/drivers/acpi/resource.c
>> +++ b/drivers/acpi/resource.c
>> @@ -192,8 +192,8 @@ bool acpi_dev_resource_address_space(struct acpi=
_resource *ares,
>>  	if (ACPI_FAILURE(status))
>>  		return true;
>> =20
>> -	res->start =3D addr.minimum;
>> -	res->end =3D addr.maximum;
>> +	res->start =3D addr.minimum + addr.translation_offset;
>> +	res->end =3D addr.maximum + addr.translation_offset;
>>  	window =3D addr.producer_consumer =3D=3D ACPI_PRODUCER;
>> =20
>>  	switch(addr.resource_type) {
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
