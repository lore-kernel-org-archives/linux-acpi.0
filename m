From: Benoit Izac <benoit.izac@free.fr>
Subject: Battery Status Changed repeated every 16 seconds
Date: Sat, 07 Feb 2009 14:12:43 +0100
Message-ID: <w53prhue6gk@message.id>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lns-bzn-51f-62-147-243-137.adsl.proxad.net ([62.147.243.137]:55709
	"EHLO wok.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752736AbZBGNXo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Feb 2009 08:23:44 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I have a strange and boring problem with my laptop (Toshiba tecra M9).
Every 16 seconds (sometimes 32), /proc/acpi/event return a "Battery
Status Changed" (battery BAT1 00000080 00000001). This event appears
always, battery charged or not.

Last night, I tried to remove the AC adapter and record all events in
a file. After I receive
    ac_adapter ADP1 00000080 00000000
    processor CPU0 00000081 00000000
    processor CPU1 00000081 00000000
I hadn't other events than battery BAT1 00000080 00000001.

At this moment if I look at /proc/acpi/event:
# for a in 1 2 3; do read a < /proc/acpi/event; date; echo $a; \
  cat /proc/acpi/battery/BAT1/state; done
Sat Feb  7 14:03:16 CET 2009
battery BAT1 00000080 00000001
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mW
remaining capacity:      46981 mWh
present voltage:         11340 mV
Sat Feb  7 14:03:32 CET 2009
battery BAT1 00000080 00000001
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mW
remaining capacity:      46981 mWh
present voltage:         11340 mV
Sat Feb  7 14:03:48 CET 2009
battery BAT1 00000080 00000001
present:                 yes
capacity state:          ok
charging state:          charged
present rate:            0 mW
remaining capacity:      46981 mWh
present voltage:         11340 mV

Is this behavior normal?
How do I know that the battery has low capacity (there is no event for
this)?
How can I remove these events (my log files grow for nothing)?

-- 
Benoit Izac
