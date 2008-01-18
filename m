From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode compal fl91
Date: Fri, 18 Jan 2008 16:51:03 -0500
Message-ID: <200801181651.04007.lenb@kernel.org>
References: <47572B1A.2030503@openweb-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43514 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758568AbYARVvW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 16:51:22 -0500
In-Reply-To: <47572B1A.2030503@openweb-berlin.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Clemens Heimlich <heimlich@openweb-berlin.de>
Cc: linux-acpi@vger.kernel.org

With 2.6.22, did you notice any functional difference with "acpi_osi=!Linux"?

(or since the default changed at 2.6.23, with 2.6.23 or later
 do you notice any difference with "acpi_osi=Linux"?)

Please send me the output from acpidump.
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len
---
BIOS Information
        Vendor: COMPAL
        Version: 1.12
        Release Date: 08/29/2007
        Address: 0xE6100
        Runtime Size: 106240 bytes
        ROM Size: 1024 kB
        Characteristics:
...
        BIOS Revision: 49.49
        Firmware Revision: 49.49

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: -
        Product Name: N/A
        Version: N/A
        Serial Number: N/A
        UUID: D1E07F78-0869-11DC-AB91-0016D4DB90E0
        Wake-up Type: Power Switch
        SKU Number: Compal
        Family: Compal

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: -
        Product Name: IFL91
        Version: IFT00
        Serial Number: N/A
