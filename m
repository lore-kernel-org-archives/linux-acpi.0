From: andrej.gelenberg@udo.edu
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 19:05:52 +0100
Message-ID: <cone.1258308352.527811.1656.1000@eeekiste>
References: <cone.1258203372.445001.1633.1000@eeekiste> <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com> <cone.1258211472.464906.1633.1000@eeekiste> <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com> <cone.1258285991.924736.2588.1000@eeekiste> <4AFFF61E.6090707@tuffmail.co.uk> <cone.1258301205.852230.1663.1000@eeekiste> <4B002951.4080704@tuffmail.co.uk> <cone.1258304218.643429.1671.1000@eeekiste> <4B00354A.7000300@tuffmail.co.uk> <71cd59b00911150917k7d677fd0g509ab4edc1786fb1@mail.gmail.com> <cone.1258306366.446137.1656.1000@eeekiste> <4B003DDA.5020508@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.HRZ.Uni-Dortmund.DE ([129.217.128.51]:35363 "EHLO
	postserver.uni-dortmund.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753340AbZKOSFt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 15 Nov 2009 13:05:49 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>

Alan Jenkins writes:

> andrej.gelenberg@udo.edu wrote:
>> Hi,
>>
>> Corentin Chary writes:
>>
>>> Could you try to boot with acpi_osi="Linux" ?
>>> This might be fixed by
>>> http://git.iksaif.net/?p=acpi4asus.git;a=commitdiff;h=a57818b9177b521d418e25bf549a609d0e79cd4a;hp=cbf69cbf597b31201038ecd7630c90183543c488 
>>>
>>
>> this patch solved the problem.
>>
>> Regards,
>> Andrej
> 
> Ok.  Be aware that there may be more turmoil in future.  The preferred 
> solution for linux ACPI is to do whatever the More Popular OS does.  See 
> the recent rejection of a similar patch by thinkpad-acpi developers.
> 
> There may be a shiny new ACPI interface we need to write a driver for.  
> Looking on the bright side, a new driver can easily use different pci 
> hotplug code (or perhaps no hotplug code).
> 
> Regards
> Alan

it has not solved the Problem, that my ethernet-device are unplugt on rfkill-off.
It solved only the problem with no founded ASUS010.

Regards,
Andrej
