From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode (Samsung R40plus)
Date: Fri, 18 Jan 2008 16:18:50 -0500
Message-ID: <200801181618.51124.lenb@kernel.org>
References: <200712282201.42665.ulrich.ivens@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59863 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759514AbYARVTK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 16:19:10 -0500
In-Reply-To: <200712282201.42665.ulrich.ivens@gmx.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ulrich Ivens <ulrich.ivens@gmx.de>
Cc: linux-acpi@vger.kernel.org


> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>         Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
>         Product Name: R40P/R41P
>         Version: 01YE
>         Serial Number: 987V93CP300020
>         UUID: 609A7519-D21D-B211-8000-C10FFE3A9BBA
>         Wake-up Type: Power Switch
>         SKU Number: Not Specified
>         Family: Not Specified

With 2.6.22, did you notice any functional difference with "acpi_osi=!Linux"?

(or since the default changed at 2.6.23, with 2.6.23 or later
 do you notice any difference with "acpi_osi=Linux"?)

Please send me the output from acpidump.
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len
