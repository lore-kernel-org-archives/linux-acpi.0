From: Pavel Troller <patrol@sinus.cz>
Subject: Re: HP nc6400 v.03 or v.05 laptop ACPI fails after reboot, works again after booting windows
Date: Sat, 16 Dec 2006 05:30:02 +0100
Message-ID: <20061216043002.GA29560@tangens.sinus.cz>
References: <457F37C0.3090003@gmail.com> <1165966936.29844.37.camel@pcjc2lap> <457FB1A1.2030602@gmail.com> <1166012707.22903.4.camel@pcjc2lap> <4582A607.8040302@gmail.com> <1166191807.7459.16.camel@pcjc2lap> <45832339.3050307@gmail.com>
Reply-To: Pavel Troller <patrol@sinus.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tangens.sinus.cz ([195.39.17.8]:34328 "EHLO tangens.sinus.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932304AbWLPEpw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Dec 2006 23:45:52 -0500
Content-Disposition: inline
In-Reply-To: <45832339.3050307@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lincoln Baxter, III" <lincolnbaxter@gmail.com>
Cc: linux-acpi@vger.kernel.org

Hi!
> Update:
> 
> Kernel 2.6.18-r4
> 
> I've done some more testing, and I've narrowed the problem down to the 
> "processor" cpu driver.
> I disabled all power management features in the kernel, and compiled 
> ACPI as modules so that they would not be loaded until I wanted them to be.
> 
> APM is off.
> CPU Frequency Scaling is off.
> ACPI is compiled entirely as modules to be loaded by the user.
> 
> While running on the battery:
> As soon as I "modprobe processor" the humming begins, and as soon as I 
> "rmmod processor" the humming stops.
> 
> While running on AC, if I "modprobe processor" there is no buzzing. I 
> can remove the AC adapter and the computer remains silent.
Try the following:
  cat /proc/acpi/processor/*/power in the following situations:
  1) After loading the processor module being on the battery,
  2) After loading the processor module being on AC,
  3) After disconnecting the AC,
and compare the results. I think that for 1), you will see more C-states than
for 2) and that possibly the missing C-states are not added for 3).
> 
> It seems to be something related to the way that the processor driver is 
> handling power to the CPU. Ideas?
It looks that when your machine doesn't hum, it doesn't save so much power.
Try to change the timer frequency, I suspect that frequency of the hum tracks
it. Try to set it at 1000 Hz if it's not already there; possibly at this
frequency, capacitors will do better work and filter the peaks on the power
bus better. You can also use 100 Hz - maybe the hum will go lower and will be
less hearable.
          With regards, Pavel Troller
