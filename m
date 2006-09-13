From: keith mannthey <kmannth@us.ibm.com>
Subject: [Bug] 2.6.18-rc6-mm2 i386 trouble finding RSDT in
	get_memcfg_from_srat
Date: Tue, 12 Sep 2006 19:18:14 -0700
Message-ID: <1158113895.9562.13.camel@keithlap>
Reply-To: kmannth@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:19593 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751500AbWIMCSQ
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 12 Sep 2006 22:18:16 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>

Hello,
  I am trying to use i386 SRAT and it is not working.  The srat code
(get_memcfg_from_srat) needs to map in the SRAT table during boot to see
all the numa information.  It gets the RSDP just fine but when it looks
up the RSDT the header is empty (I tried to print out RSDT header and it
was empty) and it exits :( 

Excerpts from my boot log.... 

get_memcfg_from_srat: assigning address to rsdp
RSD PTR  v0 [IBM   ]
ACPI: RSDT signature incorrect
failed to get NUMA memory information from SRAT table
NUMA - single node, flat memory mode
Node: 0, start_pfn: 0, end_pfn: 156

Something is wrong.

A while later in the boot I see. 

Using APIC driver default
ACPI: RSDP (v000 IBM                                   ) @ 0x000fdfc0
ACPI: RSDT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xeff9c2c0
ACPI: FADT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xeff9c240
ACPI: MADT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xeff9c0c0
ACPI: SRAT (v001 IBM    SERVIGIL 0x00001000 IBM  0x45444f43) @ 0xeff9bf40
ACPI: DSDT (v001 IBM    SERVIGIL 0x00001000 INTL 0x02002025) @ 0x00000000
 
Looks like the RSDT table it there.... 

I haven't booted i386 numa Summit in a while and was wondering if anyone
had any ideas?

Thanks,
  Keith 

