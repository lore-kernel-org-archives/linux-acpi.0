From: Pavel Troller <patrol@sinus.cz>
Subject: Another motherboard with broken processor ACPI
Date: Wed, 15 Feb 2006 14:53:10 +0100
Message-ID: <20060215135310.GA4587@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:33189 "EHLO tangens.sinus.cz")
	by vger.kernel.org with ESMTP id S1945945AbWBONxM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Feb 2006 08:53:12 -0500
Received: from tangens.sinus.cz (patrol@localhost [127.0.0.1])
	by tangens.sinus.cz (8.13.5/8.13.5) with ESMTP id k1FDrACG012097
	for <linux-acpi@vger.kernel.org>; Wed, 15 Feb 2006 14:53:10 +0100
Received: (from patrol@localhost)
	by tangens.sinus.cz (8.13.5/8.13.5/Submit) id k1FDrAEE012096
	for linux-acpi@vger.kernel.org; Wed, 15 Feb 2006 14:53:10 +0100
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi!
  Because one of my motherboards exhibited some stability problems, I've
decided to try a new one. And because I wanted to keep all the remaining
components like CPU and RAM, I've bought the probably last 32bit Athlon
board from MSI with VIA KT880 chipset.
  On a box of the board, there are many pictures and texts saying how much
is that board good in power saving, that its new technology allows saving
about 65% of energy etc. etc, that the clock of the CPU can be reduced at
idle times etc. Of course there is a CD with windoze programs allowing to do
all this magic, there are screenshots in the manual, how to achive all this.
  After installation, I've found that the board is almost compatible with
my older one. Just a new module for ethernet had to be compiled. But when
I looked at /proc/acpi/processor/CPU1/power, it was very similar to the
picture so many times discussed here: Just C1 detected and used.
  I dumped my FADT and found the obvious trick: P2_LVL_LAT = 101,
P3_LVL_LAT = 1001. OK. BUT... my acpi/processor.h is patched, allowing to
enter deeper C states even for latencies being so high! Why the hell it's
not recognizing them now ? OK, no bus master, so no C3, but what about C2 ?
It's definitly something out of FADT, because I've compared it with the old
one and except some addresses they are identical.
  I also tried to activate athcool.. It said it did its work but there is
no impact to the CPU temperature, which is all the time at about 60C...
Other CPU acpi features like throttling or limit interface, are disabled too.
  So in Linux, this mobo is a real power-sucker :-(.
  You can really see that the motherboard vendors are bypassing the standard
methods of resources control (i.e. ACPI) and they are doing things by their
proprietary interfaces, available for selected OSes only :-(((.
                                         With regards, Pavel Troller
