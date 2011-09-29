From: Silvio Caggia <silvio.caggia@tiscali.it>
Subject: I have some problems with acpi on my laptops:
Date: Thu, 29 Sep 2011 22:13:59 +0000 (UTC)
Message-ID: <loom.20110930T000656-380@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:33468 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750940Ab1I2WUK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Sep 2011 18:20:10 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-acpi-devel@m.gmane.org>)
	id 1R9Oxc-0007AC-OO
	for linux-acpi@vger.kernel.org; Fri, 30 Sep 2011 00:20:08 +0200
Received: from net-93-71-116-12.cust.dsl.vodafone.it ([93.71.116.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Fri, 30 Sep 2011 00:20:08 +0200
Received: from silvio.caggia by net-93-71-116-12.cust.dsl.vodafone.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Fri, 30 Sep 2011 00:20:08 +0200
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I have some problems with acpi on my laptops:

first laptop is a Compaq Evo N800v:
- Lucid Puppy 5.2.8 installed in frugal mode
- Xorg_High-1.1-Lucid.pet installed
- acpitool-0.5.1-i486.pet installed
if I run acpitool -s it suspends correctly, but when I press power on all 
the laptop awakes except video display.
So the screen is black, if I press caps-lock the led works, if I press 
ctrl-alt-F1 and then ctrl-C I am still able to (blindly) type reboot...
It seems that the video adapter is not able to awake.
note: on the second laptop, a Compaq 6720s, if works perfectly.
Any suggestion?

I have also some problems of heating that causes video flickering when 
temperature raises.
When the pc is cold all works fine, as in a few minutes temperature raises 
the display starts flickering.
At the beginnign pressing and releasing the lid button is a momentary 
workaround to turn the display on. as temperature raise more the computer 
is pratically unusable.
using acpi-cpufreq with ondemand governor give me more time before the 
problem arise (cpu works most of time at 1.20Ghz instead of 1.80Ghz)
using Xvesa instead of radeon video drivers is a good workaround in spite 
of performance (glxgears runs 500 instead of 5000)
using software that do lot of things on screen or use lot of cpu the 
problem arise earlier.
applying a strong pressure with fingers on some points of the laptop is a 
desperate workaround for a few seconds... amazing but true!
note: external monitor seems not suffer of this problem.
I am trying to keep the laptop cool raising fan speed but I was not able 
to modify trip_points (they seems read only on lucid puppy), I tried also 
the commands:
echo -n 0 > /proc/acpi/fan/C1DC/state
echo -n 0 > /proc/acpi/fan/C1DB/state
echo -n 0 > /proc/acpi/fan/C1DA/state
echo -n 0 > /proc/acpi/fan/C1D9/state
that activate the fan at max speed but after 4 seconds they turn back to 
low speed.
Any suggestion?

second laptop is a Compaq 6720s:
- Lucid Puppy 5.2.8 booted from usbkey (windows7 on HD)
- acpitool-0.5.1-i486.pet
Problems with Lucid CPU Frequency Scaling Tool 0.7 (present in distro):
no one of the drivers listed is accepted except of p4-clockmod, this 
driver is warned not to work correcty in the banner of the Frequency 
Scaling Tool, and really I was not able to activate ondemand governor.
it only works with performance governor with a fixed 1,8Ghz speed heating 
very much the laptop and putting fan at high-speed all the time, or with 

powersave governor with a fixed 222Mhz speed, so slow that the system is 
not usable.
the cpu is a Celeron
note: on the first laptop, a Compaq Evo N800v, driver acpi-cpufreq works 
fine with ondemand governor, driver p4-clockmod have same problems.
How to activate a working driver with ondemand governor?

