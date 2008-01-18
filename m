From: Len Brown <lenb@kernel.org>
Subject: Re: Toshiba Satellite u305-7477 dmidecode output
Date: Fri, 18 Jan 2008 15:38:15 -0500
Message-ID: <200801181538.15698.lenb@kernel.org>
References: <d8dde2940801060326k7c1a1d29wd199527aa68df520@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:55045 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758987AbYARUib (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 15:38:31 -0500
In-Reply-To: <d8dde2940801060326k7c1a1d29wd199527aa68df520@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Goguen <dgoguen@gmail.com>
Cc: linux-acpi@vger.kernel.org


> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>         Manufacturer: TOSHIBA
>         Product Name: Satellite U305
>         Version: PSU30U-054012
>         Serial Number: X7068484W
>         UUID: 607BC0A3-0E91-D811-8DB6-001B24BBF5FC
>         Wake-up Type: Power Switch
>         SKU Number: Not Specified
>         Family: Not Specified

Does this system run any better or worse when booted with "acpi_osi=Linux"?

Please send me the output from acpidump.
If acpidump is not installed on your machine, you can find it
in pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len

