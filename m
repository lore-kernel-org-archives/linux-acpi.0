From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [RFC] ACPI, APEI: Fix incorrect bit width + offset check
 condition
Date: Thu, 14 Jun 2012 09:53:30 +0200
Message-ID: <20120614095330.7d797f1d@endymion.delvare>
References: <1339573184-3122-1-git-send-email-hui.xiao@linux.intel.com>
	<20120613104651.52ce8840@endymion.delvare>
	<4FD86EFF.1080004@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:45567 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354Ab2FNHxv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jun 2012 03:53:51 -0400
In-Reply-To: <4FD86EFF.1080004@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Xiao, Hui" <hui.xiao@linux.intel.com>
Cc: garyhade@us.ibm.com, tony.luck@intel.com, ying.huang@intel.com, lenb@kernel.org, pluto@agmk.net, linux-acpi@vger.kernel.org, Chen Gong <gong.chen@linux.intel.com>

Hi Hui,

On Wed, 13 Jun 2012 18:44:15 +0800, Xiao, Hui wrote:
> On 2012/6/13 16:46, Jean Delvare wrote:
> > If the access code is supposed to be able to read large registers in
> > smaller chunks and assemble them transparently to a larger value, then
> > there is no point in having any check at all, everything is valid. If
> > not, then the above is just as invalid as the firmware issue discussed
> > in bug #43282.
>
> Able to read large registers in smaller chunk, I think so and the register
> bit width set the access boundary.

My understanding is that Access Size, not Register Bit Width, sets the
access boundary. Thus the name.

> For "assemble them transparently to a larger value, then...", not quite 
> understand what you mean here....

I mean that:

    - Register bit width: 32 bits
    - Register bit offset: 0
    - Access Size: 01 [Byte Access: 08]

can be considered invalid (Gary's point of view) but it could also be
interpreted as: hardware can only be accessed 8-bit at a time, but we
have a logical 32-bit register, so the software ACPI layer should issue
4 8-bit reads, and assemble the read values into a 32-bit value. This
obviously raises the issue of endianess, but I guess ACPI implies
little-endian anyway?

Anyway, this was really meant as a question, as I am no ACPI expert. I
don't think our ACPI code currently implements such read gathering, but
I don't know if this is by lack of time or need, or because it is
simply not supposed to be needed ever.

> > (...)
> > I can't make any sense of this test, sorry. And it will trigger on
> > valid cases, starting with the most frequent case where
> > *access_bit_width == bit_width. So, nack.
> > 
> The condition here is for checking invalid GAR. When 
>   *access_bit_width == bit_width
> I don't think my code will trigger the error.

Doh, I don't know what I was up to yesterday, but obviously I was wrong
here, sorry.

> Instead, the original condition
> will trigger the error once bit_offset != 0, which doesn't make sense.

No, it won't, depending on the value of bit_width.

> Besides if addressing a data structure, per ACPI spec bit_width and bit_offset
> must be zero, the original condition will always end with error even valid 
> access width is given.

I agree that the original test did not support the data structure case.
OTOH after quickly reading the relevant page of the ACPI specification,
I do not understand how the structure size is passed, so I have no idea
how this case could be handled.

-- 
Jean Delvare
