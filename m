From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH 1/3] ACPI: battery: add power_{now, avg} properties to
 power_class
Date: Sun, 29 Mar 2009 00:59:25 +0300
Message-ID: <49CE9DBD.90200@suse.de>
References: <20090113235739.10548.20626.stgit@thinkpad> <alpine.LFD.2.00.0901161408450.5705@localhost.localdomain> <4970E0B6.5070306@suse.de> <alpine.LFD.2.00.0903170220320.4473@localhost.localdomain> <49BFB1CA.8050700@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:37301 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754932AbZC1V7R (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 17:59:17 -0400
In-Reply-To: <49BFB1CA.8050700@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux-acpi@vger.kernel.org

Hi Len,

Rafael: What I said is that it was too late to change the interpretation of
'current_now' in the case when energy units were used.

My patch does not change interpretation of 'current_now' in the case when energy units are used.
It only adds _new_ power_now and power_avg attributes in this case.

I hope it is clear now.

Regards,
Alex.

Alexey Starikovskiy wrote:
> Len Brown wrote:
>> On Fri, 16 Jan 2009, Alexey Starikovskiy wrote:
>>
>>> 2.6.30?
>>> or 2.6.31?
>>
>> Although we've had this patch in the test tree for a bit,
>> I don't think that any amount of aging in -next will help us here.
>>
>> Is it possible to put the add the new attribute immediately,
>> get buy-in from the user-space guys,
>> and then remove the old attribute in a subsequent patch?
> Actually this is what patch did -- it only mentioned feature removal.
> Attached is the patch with no mention of removal schedule at all.
>>
>> thanks,
>> Len Brown, Intel Open Source Technology Center
> 
> Regards,
> Alex.
> 

