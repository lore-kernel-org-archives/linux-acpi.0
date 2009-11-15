From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 12:37:50 +0000
Message-ID: <4AFFF61E.6090707@tuffmail.co.uk>
References: <cone.1258203372.445001.1633.1000@eeekiste> <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com> <cone.1258211472.464906.1633.1000@eeekiste> <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com> <cone.1258285991.924736.2588.1000@eeekiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:47653 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbZKOMhs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2009 07:37:48 -0500
Received: by ey-out-2122.google.com with SMTP id 9so1600623eyd.19
        for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2009 04:37:53 -0800 (PST)
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
>
> Regards,
> Andrej Gelenberg

That freeze shows eeepc_rfkill_set() calling eeepc_rfkill_hotplug().  
That's a bug which was introduced in 2.6.32-rc5 (I think), but it is 
definitely fixed in 2.6.32-rc7.  This freeze was happening on all systems.

So your modified device search _should_ work, on either 2.6.31 or 
2.6.32-rc7.  AFAICS the problem is making the same driver work on both 
1005ha and all the previous models.

Alan
