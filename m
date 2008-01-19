From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode and bios bug (w/ attachment) - Compaq Presario C571NR
Date: Fri, 18 Jan 2008 23:12:29 -0500
Message-ID: <200801182312.29462.lenb@kernel.org>
References: <183580.46909.qm@web52406.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:47473 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761599AbYASEMn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 23:12:43 -0500
In-Reply-To: <183580.46909.qm@web52406.mail.re2.yahoo.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: go81816@yahoo.com
Cc: linux-acpi@vger.kernel.org

On Saturday 22 September 2007 09:50, Geoffrey Opland wrote:
> 
>  On boot of my Compaq Presario C571NR running LFS with kernel 2.6.22.1 I
>  receive the following messages:
>  
>  Sep 22 08:38:07 localhost kernel: ACPI: BIOS bug: multiple APIC/MADT
>  found, using 0
>  Sep 22 08:38:07 localhost kernel: ACPI: If "acpi_apic_instance=2" works
>  better, notify linux-acpi@vger.kernel.org
>    << and >>
>  Sep 22 08:38:07 localhost kernel: ACPI: System BIOS is requesting
>  _OSI(Linux)
>  Sep 22 08:38:07 localhost kernel: ACPI: Please test with
>  "acpi_osi=!Linux"
>  Sep 22 08:38:07 localhost kernel: Please send dmidecode to
>  linux-acpi@vger.kernel.org
>  
>  I see no obvious usability differences with acpi_apic_instance=2, is
>  there
>  something specific I can check for?

interrupts to devices would not work.
but i can check if this is a NOP with your acpidump output.

>  I do have intermittent suspend 
>  problems, but I'm not sure this flag has any effect on suspend code.
>  
>  Also, attached is the dmidecode output as requested.
> 
System Information
	Manufacturer: Hewlett-Packard
	Product Name: Presario C500 (GF572UA#ABA)       
	Version: F.24
	Serial Number: CND7210DFT
	UUID: 691A0814-F4F6-11DB-896B-0016D4ED0B0E
	Wake-up Type: Power Switch
	SKU Number: GF572UA#ABA
	Family: 103C_5335KV

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Hewlett-Packard 
	Product Name: 30C6
Thanks for the dmidecode output.

Do you notice any functional difference when booting with

"acpi_osi=Linux"        (default for 2.6.22 and earlier)
vs.
"acpi_osi=!Linux"       (default for 2.6.23 and later)

Please send me the output from acpidump.

I've got this box in the blacklist already b/c
similar machines showed that OSI(Linux) on them is a NOP.

thanks,
-Len

ps
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

