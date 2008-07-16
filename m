From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI Problems on Sony Vaio SZ61MN, no brightness ctrl, no
	power button
Date: Wed, 16 Jul 2008 09:38:19 +0800
Message-ID: <1216172299.1617.145.camel@rzhang-dt>
References: <487CA418.6060103@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55498 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbYGPBj1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Jul 2008 21:39:27 -0400
In-Reply-To: <487CA418.6060103@uni-koblenz.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sebastian Pohl <sebastianp@uni-koblenz.de>
Cc: linux-acpi@vger.kernel.org, malattia@linux.it

Hi, Sebastian,

Please file a new bug report for each of the problem (power button and
brightness) at http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach the files listed below. :)

On Tue, 2008-07-15 at 15:20 +0200, Sebastian Pohl wrote:
> Hi there!
> 
> First i hope my other messages have realy disappereard. I send them 
> yesterday from a windows machine and as described in the FAQ it seemed 
> to be blocked because of the charset. If by any chance that message 
> arrives please excuse it and ignore it!
> 
> My Problem exists on a Sony Vaio Laptop with the modelcode SZ61MN/B. I 
> am currently running Archlinux with a 2.6.25.11-1 kernel. Most things on 
> the notebook seem to be working, even the lidswitch is recognized.
> 
> Problems are the non-working power button,
what do you mean by non-working power button?
Pressing the power button doesn't power off the laptop, right?
what if you press it for four seconds?

please run "grep . /sys/firmware/acpi/interrupts/*" both before and
after pressing the power button and attach the result.

>  thats a real problem, just 
> annoying, and what realy is a pain, the backlight brigthness is not 
> adjustable, so i always get a nice suntan from the screen. That realy 
> sucks at night...
please attach the acpidump output with the latest pmtools at
http://www.lesswatts.org/patches/linux_acpi/

> 
> I tried for about a week now to find a solution and i worked my way 
> through all of the possible solutions called sony-laptop, sonypi, 
> sony-acpi but none of them worked for me.
what did you get?
empty /sys/class/backlight/ entry with any of these drivers loaded?
or the backlight I/F exists but they don't work for you?

cc Mattia, who is the maintainer of sony-laptop driver. :)

thanks,
rui

