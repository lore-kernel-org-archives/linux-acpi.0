From: Pavel Troller <patrol@sinus.cz>
Subject: Strange things on 2.6.19/20 for a dual-core CPU
Date: Mon, 5 Feb 2007 07:04:04 +0100
Message-ID: <20070205060404.GA23121@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:43191 "EHLO tangens.sinus.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731AbXBEGEH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Feb 2007 01:04:07 -0500
Received: from tangens.sinus.cz (patrol@localhost [127.0.0.1])
	by tangens.sinus.cz (8.13.5.20060308/8.13.5) with ESMTP id l15644Ei023854
	for <linux-acpi@vger.kernel.org>; Mon, 5 Feb 2007 07:04:04 +0100
Received: (from patrol@localhost)
	by tangens.sinus.cz (8.13.5.20060308/8.13.5/Submit) id l15644H5023853
	for linux-acpi@vger.kernel.org; Mon, 5 Feb 2007 07:04:04 +0100
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi!
  I posted the following question, when 2.6.19 was freshly out. However, nobody
has answered. OK, I told myself, let's get things to stabilize, and I waited
patiently for 2.6.20. Now, the things are absolutely the same, and IMHO wrong.
Could anybody look at this and decide, whether it is a real bug, which has to
be fixed, or not ?
      With regards, Pavel Troller
      
----- Forwarded message from Pavel Troller <patrol@sinus.cz> -----

From: Pavel Troller <patrol@sinus.cz>
To: linux-acpi@vger.kernel.org
Subject: Strange things on 2.6.19 for a dual-core CPU
Mail-Followup-To: Pavel Troller <patrol@sinus.cz>,
	linux-acpi@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i

Hi!
  I've updated to vanilla 2.6.19 on my Pentium-D (dual-core x86_64) box.
Now I can't see even C1 in the /proc/acpi/processor/*/power output:
patrol@arcus:~$ cat /proc/acpi/processor/CPU1/power
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000 usec
states:
patrol@arcus:~$ cat /proc/acpi/processor/CPU2/power
active state:            C0
max_cstate:              C8
bus master activity:     00000000
maximum allowed latency: 2000 usec
states:

  Another interesting thing is shown here:
patrol@arcus:~$ cat /proc/acpi/processor/CPU1/info
processor id:            0
acpi id:                 1
bus mastering control:   no
power management:        no
throttling control:      yes
limit interface:         yes
patrol@arcus:~$ cat /proc/acpi/processor/CPU2/info
processor id:            1
acpi id:                 2
bus mastering control:   no
power management:        no
throttling control:      no
limit interface:         no

  As I remember, both cores were showing the same things formerly.
  The only line referring to CPUs during boot is
ACPI: Processor [CPU1] (supports 8 throttling states)
  and CPU2 is not mentioned at all.

  The last (but maybe not acpi-related) strange thing is that in /proc/cpuinfo,
CPU1 reports 6403.56 bogomips (as always, approximately twice the clock) and CPU2
8314.32 ones (too much). It's also very suspicious. Formerly the difference was
very small.

  Should I provide more info to debug these things, or is it OK ?
         With regards, Pavel Troller

----- End forwarded message -----
