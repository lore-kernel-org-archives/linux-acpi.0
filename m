From: Pavel Troller <patrol@sinus.cz>
Subject: Suspend/resume waiting for a key ?
Date: Mon, 23 Jan 2006 07:07:43 +0100
Message-ID: <20060123060743.GA22878@tangens.sinus.cz>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:36778 "EHLO tangens.sinus.cz")
	by vger.kernel.org with ESMTP id S964832AbWAWGHp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Jan 2006 01:07:45 -0500
Received: from tangens.sinus.cz (patrol@localhost [127.0.0.1])
	by tangens.sinus.cz (8.13.5/8.13.5) with ESMTP id k0N67hNV029844
	for <linux-acpi@vger.kernel.org>; Mon, 23 Jan 2006 07:07:43 +0100
Received: (from patrol@localhost)
	by tangens.sinus.cz (8.13.5/8.13.5/Submit) id k0N67hEJ029843
	for linux-acpi@vger.kernel.org; Mon, 23 Jan 2006 07:07:43 +0100
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi!
  Yesterday I was installing Linux to my friend's notebook. It was a Compaq
model; sorry but just now I don't remember exact ID.
  When I tried STD, in principle it worked, but there were some strange things
happening. Especially, it wrote a bunch of obvious messages (mostly about
various devices on a PCI bus) and then it stopped. I was waiting about 30
seconds and then tried to switch the consoles. As soon as I pressed Alt, the
process continued smoothly and the machine suspended itself.
  During resuming, the same was observed. To resume quickly, repeated pressing
of any key was of a great help. Otherwise resuming process hang in various
phases, but pressing a key helped.
  It has to be said that even switching from X server to text console during
normal operation sometimes behaves similarly; the graphics screen remains
visible until any key is pressed, after that, it immediately turns to the text
console.
  I've tried ec_burst=1, but the machine was unable to suspend then.
  All this was tested with 2.6.15.1 kernel.
  There weren't any unusual mesages in the syslog/suspending console.
  I don't have access to the machine now, but some tuning is still neccessary,
so I will see it in a near future. I would like to gain some ideas before, to
retry my attempts with STD. So any ideas what to try are greatly appreciated
:-).
                     With regards, Pavel Troller
