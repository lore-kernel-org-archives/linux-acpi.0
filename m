From: Len Brown <lenb@kernel.org>
Subject: Re: A couple of things about ACPI
Date: Tue, 18 Sep 2007 11:12:14 -0400
Message-ID: <200709181112.14834.lenb@kernel.org>
References: <200709181610.52771.StormByte@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51995 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757980AbXIRPMg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2007 11:12:36 -0400
In-Reply-To: <200709181610.52771.StormByte@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Carlos Manuelda <stormbyte@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday 18 September 2007 10:10, David Carlos Manuelda wrote:
> I've seen in dmesg some things I wanted to comment to you.
> 
> First of all, I've seen a message at boot:
> 
> ACPI: System BIOS is requesting _OSI(Linux)
> ACPI: Please test with "acpi_osi=!Linux"
> Please send dmidecode to linux-acpi@vger.kernel.org
> 
> I've tested with that boot option, and I see exactly same message (maybe a 
> bug?)

thanks, i'll look at this.
i also need to simplify it so that it just prints out the dmi into
right in the dmesg instead of asking for dmidecode....

we can tell exactly what this does if you open up a bug report
and attach the output from acpidump.
So far, i've seen OSI(Linux) used only for video re-post on resume.

> dmidecode is attached.
> =========================
> I've seen:
> ACPI: BIOS bug: multiple APIC/MADT found, using 0
> ACPI: If "acpi_apic_instance=2" works better, notify 
> linux-acpi@vger.kernel.org
> Testing with that option, I see no difference, except the message change, now 
> says:
> ACPI: BIOS bug: multiple APIC/MADT found, using 2
> ACPI: If "acpi_apic_instance=0" works better, notify 
> linux-acpi@vger.kernel.org
> =========================
> I don't know what it is exactly, but I mail you with information requested.
> 
> Please let me know if it is useful, and if you need more info, just tell me.

again, the acpidump will tell us the two table contents and we can compare.
when they are very broken, usually an IRQ is mis-routed (could tell from
both /proc/interrupts) or not all the processors are enumerated.


> This is a Samsung R70 laptop, intel core2 duo 1800, 2GB ram 'Santa Rosa'.
> 
> By the way, info of dmidecode is not 100% correct, I don't know why. This is 
> what is not correct:
> 
> extract of dmidecode.txt:
> ====================
> Handle 0x000B, DMI type 10, 6 bytes
> On Board Device Information
>         Type: Sound
>         Status: Disabled (***!!! Sound is enabled and fully functional)
>         Description: HD-Audio

DMI info is generally typed in by hand, and it is common for it
to be full of errors.

thanks,
-Len
