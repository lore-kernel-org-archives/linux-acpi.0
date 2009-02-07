From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: state of some x86 acpi patches
Date: Fri, 06 Feb 2009 18:58:34 -0800
Message-ID: <498CF8DA.30004@goop.org>
References: <4947FF4C.80706@goop.org> <20081216192534.GB843@elte.hu> <alpine.LFD.2.00.0812311821110.3854@localhost.localdomain> <495C677F.6080707@goop.org> <20090102153957.GA1180@elte.hu> <4980EE0C.4070308@goop.org> <49810211.9030808@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:37956 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675AbZBGC6h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Feb 2009 21:58:37 -0500
In-Reply-To: <49810211.9030808@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Yinghai Lu wrote:
> Jeremy Fitzhardinge wrote:
>   
>> Ingo Molnar wrote:
>>     
>>> yes, that end result is the desired state of things. We did run with
>>> this for several months and resolved all the cases that needed fixing,
>>> but dropped them when the ACPI tree moved out from under us.
>>>
>>> Can resurrect it if Len feels OK about the concept. Len, you shouldnt
>>> worry about conflicts - we can do it after the ACPI changes of this
>>> merge window are upstream so there should be no conflict trouble at
>>> all. How does that sound?
>>>   
>>>       
>> Doesn't look like these changes made it in this time.  Did they get
>> overlooked, or did some other problem come up?  Or did you want me to
>> dig them up?
>>
>> Thanks,
>>    J
>>     
>
>
> please check attached that are updated to today tip/master with ingo's genapic patchset..
>   

The look OK, but they didn't get merged into tip/master?

    J
