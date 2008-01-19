From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode for Lenovo N100 3000 0768
Date: Fri, 18 Jan 2008 22:08:51 -0500
Message-ID: <200801182208.51610.lenb@kernel.org>
References: <50d9f33a0708111300x3c5e4e23n3d1249539113ece8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:60703 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759811AbYASDJN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 22:09:13 -0500
In-Reply-To: <50d9f33a0708111300x3c5e4e23n3d1249539113ece8@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Neil Wilson <neil@aldur.co.uk>
Cc: linux-acpi@vger.kernel.org


Handle 0x0001, DMI type 1, 27 bytes
System Information
	Manufacturer: LENOVO
	Product Name: 0768BXG
	Version: 3000 N100                       
	Serial Number: L3PV880                                                  
	UUID: E384EFFA-25CB-11DC-9EB2-001B38087FD3
	Wake-up Type: Power Switch
	SKU Number: Intel
	Family: Lenovo

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: LENOVO
	Product Name: CAPELL VALLEY(NAPA) CRB

This must be a pretty early BIOS if it still says
Capell Valley CRB in the DMI....


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
