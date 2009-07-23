From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH] hp-wmi: improve rfkill support
Date: Thu, 23 Jul 2009 19:27:27 +0100
Message-ID: <4A68AB8F.9020609@tuffmail.co.uk>
References: <4A65A2F9.1060509@tuffmail.co.uk> <8db1092f0907230831w1255d0bey951342fb61b67c1e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f226.google.com ([209.85.219.226]:58995 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbZGWS1b (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jul 2009 14:27:31 -0400
In-Reply-To: <8db1092f0907230831w1255d0bey951342fb61b67c1e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maciej Rutecki <maciej.rutecki@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Maciej Rutecki wrote:
> 2009/7/21 Alan Jenkins <alan-jenkins@tuffmail.co.uk>:
>   
>> 1) Add support for reading the hardware blocked state.  Previously
>>   we read a combination of the hardware and software blocked states,
>>   reporting it as the software blocked state.  This caused some
>>   confusing behaviour.
>>
>> 2) The software state is persistent, mark it as such.
>>
>> 3) Check rfkill in the resume handler.  Both the hard and soft
>>   blocked states may change over hibernation.
>>
>> Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
>> Tested-by: Maciej Rutecki <maciej.rutecki@gmail.com>
>>     
>
> It's this patch is added to -rc4?

No. 
<http://git.kernel.org/?p=linux%2Fkernel%2Fgit%2Ftorvalds%2Flinux-2.6.git&a=search&h=HEAD&st=commit&s=hp-wmi>

I didn't submit it for 2.6.31 because I didn't think it fixed a regression.

>  I one case I have strange behaviour.
>
> Before disable by button:
> root@gumis:/home/maciek/Desktop# rfkill list
> 2: hp-wifi: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 3: hp-bluetooth: Bluetooth
>         Soft blocked: no
>         Hard blocked: no
> 16: hci0: Bluetooth
>         Soft blocked: no
>         Hard blocked: no
> 17: phy7: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 	
> Disable by button:
> root@gumis:/home/maciek/Desktop# rfkill list
> 2: hp-wifi: Wireless LAN
>         Soft blocked: yes
>         Hard blocked: no
> 3: hp-bluetooth: Bluetooth
>         Soft blocked: yes
>         Hard blocked: no
> 17: phy7: Wireless LAN
>         Soft blocked: no
>         Hard blocked: yes
> 	
> I do s2disk. After resume from suspend to disk (still disabled by button):
> root@gumis:/home/maciek/Desktop# rfkill list
> 2: hp-wifi: Wireless LAN
>         Soft blocked: yes
>         Hard blocked: no
> 3: hp-bluetooth: Bluetooth
>         Soft blocked: yes
>         Hard blocked: no
> 18: phy8: Wireless LAN
>         Soft blocked: no
>         Hard blocked: yes
> 	
> Try enable by button:
> root@gumis:/home/maciek/Desktop# rfkill list
> 2: hp-wifi: Wireless LAN
>         Soft blocked: yes
>         Hard blocked: no
> 3: hp-bluetooth: Bluetooth
>         Soft blocked: yes
>         Hard blocked: no
> 18: phy8: Wireless LAN
>         Soft blocked: no
>         Hard blocked: yes
> 	
> Nothing change (LED, wireless and bluetooth don't work). To enable it
> I use this script rfkill.sh (I must use rfkill program):
>
> #!/bin/sh
> PROGRAM=/usr/local/sbin/rfkill
> WIFI=`$PROGRAM list | grep -E 'Wireless|Bluetooth' | cut -d  ':' -f 1`
>
> for DEVICE in $WIFI; do
>   echo $DEVICE
>   $PROGRAM unblock $DEVICE
> done
>
> Then works OK:
> root@gumis:/home/maciek/Desktop# ./rfkill.sh
> 2
> 3
> 18
> root@gumis:/home/maciek/Desktop# rfkill list
> 2: hp-wifi: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 3: hp-bluetooth: Bluetooth
>         Soft blocked: no
>         Hard blocked: no
> 18: phy8: Wireless LAN
>         Soft blocked: no
>         Hard blocked: no
> 19: hci0: Bluetooth
>         Soft blocked: no
>         Hard blocked: no
> 	
> It's normal behaviour?
>   

That's a bug.  You're saying this is in -rc4, without applying my patch?

I think I know exactly what is happening.  Apply my patch, and it will 
go away :-).

I'm not sure this is a new bug though.  It might be triggered by the big 
rfkill rewrite, but I don't see how that could happen.  Can you confirm 
if this happens in 2.6.30?

Thanks
Alan
