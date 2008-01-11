From: Linda Walsh <lkml@tlinx.org>
Subject: ACPI error message; ACPI appears to be disabled by error.
Date: Thu, 10 Jan 2008 20:11:27 -0800
Message-ID: <4786EC6F.8070209@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ishtar.tlinx.org ([64.81.245.74]:43865 "EHLO ishtar.tlinx.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755739AbYAKEL1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 10 Jan 2008 23:11:27 -0500
Received: from [192.168.3.11] (Athena [192.168.3.11])
	by ishtar.tlinx.org (8.13.3/8.12.10/SuSE Linux 0.7) with ESMTP id m0B4BR8c005288
	for <linux-acpi@vger.kernel.org>; Thu, 10 Jan 2008 20:11:27 -0800
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


I've had ACPI "work" before in the sense that the system booted properly
(though I don't know that everything was correct as I've seemed to have 
infrequent system hangs -- not sure if related to ACPI or not, but I don't
seem to get them when it is disabled.  Odd thing is that with it enabled,
system may run for a day or few.  With a more recent kernel, ACPI is 
yielding
an error on boot which seems to "disable" any further ACPI processing.
The error (and few lines above & below)

CI->APIC IRQ transform: 0000:02:06.0[A] -> IRQ 18
PCI->APIC IRQ transform: 0000:02:09.0[A] -> IRQ 17
PCI->APIC IRQ transform: 0000:02:0a.0[A] -> IRQ 18
PCI: Cannot allocate resource region 4 of device 0000:00:07.1
ACPI Exception (utmutex-0263): AE_BAD_PARAMETER, Thread EFFC2000 could 
not acquire Mutex [3] [20070126]
pnp: 00:00: ioport range 0x800-0x83f has been reserved
pnp: 00:00: ioport range 0x850-0x85f has been reserved
pnp: 00:00: iomem range 0x0-0x9ffff could not be reserved


I was wondering if the error indicates a "problem" in the system's
ACPI 'bios'(?).  After ACPI fails, the system goes on to boot
seemingly 'normally'...

Thanks,
Linda
