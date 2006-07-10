From: Janosch Machowinski <scotch@tzi.de>
Subject: Re: Please help: ACPI not working on DELL Inspiron 1150
Date: Mon, 10 Jul 2006 22:15:59 +0200
Message-ID: <44B2B57F.1010000@tzi.de>
References: <BAY116-F10785AD3ACEE08D58D136AC86B0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-bremen.de ([134.102.201.18]:41699 "EHLO
	informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id S1422800AbWGJUNt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Jul 2006 16:13:49 -0400
In-Reply-To: <BAY116-F10785AD3ACEE08D58D136AC86B0@phx.gbl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Rusl=E1n_Ledesma_Garza?= <ruslanledesmag@hotmail.com>
Cc: linux-acpi@vger.kernel.org

Is here a sort of mailloop or why is
this mail hitting the list about 5 times ?
Greetings
      Janosch
Rusl=E1n Ledesma Garza schrieb:
> Can anyone give me a hint on how to fix this? Anything would be usefu=
l.=20
> Am I in the right place for reporting ACPI bugs?
>=20
>> >Hi. I'm a newbie to linux, but I've been getting this problem ever
>> >since I installed it on my computer (I've already tested Fedora Cor=
e 5
>> >and Ubuntu 6, both having the same problem).
>> >
>> >1) I first discovered that my laptop display didn't turn off when t=
he
>> >lid was closed (I can tell because I can see the glare of the displ=
ay
>> >through a gap). So I started investigating and found that the lid
>> >event is not triggered whenever I close/open the lid (using
>> >acpi_listen). But the weirdest part is that the event is reported w=
hen
>> >doing "cat /proc/acpi/button/lid/LID/state".
>>
>> is the video driver loaded (drivers/acpi/video.c)
>=20
> When doing "lsmod", response is "video                  16260  0", so=
 I
> think answer is yes.
>=20
>>
>> >2) Then I realized no events are reported through acpi_listen, exce=
pt
>> >for "ac_adapter" event which occurs after resuming the laptop from
>> >hibernation.
>>
>> How about power button events?
>=20
> No other events rather than ac_adapter are reported, including button
> events.
>=20
>>
>> >3) I've also found that sometimes the computer freezes when resumin=
g
>> >from hibernation (I can only confirm this under Ubuntu, I can't
>> >remember what happens with Fedora).
>> >
>> >4) Finally, for some reason gnome power manager doesn't put into
>> >hibernation my computer when battery is too low (the only time I
>> >tested this was under Ubuntu) and simply runs out of battery.
>> >
>> >Since #'s 1 & 2 have ocurred under Fedora and Ubuntu, I assume ther=
e
>> >is some low level problem/incompatibility of ACPI with my computer'=
s
>> >hardware. Everything works fine under WinXP, and to me power
>> >management is a must for my laptop.
>> >
>> >I've read some stuff about DST's, but sincerelly I didn't undestand
>> >much (ie. where does this DST reside? Is it a firmware?),
>>
>> modified DSDT's are a debugging tool only -- not a path to a "real f=
ix".
>> Linux should work properly on your laptop without any modifications
>> to the firmware.  (though it might be a good idea to check with Dell
>> to make sure you're running the latest).
>=20
> Last time I checked (about 3 weeks ago) the bios firmware was the lat=
est
> ("A07"). By the way, are DSDT's firmwares then?
>=20
>>
>> >but I wonder
>> >if the fact that my DST says "MSFT" could be the cause of ACPI not
>> >working propertly.
>>
>> :-)  This means it was built with the MSFT ASL compiler.  Sometimes
>> that is an issue, but we try to handle those issues and re-building
>> the firmwarwe with Intel's compiler is okay for debugging, but not
>> supportable.
>>
>> build with  CONFIG_ACPI_DEBUG=3Dy and see if any new dmesg come out.
>> You can also boot with "acpi=3Dstrict" if you want to see if
>> Linux is already working around issues in your DSDT.
>=20
> I've already tried to build my DSDT using Intel's compiler. It showed
> several errors (can't remember which ones, but I can do it again if t=
his=20
> can
> help). I think I fixed them, but could never get to install the modif=
ied
> DSDT.
>=20
> What can I do?
>=20
>>
>> -Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
