From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: ACPI: EC: Handler for query 0x80 is not found!
Date: Tue, 17 Jul 2007 11:06:48 +0400
Message-ID: <469C6A88.5090406@suse.de>
References: <48f7fe350707100653w6f01c645u388fbb4691b74c6b@mail.gmail.com>	<48f7fe350707100947g1453a790n3e425935994003a9@mail.gmail.com> <20070716203318.66e25911.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:52330 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758177AbXGQHG5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jul 2007 03:06:57 -0400
In-Reply-To: <20070716203318.66e25911.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ryan Hope <rmh3093@gmail.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>


Andrew Morton wrote:
> On Tue, 10 Jul 2007 12:47:08 -0400 "Ryan Hope" <rmh3093@gmail.com> wrote:
> 
>> I noticed that this message goes away if I reboot my computer... So a
>> fresh boot it errors, on reboot it does not error.
>>
>> On 7/10/07, Ryan Hope <rmh3093@gmail.com> wrote:
>>> Ever since 2.6.22-rc6-mm1 I have been seeing these messages in dmesg:
>>>
>>> ACPI: EC: Handler for query 0x80 is not found!
>>> ACPI: EC: Handler for query 0x81 is not found!
>>>
>>> This did not happen in 2.6.22-rc4-mm1. Does anyone have any clue what
>>> this is about?
This is just a printout of the HW error, which we silently ignored before.
Will do a patch to silence it again...
>>>
> 
> (switch to correct mailing list)
> 
> The acpi guys would probably like you to enter this in bugzilla.kernel.org,
> please.

> 
> But given that this will be a regression if we merge it into
> mainline, I hope that it will get urgent attention.
It is not a regression in functionality, just a noise...

Thanks,
Alex.

