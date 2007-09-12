From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: 2.6.23-rc5 hangs on boot, apparently when initializing the EC
Date: Thu, 13 Sep 2007 01:49:41 +0400
Message-ID: <46E85EF5.7050306@gmail.com>
References: <46E6F30C.5040500@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:52034 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594AbXILVts (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Sep 2007 17:49:48 -0400
Received: by ug-out-1314.google.com with SMTP id z38so311667ugc
        for <linux-acpi@vger.kernel.org>; Wed, 12 Sep 2007 14:49:47 -0700 (PDT)
In-Reply-To: <46E6F30C.5040500@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Kernel ACPI Mailing List <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Chuck,

Please try last patch from bug 8709 (bugzilla.kernel.org), if it does not help, please open new bug, 
and submit acpidump and dmesg outputs.

Thanks,
Alex.

 
Chuck Ebbert wrote:
> 2.6.23-rc5-git1 hangs here, just before EC initialization.
> Pressing the power button briefly makes it continue, then the
> EC gets detected twice:
> 
> 
> ACPI: bus type pci registered
> PCI: Using configuration type 1
> 
> ------------------ hangs here, press power button --------------------
> 
> ACPI: EC: Look up EC in DSDT
> ACPI: EC: GPE = 0x10, I/O: command/status = 0x66, data = 0x62
> ACPI: System BIOS is requesting _OSI(Linux)
> ACPI: If "acpi_osi=Linux" works better,
> Please send dmidecode to linux-acpi@vger.kernel.org
> ACPI: Interpreter enabled
> ACPI: (supports S0 S3)
> ACPI: Using IOAPIC for interrupt routing
> ACPI: EC: GPE = 0x10, I/O: command/status = 0x66, data = 0x62
> ACPI: PCI Root Bridge [PCI0] (0000:00)
> PCI: Transparent bridge - 0000:00:10.0
> ...
> 
> 
> System is an HP TX1000 notebook with AMD Turion X2 processor,
> running the x86_64 kernel. (And acpi_osi="Linux" doesn't seem to
> make any difference.)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

