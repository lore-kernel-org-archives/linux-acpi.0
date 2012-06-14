From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC] ACPI, APEI: Fix incorrect bit width + offset check
 condition
Date: Thu, 14 Jun 2012 10:09:07 +0200
Message-ID: <20120614100907.3241376d@endymion.delvare>
References: <1339573184-3122-1-git-send-email-hui.xiao@linux.intel.com>
	<20120613104651.52ce8840@endymion.delvare>
	<20120613174517.GA2141@us.ibm.com>
	<4FD98146.9060209@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:30426 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103Ab2FNIJT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jun 2012 04:09:19 -0400
In-Reply-To: <4FD98146.9060209@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Xiao, Hui" <hui.xiao@linux.intel.com>
Cc: Gary Hade <garyhade@us.ibm.com>, tony.luck@intel.com, ying.huang@intel.com, lenb@kernel.org, pluto@agmk.net, linux-acpi@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

On Thu, 14 Jun 2012 14:14:30 +0800, Xiao, Hui wrote:
> From your "good example of a valid case" above. I believe we might have different
> understanding of the "Bit Width" field. 
> 
> Just to make sure, do you take "Bit Width" here(1 bit) as the bit length one should 
> got for mask /*after*/ shifting bit offset(31 bit) of the access_width(32 bit) 
> one read from the register(length unknown, or should equal to access length?) ?
> 
> That's why you think:
>        bit_width + bit_offset <= *access_bit_width
> is valid.

I am not Gary, but it is also how I read the specification.

> For me I take "Bit Width" as bits of the register for access boundary,
> so I think:
>        (*access_bit_width <= bit_width) && (bit_offset < *access_bit_width)
> is valid. 
> 
> For you above case, personally I saw you got a 1-bit register, but want to
> read 32bit from it, and want to get bit[31] by shifting 31bit and mask 0x1.
> 
> Please correct me if I am wrong. Not sure which should be the case ACPI SPEC
> expected. I also have not found any specific explanation on these assumption. 

What makes me believe Gary is right is the granularity of each field.
bit_width and bit_offset can be set with a 1-bit granularity, while
access_bit_width can only be 8, 16, 32 or 64. This clearly means that
access_bit_width (and Access Size before that) is a hardware thing,
while bit_width and bit_offset can only be software things. You've
never seen I/O ports that can be read 3 or 5 bits at a time...

-- 
Jean Delvare
