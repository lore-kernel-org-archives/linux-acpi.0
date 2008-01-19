From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - Dell Inspiron 1501
Date: Fri, 18 Jan 2008 22:55:28 -0500
Message-ID: <200801182255.28510.lenb@kernel.org>
References: <fc8i45$fh4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:39223 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760572AbYASDzm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 22:55:42 -0500
In-Reply-To: <fc8i45$fh4$1@sea.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lexington Luthor <lexington.luthor@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday 12 September 2007 07:20, Lexington Luthor wrote:
> Hi,
> 
> Running vanilla 2.6.22.6 on a Dell Inspiron 1501 (w/ latest BIOS 
> update), the kernel says:
> ...
> Sep 12 11:49:27 [kernel] ACPI: System BIOS is requesting _OSI(Linux)
> Sep 12 11:49:27 [kernel] ACPI: Please test with "acpi_osi=!Linux"
> Sep 12 11:49:27 [kernel] Please send dmidecode to linux-acpi@vger.kernel.org
> Sep 12 11:49:27 [kernel] ACPI: Interpreter enabled
> Sep 12 11:49:27 [kernel] ACPI: Using IOAPIC for interrupt routing
> ...
> 
> The machine itself is stable under load (aside from wifi network drops, 
> but thats a known bcm43xx tx power problem), aside from an occasional 
> message in dmesg saying stuff like:
> Sep 12 07:21:45 [kernel] APIC error on CPU0: 00(40)
> Sep 12 07:21:48 [kernel] APIC error on CPU1: 00(40)
> Sep 12 07:28:27 [kernel] APIC error on CPU0: 40(40)
> Sep 12 07:28:46 [kernel] APIC error on CPU1: 40(40)

I think you can ignore them, just like you can ignore
strange engine noises from inexpensive autos:-)

System Information
        Manufacturer: Dell Inc.
        Product Name: Inspiron 1501 
        Version: Not Specified                   
        Serial Number: HR9ZX2J
        UUID: 44454C4C-5200-1039-805A-C8C04F58324A
        Wake-up Type: Power Switch
        SKU Number: Not Specified
        Family: Not Specified

Handle 0x0003, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: Dell Inc.
        Product Name: 0UW744

Thanks for the dmidecode output.

Do you notice any functional difference when booting with

"acpi_osi=Linux"        (default for 2.6.22 and earlier)
vs.
"acpi_osi=!Linux"       (default for 2.6.23 and later)

Also, please send me the output from acpidump.

thanks,
-Len

ps
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php
