From: Len Brown <lenb@kernel.org>
Subject: Re: DMIDECODE
Date: Fri, 18 Jan 2008 15:33:48 -0500
Message-ID: <200801181533.48349.lenb@kernel.org>
References: <47821158.1090205@tdkom.net.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40337 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757143AbYARUeJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 15:34:09 -0500
In-Reply-To: <47821158.1090205@tdkom.net.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Cleri Aloisio Azevedo <cleri@tdkom.net.br>
Cc: linux-acpi@vger.kernel.org


> 
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>         Manufacturer: Hewlett-Packard
>         Product Name: HP Pavilion dv2000 (GA537UA#ABA)
>         Version: F.34
>         Serial Number: 2CE7250XMH
>         UUID: D712EB60-1EC3-11DC-BF89-CEBE5E4FD534
>         Wake-up Type: Power Switch
>         SKU Number: GA537UA#ABA
>         Family: 103C_5335KV
> 

Does this system run any better or worse when booted with "acpi_osi=Linux"?

Please send me the output from acpidump.
If acpidump is not installed on your machine, you can find it
in pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len

