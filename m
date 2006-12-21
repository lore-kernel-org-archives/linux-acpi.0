From: Peter Clifton <pcjc2@cam.ac.uk>
Subject: Re: HP nc6400 v.03 or v.05 laptop ACPI fails after reboot, works
	again after booting windows
Date: Thu, 21 Dec 2006 22:40:51 +0000
Message-ID: <1166740851.5576.5.camel@pcjc2lap>
References: <457F37C0.3090003@gmail.com>
	 <1165966936.29844.37.camel@pcjc2lap> <457FB1A1.2030602@gmail.com>
	 <1166012707.22903.4.camel@pcjc2lap> <4582A607.8040302@gmail.com>
	 <1166191807.7459.16.camel@pcjc2lap> <45832339.3050307@gmail.com>
	 <20061216043002.GA29560@tangens.sinus.cz> <4583A779.3000902@gmail.com>
	 <20061216081757.GA3571@invalid.invalid>  <458B0027.2000909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:41196 "EHLO
	ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423089AbWLUWlE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Dec 2006 17:41:04 -0500
In-Reply-To: <458B0027.2000909@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lincoln Baxter, III" <lincolnbaxter@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Thu, 2006-12-21 at 16:44 -0500, Lincoln Baxter, III wrote:
[snip]
> Can someone point me to the code that determines the voltage / amperage 
> pairings for CPUs in power saving mode? Is this handled by the ACPI bios 
> (bios function call), or does the kernel directly affect the power setting?
> 
> I'd like to take a look and see what's going on.

I can't recall where in the code this is, but it is the bios which
provides the voltage/frequency pairings. The speed-step drivers for
older processors actually have them hard-coded as a table.

If you're not seeing the highest frequency - I don't know what the
problem is. Mine re-appeared after the rmmod psmouse trick I posted
earlier. The CPU specs are in a separate SSDT on my laptop, which only
shows up when the appropriate bios setting for speedstep is ticked, and
the bios is "happy" (psmouse removed before shutdown).

Peter C.


