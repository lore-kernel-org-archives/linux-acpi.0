From: =?iso-8859-1?B?UnVzbOFuIExlZGVzbWEgR2FyemE=?=
	<ruslanledesmag@hotmail.com>
Subject: RE: ACPI info please
Date: Mon, 10 Jul 2006 22:09:20 -0500
Message-ID: <BAY116-F142B30BD83880F6A5834CAC8680@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bay0-omc2-s14.bay0.hotmail.com ([65.54.246.150]:43120 "EHLO
	bay0-omc2-s14.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S965046AbWGKDJV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Jul 2006 23:09:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: acpi-bugzilla@lists.sourceforge.net, acpi@linux.intel.com, linux-acpi@vger.kernel.org

So what is wrong with ACPI if "acpi_listen" is not reporting any events but 
"ac_adapter" event while the state of the various buttons and all other 
devices is reported in /proc/acpi/* ?

Do I have an unssuported DSDT?

and once more "What can I do?"

           Ruslán


>From: "Brown, Len" <len.brown@intel.com>
>To: Ruslán Ledesma Garza <ruslanledesmag@hotmail.com>
>Subject: RE: ACPI info please
>Date: Sun, 9 Jul 2006 23:31:32 -0400
>
>I barely have the bandwidth to answer direct email from Linus Torvalds and 
>Andrew Morton.
>I'm sorry, I see 8 e-mails from you in the last 2 days -- which are 
>Saturday and Sunday on this part of the Earth.
>
>you must communicate with me on the list b/c I'm not the only
>one who can answer questions.
>
>thanks,
>-Len
>
> >-----Original Message-----
> >From: Ruslán Ledesma Garza [mailto:ruslanledesmag@hotmail.com]
> >Sent: Sunday, July 09, 2006 11:06 PM
> >To: Brown, Len
> >Subject: ACPI info please
> >
> >Hi:
> >
> >I don't know if you've got my other emails, but I seem to get
> >no response
> >from anyone. I really would like to fix this ACPI problem,
> >could you tell me
> >where can I start or what can I do? There is no problem for me
> >to start
> >working with any source code, I just ask for some enlightment
> >since I'm just
> >getting started in the linux world.
> >
> >Ruslán
> >
> >
> >> >Hi. I'm a newbie to linux, but I've been getting this problem ever
> >> >since I installed it on my computer (I've already tested
> >Fedora Core 5
> >> >and Ubuntu 6, both having the same problem).
> >> >
> >> >1) I first discovered that my laptop display didn't turn
> >off when the
> >> >lid was closed (I can tell because I can see the glare of
> >the display
> >> >through a gap). So I started investigating and found that the lid
> >> >event is not triggered whenever I close/open the lid (using
> >> >acpi_listen). But the weirdest part is that the event is
> >reported when
> >> >doing "cat /proc/acpi/button/lid/LID/state".
> >>
> >>is the video driver loaded (drivers/acpi/video.c)
> >When doing "lsmod", response is "video                  16260  0", so I
> >think answer is yes.
> >>
> >> >2) Then I realized no events are reported through
> >acpi_listen, except
> >> >for "ac_adapter" event which occurs after resuming the laptop from
> >> >hibernation.
> >>
> >>How about power button events?
> >No other events rather than ac_adapter are reported, including button
> >events.
> >>
> >> >3) I've also found that sometimes the computer freezes when resuming
> >> >from hibernation (I can only confirm this under Ubuntu, I can't
> >> >remember what happens with Fedora).
> >> >
> >> >4) Finally, for some reason gnome power manager doesn't put into
> >> >hibernation my computer when battery is too low (the only time I
> >> >tested this was under Ubuntu) and simply runs out of battery.
> >> >
> >> >Since #'s 1 & 2 have ocurred under Fedora and Ubuntu, I assume there
> >> >is some low level problem/incompatibility of ACPI with my computer's
> >> >hardware. Everything works fine under WinXP, and to me power
> >> >management is a must for my laptop.
> >> >
> >> >I've read some stuff about DST's, but sincerelly I didn't undestand
> >> >much (ie. where does this DST reside? Is it a firmware?),
> >>
> >>modified DSDT's are a debugging tool only -- not a path to a
> >"real fix".
> >>Linux should work properly on your laptop without any modifications
> >>to the firmware.  (though it might be a good idea to check with Dell
> >>to make sure you're running the latest).
> >Last time I checked (about 3 weeks ago) the bios firmware was
> >the latest
> >("A07"). By the way, are DSDT's firmwares then?
> >>
> >> >but I wonder
> >> >if the fact that my DST says "MSFT" could be the cause of ACPI not
> >> >working propertly.
> >>
> >>:-)  This means it was built with the MSFT ASL compiler.  Sometimes
> >>that is an issue, but we try to handle those issues and re-building
> >>the firmwarwe with Intel's compiler is okay for debugging, but not
> >>supportable.
> >>
> >>build with  CONFIG_ACPI_DEBUG=y and see if any new dmesg come out.
> >>You can also boot with "acpi=strict" if you want to see if
> >>Linux is already working around issues in your DSDT.
> >I've already tried to build my DSDT using Intel's compiler. It showed
> >several errors (can't remember which ones, but I can do it
> >again if this can
> >help). I think I fixed them, but could never get to install
> >the modified
> >DSDT.
> >
> >What can I do?
> >>
> >>-Len
> >
> >_________________________________________________________________
> >Prodigy/MSN Spaces: Tu espacio en la red http://spaces.msn.com/
> >

_________________________________________________________________
Platica con tus amigos en linea con MSN Messenger 
http://messenger.t1msn.com.mx/

