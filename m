From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [RFC] ACPI, APEI: Fix incorrect bit width + offset check condition
Date: Wed, 18 Jul 2012 16:24:00 +0800
Message-ID: <500672A0.10808@linux.intel.com>
References: <1339573184-3122-1-git-send-email-hui.xiao@linux.intel.com> <20120613104651.52ce8840@endymion.delvare> <20120613174517.GA2141@us.ibm.com> <4FD98146.9060209@linux.intel.com> <20120614100907.3241376d@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:52656 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753053Ab2GRIYE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jul 2012 04:24:04 -0400
In-Reply-To: <20120614100907.3241376d@endymion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: "Xiao, Hui" <hui.xiao@linux.intel.com>, Gary Hade <garyhade@us.ibm.com>, tony.luck@intel.com, ying.huang@intel.com, lenb@kernel.org, pluto@agmk.net, linux-acpi@vger.kernel.org

=E4=BA=8E 2012/6/14 16:09, Jean Delvare =E5=86=99=E9=81=93:
> On Thu, 14 Jun 2012 14:14:30 +0800, Xiao, Hui wrote:
>>  From your "good example of a valid case" above. I believe we might =
have different
>> understanding of the "Bit Width" field.
>>
>> Just to make sure, do you take "Bit Width" here(1 bit) as the bit le=
ngth one should
>> got for mask /*after*/ shifting bit offset(31 bit) of the access_wid=
th(32 bit)
>> one read from the register(length unknown, or should equal to access=
 length?) ?
>>
>> That's why you think:
>>         bit_width + bit_offset <=3D *access_bit_width
>> is valid.
>
> I am not Gary, but it is also how I read the specification.
>
>> For me I take "Bit Width" as bits of the register for access boundar=
y,
>> so I think:
>>         (*access_bit_width <=3D bit_width) && (bit_offset < *access_=
bit_width)
>> is valid.
>>
>> For you above case, personally I saw you got a 1-bit register, but w=
ant to
>> read 32bit from it, and want to get bit[31] by shifting 31bit and ma=
sk 0x1.
>>
>> Please correct me if I am wrong. Not sure which should be the case A=
CPI SPEC
>> expected. I also have not found any specific explanation on these as=
sumption.
>
> What makes me believe Gary is right is the granularity of each field.
> bit_width and bit_offset can be set with a 1-bit granularity, while
> access_bit_width can only be 8, 16, 32 or 64. This clearly means that
> access_bit_width (and Access Size before that) is a hardware thing,
> while bit_width and bit_offset can only be software things. You've
> never seen I/O ports that can be read 3 or 5 bits at a time...
>

Hi,

Now we have a final decision for this issue? Anyway, we need a patch to
fix our BIOS issue.

Jean or Gary, if OK, would you please cook one patch to fix this issue?
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
