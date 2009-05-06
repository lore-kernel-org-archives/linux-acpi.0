From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: System overloaded with ACPI interrupts
Date: Wed, 06 May 2009 13:48:21 +0800
Message-ID: <1241588901.15284.105.camel@rzhang-dt>
References: <3337c250905040300v3279a48evb347f0b037bba85f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18364 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbZEFFrw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 6 May 2009 01:47:52 -0400
In-Reply-To: <3337c250905040300v3279a48evb347f0b037bba85f@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christopher HORLER <cshorler@googlemail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

hi,

please try a recent vanilla kernel and see if it's reproducible. 2.6.29
would be a good choice.

if the problem still exists in 2.6.29 kernel, please attach the output
of dmesg and "grep . /sys/firmware/acpi/interrupts/*" after the
interrupt storm occurs.
please also attach the acpidump of this laptop.

it would be great of you can open a new bug report at
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI
and attach all the info there.

thanks,
rui


On Mon, 2009-05-04 at 18:00 +0800, Christopher HORLER wrote:
> Hello,
> 
> I think I'm experiencing some kind of ACPI issue, I haven't been able
> to identify a series of actions that causes this.
> 
> I first noticed the problem when looking at 'top' - seeing kacpi at
> the top of the process list (followed by kacpi_notify).
> I have powertop installed, the dump is attached - acpi interrupts seem
> to be excessive.
> 
> The computer is perhaps not the best machine:  Arima M620-DC.  I think
> the same chassis may be used by a number of other manufacturers.
> 
> The system does not boot in this state - it occurs rather
> unpredictably after high CPU loads.  I had thought this was a CPU
> temperature issue and replaced the thermal paste of the heatsink,
> which improved matters.
> 
> I have also blacklisted the following modules:
> blacklist i2c_i801
> blacklist yenta_socket
> 
> The kernel reports a conflict between ACPI SBUS and i2c_i801.
> I forget why I disabled yenta_socket, but I don't use the card reader.
> 
> The OS is openSuSE 11.1 with the 2.6.27.21-0.1-default kernel installed.
> 
> I've also tried booting the system with acpi=noirq.  This gives a 'irq
> 5: nobody cared' and the wireless card (ipw2200) then doesn't work.
> 
> My normal kernel command line contains the following parameters:
> hpet=force lapic vga=0x317
> This is what all the attached logs are generated from and when my
> system functions with all devices working.
> 
> I have also disassembled the ACPI tables.  I can post them if required?
> 
> Hopefully someone can suggest a temporary solution or a permanent one?
> 
> Thanks,
> Chris

