From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - Toshiba Satellite A135
Date: Sat, 19 Jan 2008 00:01:07 -0500
Message-ID: <200801190001.07907.lenb@kernel.org>
References: <2b32b76e0710312205j6bd6ffdds8bfc6d2a15ffd7f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59448 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbYASFBW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jan 2008 00:01:22 -0500
In-Reply-To: <2b32b76e0710312205j6bd6ffdds8bfc6d2a15ffd7f6@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Perry G <psglenn@gmail.com>
Cc: linux-acpi@vger.kernel.org

Thanks for the dmidecode output.

Do you notice any functional difference when booting with...

"acpi_osi=Linux"        (default for 2.6.22 and earlier)
vs.
"acpi_osi=!Linux"       (default for 2.6.23 and later)

...in particular, please check sound and wifi.

Also, please send me the output from acpidump.

thanks,
-Len

ps
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php
---
System Information
	Manufacturer: TOSHIBA
	Product Name: Satellite A135
	Version: PSAD6U-00R00D
	Serial Number: 17265384K
	UUID: 772E8E64-A34A-11DB-B997-0016D490F070
	Wake-up Type: Power Switch
	SKU Number: 012345678912345678912345678
	Family: ABCDEFGHIJKLMNOPQRSTUVWXYZ

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: TOSHIBA
	Product Name: IAYAA
