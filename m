From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [RFC] EC registers - Adding sysfs interface?
Date: Wed, 28 Nov 2007 21:25:06 +0300
Message-ID: <474DB282.4050003@gmail.com>
References: <200711131724.31868.carlos@strangeworlds.co.uk>	 <200711131849.56964.carlos@strangeworlds.co.uk> <4739F2FB.9080800@suse.de>	 <200711131903.03018.carlos@strangeworlds.co.uk> <1196267304.23251.165.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:44140 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbXK1SYu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Nov 2007 13:24:50 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1583741ugc
        for <linux-acpi@vger.kernel.org>; Wed, 28 Nov 2007 10:24:44 -0800 (PST)
In-Reply-To: <1196267304.23251.165.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <lenb@kernel.org>

Thomas Renninger wrote:
> On Tue, 2007-11-13 at 19:03 +0000, Carlos Corbacho wrote:
>   
>> Alexey,
>>
>>     
>>> How about character /dev/ec0?
>>>       
>> Yes, that would be fine.
>>
>> On Tuesday 13 November 2007 18:54:51 Alexey Starikovskiy wrote:
>>     
>>> What is the benefit of having acer_acpi in userspace, rather than one more
>>> *-laptop in /devices/misc?
>>>       
>> A debate of "would it be easier for me to maintain an in kernel driver (if/ 
>> when I can get it upstream) or a userspace application". At the moment, the 
>> idea of a full blown userspace application is just something I'm toying with 
>> in my head whilst working on WMI userspace.
>>     
>
> I very much like the idea of a general EC debug/devel interface to
> userspace.
> It should be a separate CONFIG, marked "DEBUG", "EXPERIMENTAL" or
> whatever and be per default off.
> It is stupid that everybody who wants to debug a bit on EC registers
> needs to duplicate the IBM EC implementation, this should IMO be moved
> where it belongs to:
> drivers/acpi/ec.c
>
> The question is whether Len will accept/like it, Len?
>
>   
Having it as /dev/ec0 should not introduce too many problems...
Also, it has much smaller impact than /dev/mem or /dev/ioport...

Regards,
Alex.


