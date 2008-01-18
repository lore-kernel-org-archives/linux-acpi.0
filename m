From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode Compaq Presario C500 (C552US)
Date: Fri, 18 Jan 2008 16:36:53 -0500
Message-ID: <200801181636.53897.lenb@kernel.org>
References: <1198084299.10729.17.camel@headhunter.avsa.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45421 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138AbYARVhK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 16:37:10 -0500
In-Reply-To: <1198084299.10729.17.camel@headhunter.avsa.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jesse Burt <genecide@comcast.net>
Cc: linux-acpi@vger.kernel.org

On Wednesday 19 December 2007 12:11, Jesse Burt wrote:
> As per the kernel message, attached is the output of dmidecode for this
> machine.
> Adding acpi_osi=!Linux causes this to be logged:
> ACPI: Disabled _OSI(Linux)
>  (at least I think it does; I don't remember seeing it before)
> I'm not sure what other effects, if any, this is supposed to have?

it may be a NOP -- I'll be able to confirm w/ your acpidump output.

> The ACPI driver also complains on boot:
> 
> ACPI: BIOS bug: multiple APIC/MADT found, using 0
> ACPI: If "acpi_apic_instance=2" works better, notify
> linux-acpi@vger.kernel.org

i can double check this in your acpidump output too.
The duplicate may be identical, or Linux may be immune
to the differences (depends what they are)

not sign of high quality BIOS, this...

> This kernel option doesn't have any perceptible effect on anything other
> than to say the same thing but to try to use acpi_apic_instance=0 :)
> (IMO this laptop has more than its fair share of problems in Linux, or
> Ubuntu at least; no particularly exotic hardware or anything. I don't
> know how much ACPI-related stuff could be affecting this?)
> Please don't hesitate to ask for any more information about this laptop!

System Information
	Manufacturer: Hewlett-Packard
	Product Name: Presario C500 (RZ342UA#ABA)       
	Version: F.13
	Serial Number: CND709290W
	UUID: 07285F90-C697-11DB-B067-0016D4C0FDDB
	Wake-up Type: Power Switch
	SKU Number: RZ342UA#ABA
	Family: 103C_5335KV

Please send me the output from acpidump.
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len
