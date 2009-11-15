From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 17:43:54 +0000
Message-ID: <4B003DDA.5020508@tuffmail.co.uk>
References: <cone.1258203372.445001.1633.1000@eeekiste> <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com> <cone.1258211472.464906.1633.1000@eeekiste> <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com> <cone.1258285991.924736.2588.1000@eeekiste> <4AFFF61E.6090707@tuffmail.co.uk> <cone.1258301205.852230.1663.1000@eeekiste> <4B002951.4080704@tuffmail.co.uk> <cone.1258304218.643429.1671.1000@eeekiste> <4B00354A.7000300@tuffmail.co.uk> <71cd59b00911150917k7d677fd0g509ab4edc1786fb1@mail.gmail.com> <cone.1258306366.446137.1656.1000@eeekiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:54395 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548AbZKORnw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2009 12:43:52 -0500
Received: by bwz27 with SMTP id 27so4948008bwz.21
        for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2009 09:43:56 -0800 (PST)
In-Reply-To: <cone.1258306366.446137.1656.1000@eeekiste>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andrej.gelenberg@udo.edu
Cc: Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>

andrej.gelenberg@udo.edu wrote:
> Hi,
>
> Corentin Chary writes:
>
>> Could you try to boot with acpi_osi="Linux" ?
>> This might be fixed by
>> http://git.iksaif.net/?p=acpi4asus.git;a=commitdiff;h=a57818b9177b521d418e25bf549a609d0e79cd4a;hp=cbf69cbf597b31201038ecd7630c90183543c488 
>>
>
> this patch solved the problem.
>
> Regards,
> Andrej

Ok.  Be aware that there may be more turmoil in future.  The preferred 
solution for linux ACPI is to do whatever the More Popular OS does.  See 
the recent rejection of a similar patch by thinkpad-acpi developers.

There may be a shiny new ACPI interface we need to write a driver for.  
Looking on the bright side, a new driver can easily use different pci 
hotplug code (or perhaps no hotplug code).

Regards
Alan
