From: Ingo Humann <ingo_humann@gmx.de>
Subject: DMI information for Dell Latitude E4300
Date: Tue, 09 Dec 2008 15:32:38 +0100
Message-ID: <493E8186.6020705@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:56008 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752918AbYLIOcl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Dec 2008 09:32:41 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello!

I quote this from the output of the dmesg command:

[    0.496724] ACPI: EC: Look up EC in DSDT
[    0.496909] ACPI: BIOS _OSI(Linux) query ignored
[    0.496912] ACPI: DMI System Vendor: Dell Inc.
[    0.496915] ACPI: DMI Product Name: Latitude E4300
[    0.496918] ACPI: DMI Product Version:
[    0.496920] ACPI: DMI Board Name: 0MR506
[    0.496922] ACPI: DMI BIOS Vendor: Dell Inc.
[    0.496924] ACPI: DMI BIOS Date: 10/10/2008
[    0.496927] ACPI: Please send DMI info above to 
linux-acpi@vger.kernel.org
[    0.496930] ACPI: If "acpi_osi=Linux" works better, please notify 
linux-acpi@vger.kernel.org

The kernel option acpi_osi=Linux works better for me. When I use it, I 
can use suspend to ram without complications. Without this kernel option 
the computer freezes after awaking.

More informations about my Linux system:

uname -a:
Linux latitude 2.6.27-9-generic #1 SMP Thu Nov 20 22:15:32 UTC 2008 
x86_64 GNU/Linux

/etc/issue:
Ubuntu 8.10

Other kernel options:
i8042.reset vga=0x0362


Regards from Germany
Ingo Humann
