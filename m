From: Pavel Troller <patrol@sinus.cz>
Subject: Re: [PATCH] amd76x_pm: C3 powersaving for AMD K7
Date: Sat, 4 Feb 2006 11:49:16 +0100
Message-ID: <20060204104916.GA26540@tangens.sinus.cz>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005F343AE@hdsmsx401.amr.corp.intel.com> <1139049096.23009.17.camel@localhost.localdomain>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:23752 "EHLO tangens.sinus.cz")
	by vger.kernel.org with ESMTP id S1751485AbWBDKtY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Feb 2006 05:49:24 -0500
Content-Disposition: inline
In-Reply-To: <1139049096.23009.17.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Erik Slagter <erik@slagter.name>
Cc: "Brown, Len" <len.brown@intel.com>, Pavel Troller <patrol@sinus.cz>, linux-acpi@vger.kernel.org

> 
> That would really be interesting. And I do have a power meter, it says
> that putting the processors in C2 really does save ~70 watts, running
> linux. I cannot test it for windows though, I do not have a license, nor
> the install CD's nor any spare room on the disks to put it on :-(. So I
> hope somebody else does...

I'm sorry but I also cannot compare. Believe or not, I NEVER had any M$ OS
installed on any of my machines and I don't want to change my customs :-).
However, my server is connected through an UPS. Without the module inserted,
it indicates about 37 minutes of battery power and its load meter (a LED bar)
indicates 2 - 3 from 5 LEDs. When the module is in, it shows over 60 minutes
(about twice as much) battery power time and just 1 LED is lit on the load
meter. So the impact of the module is really noticeable and highly welcome.
I never had problems to patch it into my kernel sources, I don't require it
to be a native part of it. But, many thanks for it, it's been in use for more
than two years here on my MSI K7D Master and never caused any major trouble.

                         With regards, Pavel Troller.

