From: Len Brown <lenb@kernel.org>
Subject: Re: By popular demand - dmidecode on Compal H/EL80
Date: Fri, 18 Jan 2008 18:41:29 -0500
Message-ID: <200801181841.29885.lenb@kernel.org>
References: <200707100843.04391.m.jedrasik@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56983 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756295AbYARXlo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 18:41:44 -0500
In-Reply-To: <200707100843.04391.m.jedrasik@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mateusz Jedrasik <m.jedrasik@gmail.com>
Cc: linux-acpi@vger.kernel.org


System Information
	Manufacturer: COMPAL          
	Product Name: HEL80I          
	Version: -
	Serial Number: 2054228700233   
	UUID: 158F767F-3E9F-11DB-B7EC-0016D41DF7E7
	Wake-up Type: Power Switch
	SKU Number:                                                                                               
	Family: Intel

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: COMPAL
	Product Name: HEL8X

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
