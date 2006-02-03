From: Pavel Troller <patrol@sinus.cz>
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Date: Fri, 3 Feb 2006 11:31:27 +0100
Message-ID: <20060203103127.GA17072@tangens.sinus.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005EFE84D@hdsmsx401.amr.corp.intel.com> <1138959312.18273.14.camel@localhost.localdomain>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:52121 "EHLO tangens.sinus.cz")
	by vger.kernel.org with ESMTP id S1751036AbWBCKpi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Feb 2006 05:45:38 -0500
Received: from tangens.sinus.cz (patrol@localhost [127.0.0.1])
	by tangens.sinus.cz (8.13.5/8.13.5) with ESMTP id k13Ajakq023587
	for <linux-acpi@vger.kernel.org>; Fri, 3 Feb 2006 11:45:36 +0100
Received: (from patrol@localhost)
	by tangens.sinus.cz (8.13.5/8.13.5/Submit) id k13Ajar8023586
	for linux-acpi@vger.kernel.org; Fri, 3 Feb 2006 11:45:36 +0100
Content-Disposition: inline
In-Reply-To: <1138959312.18273.14.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Erik Slagter <erik@slagter.name>

> > Certainly the BIOS writer also had access to that document, plus
> > documents we do not see, yet they decided NOT to enable C2/C3.
> 
> You are probably right, but I remain suspicious that the BIOS writers
> simply didn't want to go through the trouble of implementing and testing
> the whole thing, presumable because:
>...
> If I remember correctly there was some sort of windows driver supplied
> with the board to enable power saving. This would suggest that in
> principle there is no reason it cannot work.
> 
EXACTLY. It is the main problem. I'm afraid that BIOS writers are writing
just the basic part, and they hope that the rest will be done by the OS
driver (which they eventually also supply, but just for the "majority"
OS :-((( ).
  I have EXACTLY the same problem with my Clevo D610SU notebook. It's a SIS
chipset with Intel P4/2G4. In Linux, it's surface is always warm, the fan
is starting every moment even in the full idle. 6000 mAh accu can power it
for 45 mins. The same hardware on windoze with a driver supplied on the CD
which came with the notebook is cold all the time (ok, in idle), the fans
start on a heavy load only, and the battery is enough for 2.5 - 3 hours.
  And yes, in RSDT, L2_LAT is 101 and L3_LAT is 1001, just for being disabled.
  I even patched Linux to accept them. It is not fatal. C2 is used, C3 isn't
because of lack of BM capabilities, but there is NO CHANGE in the power
consumption :-(. I even use dyntick to maximize the power saving. 
  Does anybody a clue, what to do in this case ? 
                                          With regards, Pavel Troller
