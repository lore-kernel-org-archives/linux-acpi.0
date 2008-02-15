From: Len Brown <lenb@kernel.org>
Subject: Re: Dell OptiPlex 755 ACPI: DMI
Date: Fri, 15 Feb 2008 00:53:00 -0500
Message-ID: <200802150053.01058.lenb@kernel.org>
References: <47B17562.7010107@zertificon.com> <200802132249.05631.lenb@kernel.org> <TBoneMsgId%zertificon.com%47B410EE.5060303%zertificon.com%m.naumann@zertificon.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60930 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753441AbYBOFxO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Feb 2008 00:53:14 -0500
In-Reply-To: <TBoneMsgId%zertificon.com%47B410EE.5060303%zertificon.com%m.naumann@zertificon.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Moritz Naumann <securemail@zertificon.com>
Cc: linux-acpi@vger.kernel.org

On Thursday 14 February 2008 04:59, Moritz Naumann wrote:
> Len Brown wrote:
> > Linux appears to be a special case in this BIOS.
> > ISLI returns 1 for OSI(Linux), which causes GUSB to do nothing.
> > (otherwise GUSB appears to touch SMM).  GUSB is called at init time,
> > and also at wakup time.
> 
> I will need to read up a little on these terms (ISLI, GUSB, SMM), as I 
> know neither of them so far.

ISLI and GUSB are arbitrary method names in the source code for
the ACPI BIOS -- they have no inherent meaning.  One can often guess
what the BIOS programmer meant though -- GUSB touches the USB device,
for example...

Unfortunately, the architectes of ACPI chose to limit identifiers
to 4 characters, so there is a limit at how expressive they can be...

SMM is System Management Mode.
This is a feature of x86 chips where BIOS code can transparently
run without the OS knowing it.  Basically, you enter this mode
via an SMI (System Management Interrupt) run your hidden BIOS code
and then return and the OS never knows it happened.

SMM is probably the most hated platform feature by OS people,
even worse than ACPI.  The reason is beause we can't debug it.

> > Do you notice any difference in USB operation with acpi_osi=Linux?
> > How about after resume from suspend?
> 
> I assume you are referring to suspend to disk? I don't use this on this 
> system.

either hibernate to disk or suspend to ram may be affected.

> I don't know whether it is related, but on this kernel (recent Debian 
> testing backport to stable)...
> 
> Linux version 2.6.22-3-amd64 (Debian 2.6.22-6~bpo40+1) 
> (nobse@backports.org) (gcc version 4.1.2 20061115 (prerelease) (Debian 
> 4.1.1-21)) #1 SMP Mon Nov 12 17:53:18 UTC 2007
> 
> ...this got written to syslog when I switched on my monitor, a DELL 
> 2007WFPb, which contains a USB hub (yes this is silly) which is 
> connected to a rear USB connector of the PC:
> 
> Feb 14 09:42:54 pcnau kernel: usb 7-5: new high speed USB device using 
> ehci_hcd and address 5
> Feb 14 09:42:54 pcnau kernel: usb 7-5: configuration #1 chosen from 1 choice
> Feb 14 09:42:54 pcnau kernel: hub 7-5:1.0: USB hub found
> Feb 14 09:42:54 pcnau kernel: hub 7-5:1.0: 4 ports detected
> Feb 14 09:46:14 pcnau kernel: rtc: lost some interrupts at 2048Hz.
> Feb 14 09:46:28 pcnau last message repeated 11 times
> Feb 14 09:46:31 pcnau kernel: printk: 8 messages suppressed.
> Feb 14 09:46:31 pcnau kernel: rtc: lost some interrupts at 2048Hz.
> Feb 14 09:46:40 pcnau kernel: printk: 20 messages suppressed.
> Feb 14 09:46:40 pcnau kernel: rtc: lost some interrupts at 2048Hz.
> Feb 14 09:47:03 pcnau kernel: printk: 1 messages suppressed.
> Feb 14 09:47:03 pcnau kernel: rtc: lost some interrupts at 2048Hz.
> Feb 14 09:47:04 pcnau last message repeated 4 times
> Feb 14 09:47:11 pcnau kernel: printk: 13 messages suppressed.
> Feb 14 09:47:11 pcnau kernel: rtc: lost some interrupts at 2048Hz.
> Feb 14 09:47:11 pcnau kernel: printk: 6 messages suppressed.
> Feb 14 09:47:11 pcnau kernel: rtc: lost some interrupts at 2048Hz.
> Feb 14 09:47:30 pcnau kernel: printk: 13 messages suppressed.
> Feb 14 09:47:30 pcnau kernel: rtc: lost some interrupts at 2048Hz.
> Feb 14 09:47:32 pcnau last message repeated 3 times
> Feb 14 09:47:43 pcnau kernel: printk: 18 messages suppressed.
> Feb 14 09:47:43 pcnau kernel: rtc: lost some interrupts at 2048Hz.
> Feb 14 09:49:16 pcnau kernel: rtc: lost some interrupts at 2048Hz.
> Feb 14 09:49:16 pcnau kernel: rtc: lost some interrupts at 2048Hz.

curious.  I wonder why you're using the rtc in the first place.

> I can try the same thing with acpi_osi=Linux if it would help.

it would help if you notice a difference.
my guess is that it will not make a difference and this issue
is related to rtc and USB and not related to ACPI.

The possible exception might be SMM related to USB,
which is always really difficult to debug.

> I could  
> also run a speed test for writing to USB flash disks with and without 
> acpi_osi=Linux if this would be of help. Other than that, I don't know 
> what exactly to look for (and I have not run in acpi_osi=Linux mode, 
> yet). Can you recommend a specific test to run?

well, asside from trying suspend and hibernate, see if USB works
the same way in both modes.  yes, dumping data to a flash drive
sounds like a good test.

thanks,
-Len

