From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2 08/13] ACPICA: Hardware: Add optimized access bit width
 support
Date: Fri, 27 May 2016 13:31:36 -0400
Message-ID: <57488478.1070406@oracle.com>
References: <cover.1462331120.git.lv.zheng@intel.com>
 <cover.1462418912.git.lv.zheng@intel.com>
 <fe932d47355c652fa7114c369a427b44626da92a.1462418912.git.lv.zheng@intel.com>
 <5745FA2C.8020303@oracle.com>
 <574731DD02000078000E92FC@prv-mh.provo.novell.com>
 <57472A95.5050100@oracle.com>
 <1AE640813FDE7649BE1B193DEA596E883BBB1530@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:25077 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756231AbcE0Rbx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 May 2016 13:31:53 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BBB1530@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, Jan Beulich <jbeulich@suse.com>
Cc: "ian.jackson@eu.citrix.com" <ian.jackson@eu.citrix.com>, "zetalog@gmail.com" <zetalog@gmail.com>, "Brown, Len" <len.brown@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 05/27/2016 03:34 AM, Zheng, Lv wrote:
> Hi,
>
>> From: Boris Ostrovsky [mailto:boris.ostrovsky@oracle.com]
>> Subject: Re: [PATCH v2 08/13] ACPICA: Hardware: Add optimized access
>> bit width support
>>
>> On 05/26/2016 12:26 PM, Jan Beulich wrote:
>>>>>> Boris Ostrovsky <boris.ostrovsky@oracle.com> 05/25/16 9:17
>> PM >>>
>>>> On 05/05/2016 12:58 AM, Lv Zheng wrote:
>>>>> +static u8
>>>>> +acpi_hw_get_access_bit_width(struct acpi_generic_address *reg, u8
>> max_bit_width)
>>>>> +{
>>>>> +    u64 address;
>>>>> +
>>>>> +    if (!reg->access_width) {
>>>>> +        /*
>>>>> +         * Detect old register descriptors where only the bit_width field
>>>>> +         * makes senses. The target address is copied to handle possible
>>>>> +         * alignment issues.
>>>>> +         */
>>>>> +        ACPI_MOVE_64_TO_64(&address, &reg->address);
>>>>> +        if (!reg->bit_offset && reg->bit_width &&
>>>>> +            ACPI_IS_POWER_OF_TWO(reg->bit_width) &&
>>>>> +            ACPI_IS_ALIGNED(reg->bit_width, 8) &&
>>>>> +            ACPI_IS_ALIGNED(address, reg->bit_width)) {
>>>>> +            return (reg->bit_width);
>>>>> +        } else {
>>>>> +            if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
>>>>> +                return (32);
>>>> This (together with "... Add access_width/bit_offset support in
>>>> acpi_hw_write") breaks Xen guests using older QEMU which doesn't
>> support
>>>> 4-byte IO accesses.
>>>>
>>>> Why not return "reg->bit_width?:max_bit_width" ? This will preserve
>>>> original behavior.
>>> Did you figure out why we get here in the first place, instead of taking
>> the
>>> first "return"? I.e. isn't the issue the apparently wrong use of the second
>>> ACPI_IS_ALIGNED() above? Afaict it ought to be
>>> ACPI_IS_ALIGNED(address, reg->bit_width / 8)...
>> We are trying to access address 0x...b004 (PM1a control) so yes, fixing
>> alignment check would probably resolve the problem that we are seeing
>> now.
>>
>> However, for compatibility purposes we may consider not doing any
>> checks
>> and simply return bit_width if access_width is not available.
> [Lv Zheng] 

Your patch from earlier does resolve both issues, thanks.

> Your solution could result in problems like:
> If a GAS is defined with bit_width not a power of 2, and access_width is any (0).
>
> So the correct fix here is to make sure if bit_width is exactly 8,16,32,64, which matches old register descriptors.
> I added address check here because I want to limit this regression safe check to old register descriptors.
> As since the old bit_width can actually reflect the register's access width, the address of the register should always be aligned.
>
> There might be cases that using the new GAS register descriptor format, it is possible to define a GAS that is not aligned, and it's bit_width is exactly 8,16,32,64.
> We shouldn't make a default access_width decision using bit_width here.

True. But OTOH switching to 32-bit accesses may result in us suddenly
trying to touch bytes we haven't accessed before.

-boris


> The address check here can help to avoid applying this workaround on such cases.
>
> Thanks and best regards
> -Lv


