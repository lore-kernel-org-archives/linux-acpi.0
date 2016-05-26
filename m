From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [PATCH v2 08/13] ACPICA: Hardware: Add optimized access bit width
 support
Date: Thu, 26 May 2016 12:55:49 -0400
Message-ID: <57472A95.5050100@oracle.com>
References: <cover.1462331120.git.lv.zheng@intel.com>
 <cover.1462418912.git.lv.zheng@intel.com>
 <fe932d47355c652fa7114c369a427b44626da92a.1462418912.git.lv.zheng@intel.com>
 <5745FA2C.8020303@oracle.com>
 <574731DD02000078000E92FC@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:45616 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660AbcEZQ4H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 May 2016 12:56:07 -0400
In-Reply-To: <574731DD02000078000E92FC@prv-mh.provo.novell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan Beulich <jbeulich@suse.com>
Cc: ian.jackson@eu.citrix.com, zetalog@gmail.com, len.brown@intel.com, lv.zheng@intel.com, rafael.j.wysocki@intel.com, robert.moore@intel.com, xen-devel@lists.xen.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 05/26/2016 12:26 PM, Jan Beulich wrote:
>>>> Boris Ostrovsky <boris.ostrovsky@oracle.com> 05/25/16 9:17 PM >>>
>> On 05/05/2016 12:58 AM, Lv Zheng wrote:
>>> +static u8
>>> +acpi_hw_get_access_bit_width(struct acpi_generic_address *reg, u8 max_bit_width)
>>> +{
>>> +    u64 address;
>>> +
>>> +    if (!reg->access_width) {
>>> +        /*
>>> +         * Detect old register descriptors where only the bit_width field
>>> +         * makes senses. The target address is copied to handle possible
>>> +         * alignment issues.
>>> +         */
>>> +        ACPI_MOVE_64_TO_64(&address, &reg->address);
>>> +        if (!reg->bit_offset && reg->bit_width &&
>>> +            ACPI_IS_POWER_OF_TWO(reg->bit_width) &&
>>> +            ACPI_IS_ALIGNED(reg->bit_width, 8) &&
>>> +            ACPI_IS_ALIGNED(address, reg->bit_width)) {
>>> +            return (reg->bit_width);
>>> +        } else {
>>> +            if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_IO) {
>>> +                return (32);
>> This (together with "... Add access_width/bit_offset support in
>> acpi_hw_write") breaks Xen guests using older QEMU which doesn't support
>> 4-byte IO accesses.
>>
>> Why not return "reg->bit_width?:max_bit_width" ? This will preserve
>> original behavior.
> Did you figure out why we get here in the first place, instead of taking the
> first "return"? I.e. isn't the issue the apparently wrong use of the second
> ACPI_IS_ALIGNED() above? Afaict it ought to be
> ACPI_IS_ALIGNED(address, reg->bit_width / 8)...

We are trying to access address 0x...b004 (PM1a control) so yes, fixing
alignment check would probably resolve the problem that we are seeing now.

However, for compatibility purposes we may consider not doing any checks
and simply return bit_width if access_width is not available.

-boris


