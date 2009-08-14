From: martin stanley-jones <msj@cban.com>
Subject: linux dmidecode
Date: Fri, 14 Aug 2009 16:54:18 +1000
Message-ID: <200908141654.18701.msj@cban.com>
Reply-To: msj@cban.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:1413 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718AbZHNGy3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2009 02:54:29 -0400
Received: by wa-out-1112.google.com with SMTP id j5so278236wah.21
        for <linux-acpi@vger.kernel.org>; Thu, 13 Aug 2009 23:54:30 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

At the system prompt I typed 'dmesg" and found within the listing the 
following items:

...
...

[   21.627126] ACPI: EC: Look up EC in DSDT
[   21.627725] ACPI: EC: GPE=0x19, ports=0x66, 0x62
[   21.664043] ACPI: System BIOS is requesting _OSI(Linux)
[   21.664045] ACPI: Please test with "acpi_osi=!Linux"
[   21.664046] Please send dmidecode to linux-acpi@vger.kernel.org
[   2.....


At a system prompt, the test resulted in the following:

msj@lptp:~$ acpi_osi=!Linux
bash: !Linux: event not found
msj@lptp:~$


Machine is a Lenovo 3000 C200 operating with Kubuntu 7.1
top few lines of dmesg are :

[    0.000000] Linux version 2.6.22-16-generic (buildd@rothera) (gcc version 
4.1.3 20070929 (prerelease) (Ubuntu 4.1.2-16ubuntu2)) #1 SMP Thu Apr 2 
01:27:50 GMT 2009 (Ubuntu 2.6.22-16.62-generic)

I will be updating to Kubuntu 9.04 shortly.

martin Stanley-Jones 
