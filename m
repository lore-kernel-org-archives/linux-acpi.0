From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 12:44:40 +0000
Message-ID: <4AFFF7B8.2070508@tuffmail.co.uk>
References: <cone.1258203372.445001.1633.1000@eeekiste> <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com> <cone.1258211472.464906.1633.1000@eeekiste> <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com> <cone.1258285991.924736.2588.1000@eeekiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:14870 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607AbZKOMoj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2009 07:44:39 -0500
Received: by ey-out-2122.google.com with SMTP id 9so1602197eyd.19
        for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2009 04:44:44 -0800 (PST)
In-Reply-To: <cone.1258285991.924736.2588.1000@eeekiste>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andrej.gelenberg@udo.edu
Cc: Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>, acpi4asus-user@lists.sourceforge.net, Matthew Garrett <mjg@redhat.com>

andrej.gelenberg@udo.edu wrote:
> Hi,
>
> Corentin Chary writes:
>
>> Matthew, you added hotplug in commit  
>> 5740294ca3a9b113fe146f2826effb69ca50008d,
>> it was needed for 701/900/901. Do you know if it's still needed for 
>> 1005ha ?
>
> Is it not better to use rfkill-switch provided from wlan-driver when? 
> At least Atheros drivers support rfkill propertly. You can make it LED 
> for that eeepcs and set the default trigger to rfkill. I have tried to 
> make it so, but on 1005ha it is a proper rfkill.
>
> I have tried to make the devicesearch for hotplug propertly, but it cause
> the system freeze. (http://bugzilla.kernel.org/show_bug.cgi?id=14570#c1)

At least on the original systems, the eeepc-laptop driver has no way to 
control the wireless LED directly.  The wireless LED is set by the WLDS 
acpi method (when the wireless is enabled/disabled).

The pci hotplug in the eeepc-laptop driver doesn't actually save any 
power.  The WLDS acpi method is what actually "unplugs" the PCI slot.  
What eeepc-laptop does is notify the kernel after the fact, so that the 
wireless driver doesn't try to talk to hardware that isn't there.  
Without this notification, the wireless driver isn't able to recover 
when the wireless is toggled off and back on again.

Unfortunately, the BIOS doesn't tell us in advance which device it is 
going to unplug.  Hence the hardcoded bus/slot.

We may be able to filter the notifications.  The _ADR field on the P0P* 
devices tells us which PCI bridge device it corresponds to.  So we can 
hopefully avoid toggling the wrong device and disabling the LAN on 1005ha.

But I don't know how to find the _right_ device in a generic way (or 
detect that hotplug is not needed and so we should not toggle any device).

Alan
