From: Len Brown <lenb@kernel.org>
Subject: Re: #Please send dmidecode to linux-acpi@vger.kernel.org - AMILO Pi 1536
Date: Fri, 18 Jan 2008 23:58:19 -0500
Message-ID: <200801182358.19717.lenb@kernel.org>
References: <79e95b430710300133n30c6bdeevbd6a42ebd2e99720@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59337 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762725AbYASE6d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 23:58:33 -0500
In-Reply-To: <79e95b430710300133n30c6bdeevbd6a42ebd2e99720@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "C. Tsiafou" <ctsiafou@gmail.com>
Cc: linux-acpi@vger.kernel.org


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

---
System Information
        Manufacturer: FUJITSU SIEMENS
        Product Name: AMILO Pi 1536
        Version: Not Applicable
        Serial Number: 5311B17F
        UUID: 80667A52-CD63-0010-8180-9D59270527D1
        Wake-up Type: Power Switch
        SKU Number: Not Specified
        Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: FUJITSU SIEMENS
        Product Name: AMILO Pi 1536
