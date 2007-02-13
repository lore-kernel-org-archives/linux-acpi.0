From: Len Brown <lenb@kernel.org>
Subject: Re: Enabling the IO-APIC on an Abit KT7A motherboard
Date: Tue, 13 Feb 2007 00:04:39 -0500
Message-ID: <200702130004.39837.lenb@kernel.org>
References: <000a01c74dff$ad09ac40$fd0ba8c0@lancaster.beardandsandals.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58383 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161016AbXBMFF7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 13 Feb 2007 00:05:59 -0500
In-Reply-To: <000a01c74dff$ad09ac40$fd0ba8c0@lancaster.beardandsandals.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roger James <roger@beardandsandals.co.uk>
Cc: linux-acpi@vger.kernel.org

On Sunday 11 February 2007 12:11, Roger James wrote:
> I have been trying to get the IO-APIC on an Abit KT7A motherboard recognised
> by the kernel (2.6.19.2). This is of course a single processor system. The
> kernel has the CONFIG_X86_UP_APIC, CONFIG_X86_UP_IOAPIC,
> CONFIG_X86_LOCAL_APIC, and CONFIG_X86_IOAPIC options set.
> 
> The reason I am trying this is in order to debug a system lock-up using the
> nmi-watchdog facility. It looks like the lock up is caused by a hlt
> instruction as the lapic based nmi-watchdog does not catch it.
> 
> I have put some debug in the various bits of code that are related to the
> initialisation of the io-apic and its seems it is not being detected because
> the bios does not supply an APIC table so..
> 
> acpi_table_parse(ACPI_APIC, acpi_parse_madt);
> 
> returns 0 and the IOAPIC is never found.

Check if there is a BIOS SETUP option to enable the IO-APIC.

No, you can't manufacture ACPI support for an IOAPIC on a system
where the BIOS doesn't tell the OS about it via ACPI tables.

Alternatively, you can boot with "acpi=off", and if the board has MPS,
that will enable the IOAPIC (assuming the HW has one).

If neither of these work, it means your board vendor intentionally
did not enable the IOAPIC.

I don't really understand your motivation for enabling the IOAPIC above,
but it is true that if it is supported and works, you generally want to
take advantage of it to reduce interrupt sharing.

cheers,
-Len
