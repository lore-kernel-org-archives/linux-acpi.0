From: Michael Zintakis <michael.zintakis@googlemail.com>
Subject: Re: [lm-sensors] Fintek f71882fg ACPI conflict
Date: Thu, 28 Jun 2012 18:39:03 +0100
Message-ID: <4FEC96B7.50500@googlemail.com>
References: <4FEA4C10.2060904@googlemail.com> <20120627171505.GB12712@roeck-us.net> <4FEB90A8.8050901@googlemail.com> <20120628052032.GA16364@roeck-us.net> <4FEC4092.7090104@googlemail.com> <20120628171209.GB7283@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:46800 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756Ab2F1RjS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jun 2012 13:39:18 -0400
Received: by lbbgm6 with SMTP id gm6so3391323lbb.19
        for <linux-acpi@vger.kernel.org>; Thu, 28 Jun 2012 10:39:17 -0700 (PDT)
In-Reply-To: <20120628171209.GB7283@roeck-us.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org


> That isn't BIOS fan management - it is completely handled by the chip itself.
>   
Whatever it is, it seems to be "automatic" - i.e. I don't determine what 
needs to be done, but the BIOS/the driver does this "on my behalf", 
which is good enough for me, provided I know how to avoid the ACPI 
conflict, because I am not about to start playing Russian roulette with 
my hardware.

I've spend some time earlier today looking at the ACPI code and it seems 
as though the first conflicting region (\_TZ_.IP__ 1) is from the ACPI 
thermal driver. I think I could easily deactivate this with 
"thermal.off=1". The second region though  (\_SB_.PCI0.LPCB.SIO1.RNTR) 
is a complete mystery to me.

There are a couple of lines in my dmesg file where these IO regions are 
mentioned:

[    0.117903] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7]
[...]
[    0.117952] pci 0000:00:00.0: [8086:0bf3] type 0 class 0x000600
[...]
[    0.203459] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7]
[...]
[    0.203550] pci_bus 0000:04: resource 4 [io  0x0000-0x0cf7]

So, provided I could avoid the first conflict by using thermal.off=1, I 
need to find out what is causing the second one and find out how to 
prevent it...

> Problem is most likely that the BIOS does not "kick-start" the fan(s),
> and the chip does not have a register to set a "start fan" pwm value (other
> chips such as the NCT677X do have a register for that purpose).
Yep, that seems to be the case indeed.

>  So you may
> be stuck with your manual method if you want to keep the fan running at speeds
> lower than pwm=190.
Would it be possible for such feature to be implemented in the f71882fg 
driver? Most of the stuff which is done with my bash script will be very 
easy to implement in the driver as it involves nothing more than playing 
with the registry values and adding a bit of logic to it. Would that be 
possible?

>  Another option might be to find a fan which starts at lower
> pwm values, and/or does not need to be kick-started.
>   
I've had enough problem selecting the fans which suit my needs (i.e. 
noise levels, RPM speed, power consumption etc) and I am not prepared to 
go through that again, no way!


MZ
