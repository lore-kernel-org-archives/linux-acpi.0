From: Len Brown <lenb@kernel.org>
Subject: Re: acer extensa 5220 dmidecode
Date: Fri, 18 Jan 2008 15:17:12 -0500
Message-ID: <200801181517.12583.lenb@kernel.org>
References: <ea6da9045ea64107ffbda030a504fb5f@one.by>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59684 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758075AbYARUR1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 15:17:27 -0500
In-Reply-To: <ea6da9045ea64107ffbda030a504fb5f@one.by>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chodorenko Michail <misha@one.by>
Cc: linux-acpi@vger.kernel.org

On Friday 11 January 2008 13:44, Chodorenko Michail wrote:
> # dmidecode 2.9

> 
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
> 	Manufacturer: Acer           
> 	Product Name: Extensa 5220                   
> 	Version: 0100           
> 	Serial Number: LXE870C0237371D8C02000        
> 	UUID: 10731F80-658A-11DC-8669-86240C761AF5
> 	Wake-up Type: Power Switch
> 	SKU Number: Not Specified
> 	Family: Not Specified
> 

Does this system run any better or worse when booted with "acpi_osi=Linux"?

Please send me the output from acpidump.
If acpidump is not installed on your machine, you can find it here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len
