From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: RE: ACPI info please
Date: Tue, 11 Jul 2006 14:26:38 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1CE1B60@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:64892 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030182AbWGKGbH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jul 2006 02:31:07 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?gb2312?B?UnVzbKiibiBMZWRlc21hIEdhcnph?= <ruslanledesmag@hotmail.com>, acpi-bugzilla@lists.sourceforge.net, acpi@linux.intel.com, linux-acpi@vger.kernel.org

Please file a bug on bugzilla.kernel.org, don't forget attach acpidump =
output, dmesg.

Thanks,
Luming

-----Original Message-----
=46rom: acpi-bounces@linux.intel.com [mailto:acpi-bounces@linux.intel.c=
om] On Behalf Of Rusl=A8=A2n Ledesma Garza
Sent: 2006=C4=EA7=D4=C211=C8=D5 11:09
To: acpi-bugzilla@lists.sourceforge.net; acpi@linux.intel.com; linux-ac=
pi@vger.kernel.org
Subject: [ACPI] RE: ACPI info please

So what is wrong with ACPI if "acpi_listen" is not reporting any events=
 but=20
"ac_adapter" event while the state of the various buttons and all other=
=20
devices is reported in /proc/acpi/* ?

Do I have an unssuported DSDT?

and once more "What can I do?"

           Rusl=A8=A2n


>From: "Brown, Len" <len.brown@intel.com>
>To: Rusl=A8=A2n Ledesma Garza <ruslanledesmag@hotmail.com>
>Subject: RE: ACPI info please
>Date: Sun, 9 Jul 2006 23:31:32 -0400
>
>I barely have the bandwidth to answer direct email from Linus Torvalds=
 and=20
>Andrew Morton.
>I'm sorry, I see 8 e-mails from you in the last 2 days -- which are=20
>Saturday and Sunday on this part of the Earth.
>
>you must communicate with me on the list b/c I'm not the only
>one who can answer questions.
>
>thanks,
>-Len
>
> >-----Original Message-----
> >From: Rusl=A8=A2n Ledesma Garza [mailto:ruslanledesmag@hotmail.com]
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
> >Rusl=A8=A2n
> >
> >
> >> >Hi. I'm a newbie to linux, but I've been getting this problem eve=
r
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
> >When doing "lsmod", response is "video                  16260  0", s=
o I
> >think answer is yes.
> >>
> >> >2) Then I realized no events are reported through
> >acpi_listen, except
> >> >for "ac_adapter" event which occurs after resuming the laptop fro=
m
> >> >hibernation.
> >>
> >>How about power button events?
> >No other events rather than ac_adapter are reported, including butto=
n
> >events.
> >>
> >> >3) I've also found that sometimes the computer freezes when resum=
ing
> >> >from hibernation (I can only confirm this under Ubuntu, I can't
> >> >remember what happens with Fedora).
> >> >
> >> >4) Finally, for some reason gnome power manager doesn't put into
> >> >hibernation my computer when battery is too low (the only time I
> >> >tested this was under Ubuntu) and simply runs out of battery.
> >> >
> >> >Since #'s 1 & 2 have ocurred under Fedora and Ubuntu, I assume th=
ere
> >> >is some low level problem/incompatibility of ACPI with my compute=
r's
> >> >hardware. Everything works fine under WinXP, and to me power
> >> >management is a must for my laptop.
> >> >
> >> >I've read some stuff about DST's, but sincerelly I didn't undesta=
nd
> >> >much (ie. where does this DST reside? Is it a firmware?),
> >>
> >>modified DSDT's are a debugging tool only -- not a path to a
> >"real fix".
> >>Linux should work properly on your laptop without any modifications
> >>to the firmware.  (though it might be a good idea to check with Del=
l
> >>to make sure you're running the latest).
> >Last time I checked (about 3 weeks ago) the bios firmware was
> >the latest
> >("A07"). By the way, are DSDT's firmwares then?
> >>
> >> >but I wonder
> >> >if the fact that my DST says "MSFT" could be the cause of ACPI no=
t
> >> >working propertly.
> >>
> >>:-)  This means it was built with the MSFT ASL compiler.  Sometimes
> >>that is an issue, but we try to handle those issues and re-building
> >>the firmwarwe with Intel's compiler is okay for debugging, but not
> >>supportable.
> >>
> >>build with  CONFIG_ACPI_DEBUG=3Dy and see if any new dmesg come out=
=2E
> >>You can also boot with "acpi=3Dstrict" if you want to see if
> >>Linux is already working around issues in your DSDT.
> >I've already tried to build my DSDT using Intel's compiler. It showe=
d
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
Platica con tus amigos en linea con MSN Messenger=20
http://messenger.t1msn.com.mx/
_______________________________________________
acpi mailing list
acpi@linux.intel.com
http://linux.intel.com/mailman/listinfo/acpi
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
