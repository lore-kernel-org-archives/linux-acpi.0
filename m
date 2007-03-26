From: Szymon Olko <szymonolko@o2.pl>
Subject: Re: Notify(0x88) (was Re: Asus V1j)
Date: Mon, 26 Mar 2007 22:26:08 +0300
Message-ID: <46081E50.6040506@o2.pl>
References: <46051CEE.4030402@o2.pl> <200703241415.04656.corentincj@iksaif.net> <200703260032.46355.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000508040508010205080800"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tur.go2.pl ([193.17.41.50]:45325 "EHLO tur.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932313AbXCZT1O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Mar 2007 15:27:14 -0400
Received: from poczta.o2.pl (mx10.go2.pl [193.17.41.74])
	by tur.go2.pl (o2.pl Mailer 2.0.1) with ESMTP id 53B4A230397
	for <linux-acpi@vger.kernel.org>; Mon, 26 Mar 2007 21:27:12 +0200 (CEST)
In-Reply-To: <200703260032.46355.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: corentincj@iksaif.net
Cc: lenb@kernel.org, acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------000508040508010205080800
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

4. Multimedia button, the first on the left side from top buttons. On
> windows it runs full screen application to what movies, presentation and
> listen music. I made a change like with brightness buttons:
>
>             Method (_Q51, 0, NotSerialized)
> //multimedia (top)
>             {
> /*
>                 \_SB.PCI0.SBRG.EC0.WRAM (0x04, 0xCB, 0x09)
>                 Store (One, Local0)
>                 While (Local0)
>                 {
>                     If (\_SB.ATKP)
>                     {
>                         SPIN (0x23, 0x00)
>                         Sleep (0x32)
>                         SPIN (0x23, 0x01)
>                     }
>
>                     Store (Zero, Local2)
>                     If (\_SB.PCI0.SBRG.EC0.RPIN (0x43))
>                     {
>                         Or (Local2, 0x04, Local2)
>                     }
>
>                     If (\_SB.PCI0.SBRG.EC0.RPIN (0x43))
>                     {
>                         Or (Local2, 0x02, Local2)
>                     }
>
>                     If (\_SB.PCI0.SBRG.EC0.RPIN (0x43))
>                     {
>                         Or (Local2, 0x01, Local2)
>                     }
>
>                     If (LEqual (Local2, 0x07))
>                     {
>                         \_SB.PCI0.SBRG.EC0.WRAM (0x04, 0xCB, 0x89)
>                         Notify (\_SB.ATKD, 0x95)
>                         Store (Zero, Local0)
>                     }
>                 }
> */
>                     If (\_SB.ATKP)
>                     {
>                         Notify (\_SB.ATKD, 0x68)
>                     }
>             }
> But it notify to the /proc/acpi/event for the first time it is pressed.
> Next time I press it, it does do nothing. Again I need more time to look
> what this method should do but looking on the code it is strange that
> \_SB.PCI0.SBRG.EC0.RPIN (0x43) is checked few times. This is still
> pending to be solved. Maybe I commended to much, and there is no state
> wrote to memory, and that is why it is not called again.

I uncommented fully this method. I only changed code 0x95 to 0x68 and now it works very well. I noticed that when method was commented pressing method worked once time only. After soft reboot BIOS test screen was very ugly, colors ware not the one that should be, and letters look like on broken screen. Now everything is ok. This lead to problem with codes bigger than 0x80.

>
> 5. The last big mystery are media control buttons (play, stop, rewind,
> forward). I cannot find the in DSDT. I found something that I think
> should be connected to those keys.
>             Method (_Q6E, 0, NotSerialized)            //unknown 1
>             {
>                 If (\_SB.ATKP)
>                 {
> //                    Notify (\_SB.ATKD, 0x8A)
>                     Notify (\_SB.ATKD, 0x65)
>                 }
>             }
> ////////////////////////////////////
>             Method (_Q6F, 0, NotSerialized)            //unknown 3
>             {
>                 If (\_SB.ATKP)
>                 {
> //                    Notify (\_SB.ATKD, 0x99)
>                     Notify (\_SB.ATKD, 0x67)
>                 }
>             }
> But those are two keys not four. And my values are not reported in
> /proc/acpi/events.

Does they work on the other OS ?

Those buttons works with Microsoft Media Player as described on keys. I had to install nothing for them to work.
How to find those buttons? Please help me with that. I'm attaching my dsdt. 

>>> 1. In /proc/acpi/events few keys which looks normal in DSDT are not
>>> reported. I found that all of them have code bigger than 0x80. I founded
>>> those lines and changed them to return codes below 0x80 (to ones that
>>> are not used) and that solved problem. I did not have time to look into
>>> acpi source code and maybe my solution is not the best way to do it, and
>>> maybe not solves the problem, but works for me.
>>> Example:
>>>
>>>     - F2 wifi button
>>>     //Notify (\_SB.ATKD, 0x88)
>>>     Notify (\_SB.ATKD, 0x56)
>>>
>>> The only exception is sleep button F1 but it is notified not to
>>> \_SB.ATKD but to \_SB.SLPB and is processed by buttons module.
>>>
>>> Notify (\_SB.SLPB, 0x80)
>>>
>>> Is it a bug or a feature that codes over 0x80 are not reported?
>>>       
>> I don't know :/ So, let's ask linux-acpi@vger.kernel.org
>>     
>
> According to the ACPI spec, section 5.6.3 "Device Object Notifications"
> 0-7f common for all devices
> 80-bf device specific
> c0-ff vendor specific
>
> so I think that what happens to codes of 80 and above should
> depend on the device driver that is bound to the device
> that handles the notify.
>
> I'll venture that SLPB is the sleep button, and the standard button driver
> is already bound to handle that one.
>
>   
Thanks for pointing that Len.
How this can be made in asus_laptop driver? I do not know acpi 
interfaces, but i assume it should be done during handler installation. 
Am I wright?


--------------000508040508010205080800
Content-Type: application/gzip;
 name="asus_v1j.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="asus_v1j.gz"

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
--------------000508040508010205080800--
