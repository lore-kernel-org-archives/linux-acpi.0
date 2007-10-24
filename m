From: John Sigler <linux.kernel@free.fr>
Subject: halt and poweroff do not shut the system down
Date: Wed, 24 Oct 2007 10:17:20 +0200
Message-ID: <471EFF90.5070606@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:46782 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbXJXIRV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Oct 2007 04:17:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, robert.moore@intel.com

Hello,

When I run 'halt' or 'poweroff' (sysvinit-2.86) the kernel prints:

Halting.
Shutdown: hdc
ACPI: PCI interrupt for device 0000:01:05.0 disabled
ACPI: PCI interrupt for device 0000:01:04.0 disabled
ACPI: PCI interrupt for device 0000:01:03.0 disabled
ACPI: PCI interrupt for device 0000:01:02.0 disabled
Power down.
acpi_power_off called

But the system does not shut down. (The fans keep spinning, the LEDs
keep shining, the integrated LCD keeps displaying.) Basically, the 
motherboard is still providing power to every component, as if the power 
supply had refused to stop.

I followed the instructions given here:
http://bugzilla.kernel.org/show_bug.cgi?id=6431

cf. http://bugzilla.kernel.org/show_bug.cgi?id=9148

The system is an FWA-3140-CE:
http://advantech.com/products/1U-Rackmount-Intel-Pentium-4Processor-based-Platform-with-4PCI-LAN-Ports-2-PCI-Expansion-Slots/mod_1-23A2W4.aspx

The manufacturer is unwilling to help because they don't support Linux, 
and claim it is a software issue. I will ask them whether Windows is 
able to properly shut the system down.

What can I do to help fix the problem?

Regards.

