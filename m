From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 15:59:26 +0000
Message-ID: <4B00255E.1070802@tuffmail.co.uk>
References: <cone.1258203372.445001.1633.1000@eeekiste> <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com> <cone.1258211472.464906.1633.1000@eeekiste> <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com> <cone.1258285991.924736.2588.1000@eeekiste> <20091115155655.GB1019@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:33925 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753133AbZKOP7X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2009 10:59:23 -0500
Received: by ey-out-2122.google.com with SMTP id 9so1648479eyd.19
        for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2009 07:59:27 -0800 (PST)
In-Reply-To: <20091115155655.GB1019@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: andrej.gelenberg@udo.edu, Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net

Matthew Garrett wrote:
> On Sun, Nov 15, 2009 at 12:53:11PM +0100, andrej.gelenberg@udo.edu wrote:
>
>   
>> Is it not better to use rfkill-switch provided from wlan-driver when? At  
>> least Atheros drivers support rfkill propertly. You can make it LED for 
>> that eeepcs and set the default trigger to rfkill. I have tried to make 
>> it so, but on 1005ha it is a proper rfkill.
>>     
>
> No. The platform is designed (for whatever reason) such that rfkill 
> turns the device off and disassociates it from the PCI bus. Support for 
> that is necessary.
>
>   
>> I have tried to make the devicesearch for hotplug propertly, but it cause
>> the system freeze. (http://bugzilla.kernel.org/show_bug.cgi?id=14570#c1)
>>     
>
> rt2860 is buggy.
>   

More specifically, the eeepc-laptop workaround for rt2860 was buggy and 
broke all models with non-rt2860 wireless.

Regards
Alan
