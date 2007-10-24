From: John Sigler <linux.kernel@free.fr>
Subject: Re: halt and poweroff do not shut the system down
Date: Wed, 24 Oct 2007 17:35:10 +0200
Message-ID: <471F662E.9090502@free.fr>
References: <471EFF90.5070606@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:41680 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752206AbXJXPfL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Oct 2007 11:35:11 -0400
In-Reply-To: <471EFF90.5070606@free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, robert.moore@intel.com

John Sigler wrote:

> When I run 'halt' or 'poweroff' (sysvinit-2.86) the kernel prints:
> 
> Halting.
> Shutdown: hdc
> ACPI: PCI interrupt for device 0000:01:05.0 disabled
> ACPI: PCI interrupt for device 0000:01:04.0 disabled
> ACPI: PCI interrupt for device 0000:01:03.0 disabled
> ACPI: PCI interrupt for device 0000:01:02.0 disabled
> Power down.
> acpi_power_off called
> 
> But the system does not shut down. (The fans keep spinning, the LEDs
> keep shining, the integrated LCD keeps displaying.) Basically, the
> motherboard is still providing power to every component, as if the
> power supply had refused to stop.

I noticed the following message at boot:

* The chipset may have PM-Timer Bug. Due to workarounds for a bug,
* this clock source is slow. If you are sure your timer does not have
* this bug, please use "acpi_pm_good" to disable the workaround

Is there any chance that the two issues are connected?
(It seems very unlikely.)

How can I tell whether the bug is fixed in my south bridge or not?
http://linux.kernel.free.fr/halt/lspci.txt

Regards.
