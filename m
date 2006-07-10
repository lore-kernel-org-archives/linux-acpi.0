From: =?iso-8859-1?B?UnVzbOFuIExlZGVzbWEgR2FyemE=?=
	<ruslanledesmag@hotmail.com>
Subject: Re: Please help: ACPI not working on DELL Inspiron 1150
Date: Mon, 10 Jul 2006 17:40:49 -0500
Message-ID: <BAY116-F990288CF0C74028ADFE5FC86B0@phx.gbl>
References: <44B2B57F.1010000@tzi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bay0-omc1-s26.bay0.hotmail.com ([65.54.246.98]:49827 "EHLO
	bay0-omc1-s26.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S964989AbWGJWky (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Jul 2006 18:40:54 -0400
In-Reply-To: <44B2B57F.1010000@tzi.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: scotch@tzi.de, linux-acpi@vger.kernel.org


There is no mailloop. I thought the mail hadn't reached the mailing list 
because no one had answered me anything.

I thought I could get some little help but it seems as if I'm not in the 
right place or no one seems interested in making ACPI work on some Dell 
laptops. From what I've researched, I've discovered this is not an isolated 
malfunction.

What I ask is some feedback. What should I do first in order to get this 
thing fixed?

Besides I've been asking a few questions which I feel have not been answered 
very well.
-Is the DSDT a firmware?
-If it is so where does it reside?
-I found a tutorial on how to "fix" the DSDT. They talked about loading the 
DSDT on startup through an image file. What does this mean?

If you think these questions should not be asked here or that their answers 
represent a waste of time, please please let me know.

My only aim is to make this work and help my fellow users of linux on a Dell 
laptop have a better linux experience.

Greetins
      Ruslán

>From: Janosch Machowinski <scotch@tzi.de>
>To: Ruslán Ledesma Garza <ruslanledesmag@hotmail.com>
>CC: linux-acpi@vger.kernel.org
>Subject: Re: Please help: ACPI not working on DELL Inspiron 1150
>Date: Mon, 10 Jul 2006 22:15:59 +0200
>
>Is here a sort of mailloop or why is
>this mail hitting the list about 5 times ?
>Greetings
>      Janosch
>Ruslán Ledesma Garza schrieb:
>>Can anyone give me a hint on how to fix this? Anything would be useful. Am 
>>I in the right place for reporting ACPI bugs?
>>
>>> >Hi. I'm a newbie to linux, but I've been getting this problem ever
>>> >since I installed it on my computer (I've already tested Fedora Core 5
>>> >and Ubuntu 6, both having the same problem).
>>> >
>>> >1) I first discovered that my laptop display didn't turn off when the
>>> >lid was closed (I can tell because I can see the glare of the display
>>> >through a gap). So I started investigating and found that the lid
>>> >event is not triggered whenever I close/open the lid (using
>>> >acpi_listen). But the weirdest part is that the event is reported when
>>> >doing "cat /proc/acpi/button/lid/LID/state".
>>>
>>>is the video driver loaded (drivers/acpi/video.c)
>>
>>When doing "lsmod", response is "video                  16260  0", so I
>>think answer is yes.
>>
>>>
>>> >2) Then I realized no events are reported through acpi_listen, except
>>> >for "ac_adapter" event which occurs after resuming the laptop from
>>> >hibernation.
>>>
>>>How about power button events?
>>
>>No other events rather than ac_adapter are reported, including button
>>events.
>>
>>>
>>> >3) I've also found that sometimes the computer freezes when resuming
>>> >from hibernation (I can only confirm this under Ubuntu, I can't
>>> >remember what happens with Fedora).
>>> >
>>> >4) Finally, for some reason gnome power manager doesn't put into
>>> >hibernation my computer when battery is too low (the only time I
>>> >tested this was under Ubuntu) and simply runs out of battery.
>>> >
>>> >Since #'s 1 & 2 have ocurred under Fedora and Ubuntu, I assume there
>>> >is some low level problem/incompatibility of ACPI with my computer's
>>> >hardware. Everything works fine under WinXP, and to me power
>>> >management is a must for my laptop.
>>> >
>>> >I've read some stuff about DST's, but sincerelly I didn't undestand
>>> >much (ie. where does this DST reside? Is it a firmware?),
>>>
>>>modified DSDT's are a debugging tool only -- not a path to a "real fix".
>>>Linux should work properly on your laptop without any modifications
>>>to the firmware.  (though it might be a good idea to check with Dell
>>>to make sure you're running the latest).
>>
>>Last time I checked (about 3 weeks ago) the bios firmware was the latest
>>("A07"). By the way, are DSDT's firmwares then?
>>
>>>
>>> >but I wonder
>>> >if the fact that my DST says "MSFT" could be the cause of ACPI not
>>> >working propertly.
>>>
>>>:-)  This means it was built with the MSFT ASL compiler.  Sometimes
>>>that is an issue, but we try to handle those issues and re-building
>>>the firmwarwe with Intel's compiler is okay for debugging, but not
>>>supportable.
>>>
>>>build with  CONFIG_ACPI_DEBUG=y and see if any new dmesg come out.
>>>You can also boot with "acpi=strict" if you want to see if
>>>Linux is already working around issues in your DSDT.
>>
>>I've already tried to build my DSDT using Intel's compiler. It showed
>>several errors (can't remember which ones, but I can do it again if this 
>>can
>>help). I think I fixed them, but could never get to install the modified
>>DSDT.
>>
>>What can I do?
>>
>>>
>>>-Len

_________________________________________________________________
Prodigy/MSN Spaces: Tu espacio en la red http://spaces.msn.com/

