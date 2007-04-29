From: Andi Kleen <ak@suse.de>
Subject: Re: PCI Express MMCONFIG and BIOS Bug messages..
Date: Sun, 29 Apr 2007 12:12:03 +0200
Message-ID: <200704291212.03171.ak@suse.de>
References: <4626C514.5010605@shaw.ca> <46279358.1010002@redhat.com> <4633F363.4000009@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:50314 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755138AbXD2KM3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 06:12:29 -0400
In-Reply-To: <4633F363.4000009@shaw.ca>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Hancock <hancockr@shaw.ca>
Cc: Chuck Ebbert <cebbert@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org


> 
> I tried adapting a patch by Rajesh Shah to do this for current kernels:

The Intel patches checked against ACPI which also didn't work in all cases.

You're right the e820 check is overzealous and has a lot of false positives,
but it is the only generic way we know right now to handle a common i965 BIOS
bug. Also there is the nasty case of the Apple EFI boxes where only mmconfig
works which has to be handled too.

I expect eventually the logic to be:

- If we know the hardware: read it from hw registers; trust them; ignore BIOS.
- Otherwise check e820 and ACPI resources and be very trigger happy at not using
it

> It walks through all the motherboard resource devices and tries to pull 
> out the resource settings for all of them using the _CRS method. 

I tested it originally on a Intel system with the above BIOS problem
and it didn't help there.

> (Depending on how you do the probing, the _STA method is called as well, 
> either before or after.) From my limited ACPI knowledge, the problem is 
> that the PCI MMCONFIG initialization is called before the main ACPI 
> interpreter is enabled, and these control methods may try to access 
> operation regions who don't have handlers set up for them yet, so a 
> bunch of "no handler for region" errors show up.

mmconfig access can be switched later without problems; so it would
be possible to boot using Type1 if it works (e.g. detect the Apple case) 
and switch later.

It's all quite tricky unfortunately; that is why i left it at the current
relatively safe state for now. After all mmconfig is normally not needed.

> So essentially if we want to do this check based on ACPI resource 
> reservations, we need to be able to execute control methods at the point 
> that MMCONFIG is set up. Is there a reason why this can't be made 
> possible (like by moving the necessary parts of ACPI initialization 
> earlier)?

ACPI Interpreter wants to allocate memory and use other kernel services that
are not available in really early boot. It could be probably done somehow,
but would be quite ugly with lots of special cases.

-Andi
 


