From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode of HP Pavilion tx 1000
Date: Fri, 18 Jan 2008 23:07:47 -0500
Message-ID: <200801182307.47527.lenb@kernel.org>
References: <1190315351.3790.8.camel@lebioda>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46463 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760572AbYASEID (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 23:08:03 -0500
In-Reply-To: <1190315351.3790.8.camel@lebioda>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jakub =?utf-8?q?Ambro=C5=BCewicz?= <jakub.ambrozewicz@googlemail.com>
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
	Manufacturer: Hewlett-Packard
	Product Name: HP Pavilion tx 1000 (RY588EA#ABU) 
	Version: Rev 1
	Serial Number: CNF7080LY2
	UUID: 434E4637-3038-304C-5932-001636E9EB04
	Wake-up Type: Power Switch
	SKU Number:               
	Family: 103C_5335KV

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Quanta
	Product Name: 30BF
