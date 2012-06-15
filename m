From: "Xiao, Hui" <hui.xiao@linux.intel.com>
Subject: Re: [RFC] ACPI, APEI: Fix incorrect bit width + offset check condition
Date: Fri, 15 Jun 2012 19:28:51 +0800
Message-ID: <4FDB1C73.2080009@linux.intel.com>
References: <1339573184-3122-1-git-send-email-hui.xiao@linux.intel.com> <20120613104651.52ce8840@endymion.delvare> <20120613174517.GA2141@us.ibm.com> <4FD98146.9060209@linux.intel.com> <20120614100907.3241376d@endymion.delvare> <20120614163245.GA1999@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:1799 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753915Ab2FOL24 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Jun 2012 07:28:56 -0400
In-Reply-To: <20120614163245.GA1999@us.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Gary Hade <garyhade@us.ibm.com>
Cc: Jean Delvare <khali@linux-fr.org>, tony.luck@intel.com, ying.huang@intel.com, lenb@kernel.org, pluto@agmk.net, linux-acpi@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

On 2012/6/15 0:32, Gary Hade wrote:
> On Thu, Jun 14, 2012 at 10:09:07AM +0200, Jean Delvare wrote:
>> On Thu, 14 Jun 2012 14:14:30 +0800, Xiao, Hui wrote:
>>> From your "good example of a valid case" above. I believe we might have different
>>> understanding of the "Bit Width" field. 
>>>
>>> Just to make sure, do you take "Bit Width" here(1 bit) as the bit length one should 
>>> got for mask /*after*/ shifting bit offset(31 bit) of the access_width(32 bit) 
>>> one read from the register(length unknown, or should equal to access length?) ?
>>>
>>> That's why you think:
>>>        bit_width + bit_offset <= *access_bit_width
>>> is valid.
>>
>> I am not Gary, but it is also how I read the specification.
> 
> Thanks, Jean.  It seemed like the correct interpretation to me.
> 
>>
>>> For me I take "Bit Width" as bits of the register for access boundary,
>>> so I think:
>>>        (*access_bit_width <= bit_width) && (bit_offset < *access_bit_width)
>>> is valid. 
> 
> This is not the check that the patch contains.  It also does not
> verify that an access will read or write all of the register bits.
> 
>>>
>>> For you above case, personally I saw you got a 1-bit register, but want to
>>> read 32bit from it, and want to get bit[31] by shifting 31bit and mask 0x1.
>>>
>>> Please correct me if I am wrong. Not sure which should be the case ACPI SPEC
>>> expected. I also have not found any specific explanation on these assumption. 
>>
>> What makes me believe Gary is right is the granularity of each field.
>> bit_width and bit_offset can be set with a 1-bit granularity, while
>> access_bit_width can only be 8, 16, 32 or 64. This clearly means that
>> access_bit_width (and Access Size before that) is a hardware thing,
>> while bit_width and bit_offset can only be software things. You've
>> never seen I/O ports that can be read 3 or 5 bits at a time...
> 
> The "<= Access Size" in this diagram will hopefully clarify the
> "bit_width + bit_offset <= *access_bit_width" check:
> 
>     |<------------------  <= Access Size ----------------->|
>     |<-- Register Bit Width -->|<-- Register Bit Offset -->|
>  |<--------------------- Access Size --------------------->|
>                                                            ^
>                                                            |
>                                                  Address --+
> 
> The case described in the patch header looks like:
> 
>    |<-- Register Bit Width (64) -->|<-- Register Bit Offset (0) -->|
>    |<-------+------>|<----------- Access Size (32)---------------->|
>             |                                                      ^
>             +-- **neglected register bits**                        |        
>                                                          Address --+
> 
> The 1 bit width register example I provided looks like:
> 
>    |<-- Register Bit Width (1) -->|<-- Register Bit Offset (31) -->|
>    |<------------------ Access Size (32)-------------------------->|
>                                                                    ^
>                                                                    |
>                                                          Address --+
> 
> Gary
> 

Hi Jean and Gary,

Thanks. Got your point. Your explanation also makes sense to me.

Just an example to clarify the check of:
"(*access_bit_width <= bit_width) && (bit_offset < *access_bit_width)"

                  |<--Mask (1)-->|<--Register Bit Offset (31)-->| // final bit range got
                  |<------------Access Size (32)--------------->| // lower 32-bit accessible
|<------------------- Access Size (64)------------------------->| // all accessible
|<-------------- Register Bit Width (64) ---------------------->| // 64-bit register    
                                                                ^
                                                                |
                                                      Address --+

-Hui
