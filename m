From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - Acer Aspire 5050
Date: Fri, 18 Jan 2008 23:08:45 -0500
Message-ID: <200801182308.45557.lenb@kernel.org>
References: <a883fd280709220407v38c578aeyf840cf20668f0c6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:46485 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764289AbYASEI7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 23:08:59 -0500
In-Reply-To: <a883fd280709220407v38c578aeyf840cf20668f0c6a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Zabolotny <flying.sad@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Saturday 22 September 2007 07:07, Alexander Zabolotny wrote:
> System Information
> =A0 =A0 =A0 =A0 Manufacturer: Acer, inc.
> =A0 =A0 =A0 =A0 Product Name: Aspire 5050
> =A0 =A0 =A0 =A0 =A0 =A0 Version: Not Applicable
> =A0 =A0 =A0 =A0 Serial Number: LXAV40C0227120E9C42502
> =A0 =A0 =A0 =A0 UUID: 8047A5DB-A992-D811-9897-001636FE0630
> =A0 =A0 =A0 =A0 Wake-up Type: Power Switch
> =A0 =A0 =A0 =A0 SKU Number: Not Specified
> =A0 =A0 =A0 =A0 Family: Not Specified
>=20
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> =A0 =A0 =A0 =A0 Manufacturer: Acer, Inc.
> =A0 =A0 =A0 =A0 Product Name: Prespa M

Thanks for the dmidecode output.

Do you notice any functional difference when booting with

"acpi_osi=3DLinux"        (default for 2.6.22 and earlier)
vs.
"acpi_osi=3D!Linux"       (default for 2.6.23 and later)

Also, please send me the output from acpidump.

thanks,
-Len

ps
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
