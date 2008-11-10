From: Blue Raven 67 <blueraven67@gmail.com>
Subject: acpi information
Date: Mon, 10 Nov 2008 20:55:26 +0100
Message-ID: <491891AE.6020303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:40232 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420AbYKJTzb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Nov 2008 14:55:31 -0500
Received: by ey-out-2122.google.com with SMTP id 6so1017756eyi.37
        for <linux-acpi@vger.kernel.org>; Mon, 10 Nov 2008 11:55:29 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


Hi All,

Looking around in the dmesg output of my Acer PC I found this messages.
I like to help the Linux community, so here is the DMI info.

[    0.620789] ACPI: EC: Look up EC in DSDT
[    0.623436] ACPI: BIOS _OSI(Linux) query ignored
[    0.623438] ACPI: DMI System Vendor: ACER
[    0.623440] ACPI: DMI Product Name: Aspire M5640
[    0.623441] ACPI: DMI Product Version: R01-B2
[    0.623442] ACPI: DMI Board Name: MCP73PV
[    0.623444] ACPI: DMI BIOS Vendor: American Megatrends Inc.
[    0.623445] ACPI: DMI BIOS Date: 05/23/2008
[    0.623446] ACPI: Please send DMI info above to 
linux-acpi@vger.kernel.org
[    0.623448] ACPI: If "acpi_osi=Linux" works better, please notify   
[    0.630986] ACPI: Interpreter enabled
[    0.630988] ACPI: (supports S0 S1 S3 S4 S5)
[    0.631006] ACPI: Using IOAPIC for interrupt routing

I'm currently using Ubuntu 8.10 with a standard  2.6.27-7-generic kernel 
on this Acer PC.
But that wasn't without some troubles.  This motherboard seems to quite 
tricky on the ACPI part.

For example : first try with the 2.6.27-7 kernel I got a lot of boot 
errors of the following kind :
    ACPI : Expecting a [Reference] package element, found type C
I don't know what it means, but the result was nothing less then a 
crashing and beeping PC.

Fortunately I could select an older 2.6.24-21-generic kernel with grub 
and this one booted correctly.

Then after trial and error I managed to boot with the 2.6.27-7 kernel 
only after disabling the "acpi southbridge extensions" in the BIOS.

If this information can help someone or there is an explanation for the 
above behaviour ... always interested to hear about it.
Or if I can help with more info ... send me a mail.

Best regards,

Wim

