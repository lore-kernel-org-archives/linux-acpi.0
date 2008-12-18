From: Ingo Molnar <mingo@elte.hu>
Subject: Re: state of some x86 acpi patches
Date: Thu, 18 Dec 2008 22:47:41 +0100
Message-ID: <20081218214741.GD30834@elte.hu>
References: <4947FF4C.80706@goop.org> <874p111tta.fsf@basil.nowhere.org> <494AA89F.8020308@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:53220 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790AbYLRVrz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Dec 2008 16:47:55 -0500
Content-Disposition: inline
In-Reply-To: <494AA89F.8020308@goop.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <andi@firstfloor.org>, "Brown, Len" <len.brown@intel.com>, Yinghai Lu <yinghai@kernel.org>, linux-acpi@vger.kernel.org


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Andi Kleen wrote:
>> Jeremy Fitzhardinge <jeremy@goop.org> writes:
>>   
>>> However, unlike early_ioremap(), __acpi_map_table just maintains a
>>> single mapping which gets replaced each call, and has no corresponding
>>> unmap function.  Implement this by just removing the previous mapping
>>> each time its called.  Unfortunately, this will leave a stray mapping
>>> at the end.
>>>     
>>
>> Stray mappings are dangerous. They can lead to illegal cache aliases
>> later. Better avoid them.
>>
>> I guess ACPI could call a cleanup function after it's done with
>> all early mappings.
>>   
>
> Right.  But Yinghai (I think) went through and made all the acpi 
> mappings get properly mapped and unmapped, so my patch is moot.

yes, right.

	Ingo
