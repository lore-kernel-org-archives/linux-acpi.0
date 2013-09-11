From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFC PATCH 2/4] ACPI/Resource: Add address translation support
Date: Wed, 11 Sep 2013 10:26:37 -0400
Message-ID: <52307D9D.3070801@intel.com>
References: <1378477486-8758-1-git-send-email-tianyu.lan@intel.com> <1378477486-8758-3-git-send-email-tianyu.lan@intel.com> <12539726.iB4h1i35EF@vostro.rjw.lan> <522D3002.5050304@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <522D3002.5050304@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: lenb@kernel.org, yinghai@kernel.org, bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 09/08/2013 10:18 PM, Lan Tianyu wrote:
> On 2013=E5=B9=B409=E6=9C=8807=E6=97=A5 08:15, Rafael J. Wysocki wrote=
:
>> On Friday, September 06, 2013 10:24:44 AM Lan Tianyu wrote:
>>> According ACPI 5.0 spec Section 19.1.8
>>> "For bridges, translate addresses across the bridge, this is the
>>> offset that must be added to the address on the secondary side
>>> to obtain the address on the primary side. Non-bridge devices
>>> must list 0."
>>
>> Can you please have a look into the previous versions of the spec an=
d double
>> check that this change won't confuse systems that implement them?
>>
>
> Hi Rafael:
>           I check all versions. This part has existed and not been
> changed since ACPI 1.0.
>

Hi Rafael:
	Do you have other comments on this?


>> Otherwise it looks OK to me.
>>
>> Thanks,
>> Rafael
>>
>>
>>> This patch is to add address translation offset to the start/end
>>> of struct resource in the acpi_dev_resource_address_space().
>>> Further more, non-bridge device's translation_offset should 0.
>>> So this change will affect other devices.
>>>
>>>
>>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>>> ---
>>>   drivers/acpi/resource.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>>> index 929f416..84bc3db 100644
>>> --- a/drivers/acpi/resource.c
>>> +++ b/drivers/acpi/resource.c
>>> @@ -192,8 +192,8 @@ bool acpi_dev_resource_address_space(struct acp=
i_resource *ares,
>>>   	if (ACPI_FAILURE(status))
>>>   		return true;
>>>
>>> -	res->start =3D addr.minimum;
>>> -	res->end =3D addr.maximum;
>>> +	res->start =3D addr.minimum + addr.translation_offset;
>>> +	res->end =3D addr.maximum + addr.translation_offset;
>>>   	window =3D addr.producer_consumer =3D=3D ACPI_PRODUCER;
>>>
>>>   	switch(addr.resource_type) {
>>>
>
>
