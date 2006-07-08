From: Philip Walden <pwaldenlinux@pacbell.net>
Subject: acpi stopped working for me sometime after 2.6.11
Date: Sat, 08 Jul 2006 12:06:10 -0700
Message-ID: <44B00222.2080700@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:44754 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP
	id S1030231AbWGHTGL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 8 Jul 2006 15:06:11 -0400
Received: from [192.168.1.140] (adsl-75-20-217-21.dsl.pltn13.sbcglobal.net [75.20.217.21])
	by ylpvm01.prodigy.net (8.13.7 out spool5000 dk/8.13.7) with ESMTP id k68J698o012279
	for <linux-acpi@vger.kernel.org>; Sat, 8 Jul 2006 15:06:10 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I just upgraded from RH9 to FC4. The the distribution CDs I used 
provided 2.6.11-1.1369_FC4.

The upgrade was successful and I was happy to see ACPI actually power 
off my machine when I did a shut down. Something I had missed when I 
went from XP to RH9.

My next step was to upgrade using yum. This jumped me to 
2.6.17-1.2139_FC4. ACPI was now disabled in boot up.

After several days of poking araound doing before and after compares I 
found something that works.

I added an acpi=force kernel parameter. ACPI loaded and shutdown now 
powers off the box.

Yeah!

I spotted the work-around in another thread where it is used to get 
around the ACPI BIOS age cutoff.

Not sure what happen after 2.6.11, though.

Does anyone care what happened? Should this be reported as a bug?

The motherboard, I am not sure what it is. The box is a HP Pavilion 
9695C. The closest I can get to a specification for the motherboard is: 
http://h10025.www1.hp.com/ewfrf/wc/genericDocument?cc=us&docname=bph05885&lc=en&jumpid=reg_R1002_USEN  
Generically described as "Motherboard and Jumper Settings for Systems 
with AMD Athlon Processor and an AMD Irongate (AMD-751) Chipset".

Here is a dmesg excerpt showing the dissabling message.

Jul  3 09:15:43 walden4 kernel: klogd 1.4.1, log source = /proc/kmsg 
started.
Jul  3 09:15:43 walden4 kernel: Linux version 2.6.17-1.2139_FC4 
(bhcompile@hs20-bc1-5.build.redhat.com) (gcc version 4.0.2 20051125 (Red 
Hat 4.0.2-8)) #1 Fri Jun 23 20:56:41 EDT 2006
Jul  3 09:15:43 walden4 kernel: BIOS-provided physical RAM map:
Jul  3 09:15:43 walden4 kernel:  BIOS-e820: 0000000000000000 - 
000000000009f800 (usable)
Jul  3 09:15:43 walden4 kernel:  BIOS-e820: 000000000009f800 - 
00000000000a0000 (reserved)
Jul  3 09:15:43 walden4 kernel:  BIOS-e820: 00000000000e9400 - 
0000000000100000 (reserved)
Jul  3 09:15:43 walden4 kernel:  BIOS-e820: 0000000000100000 - 
000000000fff0000 (usable)
Jul  3 09:15:43 walden4 kernel:  BIOS-e820: 000000000fff0000 - 
000000000ffffc00 (ACPI data)
Jul  3 09:15:43 walden4 kernel:  BIOS-e820: 000000000ffffc00 - 
0000000010000000 (ACPI NVS)
Jul  3 09:15:43 walden4 kernel:  BIOS-e820: 00000000fffc0000 - 
0000000100000000 (reserved)
Jul  3 09:15:43 walden4 kernel: 0MB HIGHMEM available.
Jul  3 09:15:43 walden4 kernel: 255MB LOWMEM available.
Jul  3 09:15:43 walden4 kernel: Using x86 segment limits to approximate 
NX protection
Jul  3 09:15:43 walden4 kernel: DMI not present or invalid.
Jul  3 09:15:43 walden4 kernel: ACPI: Disabling ACPI support

