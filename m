From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode from DELL Inspiron 1501
Date: Fri, 18 Jan 2008 18:39:24 -0500
Message-ID: <200801181839.24756.lenb@kernel.org>
References: <200707100842.15999.Dirk.Gorny@Genion.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38438 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756948AbYARXjo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 18:39:44 -0500
In-Reply-To: <200707100842.15999.Dirk.Gorny@Genion.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dirk Gorny <Dirk.Gorny@genion.de>
Cc: linux-acpi@vger.kernel.org

Thanks, Dirk, for the dmidecode,

System Information
	Manufacturer: Dell Inc.
	Product Name: Inspiron 1501 
	Version: Not Specified                   
	Serial Number: 6R9GQ2J
	UUID: 44454C4C-5200-1039-8047-B6C04F51324A
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0003, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Dell Inc.
	Product Name: 0UW744

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
