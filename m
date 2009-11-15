From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 16:11:40 +0000
Message-ID: <4B00283C.3040807@tuffmail.co.uk>
References: <cone.1258203372.445001.1633.1000@eeekiste> <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com> <cone.1258211472.464906.1633.1000@eeekiste> <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com> <cone.1258285991.924736.2588.1000@eeekiste> <4AFFF7B8.2070508@tuffmail.co.uk> <20091115160201.GC1019@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:59028 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbZKOQLi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2009 11:11:38 -0500
Received: by ey-out-2122.google.com with SMTP id 9so1651662eyd.19
        for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2009 08:11:43 -0800 (PST)
In-Reply-To: <20091115160201.GC1019@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: andrej.gelenberg@udo.edu, Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net

Matthew Garrett wrote:
> On Sun, Nov 15, 2009 at 12:44:40PM +0000, Alan Jenkins wrote:
>
>   
>> Unfortunately, the BIOS doesn't tell us in advance which device it is  
>> going to unplug.  Hence the hardcoded bus/slot.
>>     
>
> Mm. Thinking about it, it does - it's sending a bus check notification, 
> which means we're supposed to look at children of the device it 
> notifies. Shouldn't be a difficult fix.
>   

We don't really look at the device though.  What we look at is the value 
of WLDG.

Stray notifications on either of the _other_ 2 pcie ports would then 
cause us to toggle them based on WLDG.

I see a _Lxx handler in my DSDT which looks like it notifies on _all_ 
the pcie ports.  So I think it's a bit tricky.

Alan
