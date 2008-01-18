From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode acpi_osi=!Linux (ACTEBIS SAM#451B)
Date: Fri, 18 Jan 2008 18:55:36 -0500
Message-ID: <200801181855.36846.lenb@kernel.org>
References: <49699.212.238.156.107.1184415372.squirrel@mail.de-vos.net> <200707141628.07178.maggu2810@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45457 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757487AbYARXzy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 18:55:54 -0500
In-Reply-To: <200707141628.07178.maggu2810@web.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Markus Rathgeb <maggu2810@web.de>
Cc: linux-acpi@vger.kernel.org

On Saturday 14 July 2007 10:28, Markus Rathgeb wrote:
> Hi!
> I saw a lot of the dmidecode messages and attached my dmidecode output (with 
> kernel.parameter acpi_osi=!Linux).
> But there is no different if I use this parameter or not.

so you see no functional difference when booting with

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
        Manufacturer: ACTEBIS
        Product Name: SAM#451B
        Version: VT8385/VT8235
        Serial Number: 000009
        UUID: 80427E3E-4364-0010-937C-000930CFCFFC
        Wake-up Type: Power Switch

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
        Manufacturer: ACTEBIS
        Product Name: SAM#451B
