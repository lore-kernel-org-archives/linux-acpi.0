From: "Brown, Len" <len.brown@intel.com>
Subject: RE: ACPI not working on DELL Inspiron 1150
Date: Sun, 9 Jul 2006 17:10:45 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECF9E0@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:31325 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1161152AbWGIVKs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jul 2006 17:10:48 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?Q?Rusl=E1n_Ledesma_Garza?= <ruslanledesmag@hotmail.com>, linux-acpi@vger.kernel.org


>Hi. I'm a newbie to linux, but I've been getting this problem ever
>since I installed it on my computer (I've already tested Fedora Core 5
>and Ubuntu 6, both having the same problem).
>
>1) I first discovered that my laptop display didn't turn off when the
>lid was closed (I can tell because I can see the glare of the display
>through a gap). So I started investigating and found that the lid
>event is not triggered whenever I close/open the lid (using
>acpi_listen). But the weirdest part is that the event is reported when
>doing "cat /proc/acpi/button/lid/LID/state".

is the video driver loaded (drivers/acpi/video.c)

>2) Then I realized no events are reported through acpi_listen, except
>for "ac_adapter" event which occurs after resuming the laptop from
>hibernation.

How about power button events?

>3) I've also found that sometimes the computer freezes when resuming
>from hibernation (I can only confirm this under Ubuntu, I can't
>remember what happens with Fedora).
>
>4) Finally, for some reason gnome power manager doesn't put into
>hibernation my computer when battery is too low (the only time I
>tested this was under Ubuntu) and simply runs out of battery.
>
>Since #'s 1 & 2 have ocurred under Fedora and Ubuntu, I assume there
>is some low level problem/incompatibility of ACPI with my computer's
>hardware. Everything works fine under WinXP, and to me power
>management is a must for my laptop.
>
>I've read some stuff about DST's, but sincerelly I didn't undestand
>much (ie. where does this DST reside? Is it a firmware?),

modified DSDT's are a debugging tool only -- not a path to a "real fix".
Linux should work properly on your laptop without any modifications
to the firmware.  (though it might be a good idea to check with Dell
to make sure you're running the latest).

>but I wonder
>if the fact that my DST says "MSFT" could be the cause of ACPI not
>working propertly.

:-)  This means it was built with the MSFT ASL compiler.  Sometimes
that is an issue, but we try to handle those issues and re-building
the firmwarwe with Intel's compiler is okay for debugging, but not
supportable.

build with  CONFIG_ACPI_DEBUG=y and see if any new dmesg come out.
You can also boot with "acpi=strict" if you want to see if
Linux is already working around issues in your DSDT.

-Len
