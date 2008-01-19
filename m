From: Len Brown <lenb@kernel.org>
Subject: Re: Kernel 2.6.22.9 wanted dmidecode of my Acer Aspire 5102WLMi laptop, so here it is...
Date: Fri, 18 Jan 2008 23:26:31 -0500
Message-ID: <200801182326.31913.lenb@kernel.org>
References: <470E0BD3.3050803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37596 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763088AbYASE0o convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 23:26:44 -0500
In-Reply-To: <470E0BD3.3050803@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Juho <angelusx@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Thursday 11 October 2007 07:41, Juho wrote:
> System Information
> =A0=A0=A0=A0=A0=A0=A0=A0Manufacturer: Acer
> =A0=A0=A0=A0=A0=A0=A0=A0Product Name: Aspire 5100
> =A0=A0=A0=A0=A0=A0=A0=A0Version: V3.05A
> =A0=A0=A0=A0=A0=A0=A0=A0Serial Number: LXABH05039632066BD1601
> =A0=A0=A0=A0=A0=A0=A0=A0UUID: 36323361-3930-3335-6237-0016D41742AF
> =A0=A0=A0=A0=A0=A0=A0=A0Wake-up Type: Power Switch
> =A0=A0=A0=A0=A0=A0=A0=A0SKU Number: Not Specified
> =A0=A0=A0=A0=A0=A0=A0=A0Family: Not Specified
>=20
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> =A0=A0=A0=A0=A0=A0=A0=A0Manufacturer: Acer
> =A0=A0=A0=A0=A0=A0=A0=A0Product Name: Navarro

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
