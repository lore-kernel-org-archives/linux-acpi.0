From: "=?ISO-8859-1?Q?Rusl=E1n_Ledesma_Garza?="
	<ruslanledesmagarza@gmail.com>
Subject: ACPI not working on DELL Inspiron 1150
Date: Sat, 8 Jul 2006 16:18:49 -0500
Message-ID: <9d90148c0607081418j6d58d49eo3cb6830305610266@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:60367 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030395AbWGHVSu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 8 Jul 2006 17:18:50 -0400
Received: by py-out-1112.google.com with SMTP id 57so513180pya
        for <linux-acpi@vger.kernel.org>; Sat, 08 Jul 2006 14:18:49 -0700 (PDT)
Content-Disposition: inline
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
