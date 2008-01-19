From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode of Samsung R40plus
Date: Sat, 19 Jan 2008 00:12:25 -0500
Message-ID: <200801190012.25401.lenb@kernel.org>
References: <680b97540711061132s11f9db29p86462407c86fbfe8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:53610 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbYASFMi (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 19 Jan 2008 00:12:38 -0500
In-Reply-To: <680b97540711061132s11f9db29p86462407c86fbfe8@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Victor Sergienko <singalen@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday 06 November 2007 14:32, Victor Sergienko wrote:
> While digging boot log, I found the message to email the dmidecode.
> Sorry if this one is inappropriate.
> Maybe there is something in here about boot delays cause.
> Thank you.


Thanks for the dmidecode output.

Do you notice any functional difference when booting with...

"acpi_osi=Linux"        (default for 2.6.22 and earlier)
vs.
"acpi_osi=!Linux"       (default for 2.6.23 and later)

...in particular, please check sound, wifi, and hibernate.

Also, please send me the output from acpidump.

thanks,
-Len

ps
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

System Information
	Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
	Product Name: R40P/R41P
	Version: 04YE
	Serial Number: 962W93AP500149
	UUID: 80D6832C-D21D-B211-8000-E86717A0F2D8
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
	Product Name: R40P/R41P
