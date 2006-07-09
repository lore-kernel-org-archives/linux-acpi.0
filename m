From: =?iso-8859-1?B?UnVzbOFuIExlZGVzbWEgR2FyemE=?=
	<ruslanledesmag@hotmail.com>
Subject: ACPI not working on DELL Inspiron 1150
Date: Sun, 09 Jul 2006 16:01:30 -0500
Message-ID: <BAY116-F15D8E98DE34A657F4EC424C86A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bay0-omc1-s17.bay0.hotmail.com ([65.54.246.89]:33376 "EHLO
	bay0-omc1-s17.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1161146AbWGIVBc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 9 Jul 2006 17:01:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi. I'm a newbie to linux, but I've been getting this problem ever
since I installed it on my computer (I've already tested Fedora Core 5
and Ubuntu 6, both having the same problem).

1) I first discovered that my laptop display didn't turn off when the
lid was closed (I can tell because I can see the glare of the display
through a gap). So I started investigating and found that the lid
event is not triggered whenever I close/open the lid (using
acpi_listen). But the weirdest part is that the event is reported when
doing "cat /proc/acpi/button/lid/LID/state".

2) Then I realized no events are reported through acpi_listen, except
for "ac_adapter" event which occurs after resuming the laptop from
hibernation.

3) I've also found that sometimes the computer freezes when resuming
from hibernation (I can only confirm this under Ubuntu, I can't
remember what happens with Fedora).

4) Finally, for some reason gnome power manager doesn't put into
hibernation my computer when battery is too low (the only time I
tested this was under Ubuntu) and simply runs out of battery.

Since #'s 1 & 2 have ocurred under Fedora and Ubuntu, I assume there
is some low level problem/incompatibility of ACPI with my computer's
hardware. Everything works fine under WinXP, and to me power
management is a must for my laptop.

I've read some stuff about DST's, but sincerelly I didn't undestand
much (ie. where does this DST reside? Is it a firmware?), but I wonder
if the fact that my DST says "MSFT" could be the cause of ACPI not
working propertly.

Thanks in advance.

_________________________________________________________________
Prodigy/MSN Spaces: Crea tu propio espacio. http://spaces.msn.com/

