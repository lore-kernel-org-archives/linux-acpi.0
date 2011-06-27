From: Bryce Nesbitt <bryce2@obviously.com>
Subject: Intel DX58SO2 suspends fine: but only for the first few hours
Date: Mon, 27 Jun 2011 13:54:04 -0700
Message-ID: <4E08EDEC.7010504@obviously.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outy.internet-mail-service.net ([216.240.47.248]:47843 "EHLO
	out-0.mx.aerioconnect.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754282Ab1F0VB3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 27 Jun 2011 17:01:29 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I have an Intel DX58SO2 based desktop which works great with WOL, and 
also passes the Suspend/Resume test at
https://wiki.ubuntu.com/KernelTeam/SuspendResumeTesting
But fails if left suspended for somewhere between 4 and 10 hours.
When resumed after this delay the machine hard boots, usually leaving 
the USB
keyboard dead as well.

# cat /proc/cmdline
BOOT_IMAGE=/vmlinuz-2.6.38-8-generic 
root=UUID=8a67d411-9750-46e4-8a53-b2059e5a4eeb ro quiet 
splash,acpi_sleep=nonvs

# cat /etc/initramfs-tools/conf.d/resume
RESUME=UUID=86acb365-d5a4-4249-a28c-5ab4b694181b

# uname -a
Linux ubuntu 2.6.38-8-generic #42-Ubuntu SMP Mon Apr 11 03:31:24 UTC 
2011 x86_64 x86_64 x86_64 GNU/Linux

# dmidecode
SMBIOS 2.5 present.
Processor Information
     Socket Designation: CPU 1
     Manufacturer: Intel(R) Corporation
     Version: Intel(R) Xeon(R) CPU           E5607  @ 2.27GHz
     (ECC Memory is installed but apparently not actually working)

BIOS Information
     Vendor: Intel Corp.
     Version: SOX5820J.86A.0779.2011.0406.1511
     Release Date: 04/06/2011
     Characteristics:
         ACPI is supported
     BIOS Revision: 0.0
     Firmware Revision: 0.0

Handle 0x0007, DMI type 2, 20 bytes
Base Board Information
     Manufacturer: Intel Corporation
     Product Name: DX58SO2
     Version: AAG10925-205
     Features:
         Board is a hosting board
         Board is replaceable

-------------------------------------------------------------------------------------------------------
Where can I go next?  The builder of this machine claims that Linux 
suspend/resume has been "been basically a crap-shoot for years", and 
thus they refuse to even test it out properly.

If I shop for a new motherboard, where other than
https://wiki.ubuntu.com/KernelTeam/SuspendResumeTesting/Feedback
Can I get feedback on which models are most likely to act fine under 
Suspend/Resume/Wake on Lan?
