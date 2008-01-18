From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode output HP DV2320US laptop
Date: Fri, 18 Jan 2008 15:51:09 -0500
Message-ID: <200801181551.09207.lenb@kernel.org>
References: <200712290837.25509.greg@gallensanders.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59039 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760029AbYARUvY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 15:51:24 -0500
In-Reply-To: <200712290837.25509.greg@gallensanders.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: greg@gallensanders.org
Cc: linux-acpi@vger.kernel.org

O
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>         Manufacturer: Hewlett-Packard
>         Product Name: HP Pavilion dv2000 (RV323UA#ABA)
>         Version: F.34
>         Serial Number: 2CE7171BDY
>         UUID: 1501AA80-F433-11DB-9D1A-9EE3B10D875F
>         Wake-up Type: Power Switch
>         SKU Number: RV323UA#ABA
>         Family: 103C_5335KV
>

With 2.6.22, did you notice any functional difference with "acpi_osi=!Linux"?

(or since the default changed at 2.6.23, with 2.6.23 or later
 do you notice any difference with "acpi_osi=Linux"?)

Please send me the output from acpidump.
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len
