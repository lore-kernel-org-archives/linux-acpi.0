From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode output kernel 2.6.22.9 - FSC AMILO PI 1536
Date: Fri, 18 Jan 2008 23:24:35 -0500
Message-ID: <200801182324.36055.lenb@kernel.org>
References: <20071008092839.11866.qmail@webmail.gestionar.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42848 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764147AbYASEYv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 23:24:51 -0500
In-Reply-To: <20071008092839.11866.qmail@webmail.gestionar.info>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: vicente@torrellano.com
Cc: linux-acpi@vger.kernel.org

On Monday 08 October 2007 05:28, vicente@torrellano.com wrote:
> System Information
> =A0 =A0 =A0 =A0 Manufacturer: FUJITSU SIEMENS
> =A0 =A0 =A0 =A0 Product Name: AMILO PI 1536
> =A0 =A0 =A0 =A0 Version: Not Applicable
> =A0 =A0 =A0 =A0 Serial Number: 53101F66
> =A0 =A0 =A0 =A0 UUID: 0027EEF7-E862-0010-978A-FA4E0FC5D524
> =A0 =A0 =A0 =A0 Wake-up Type: Power Switch
> =A0 =A0 =A0 =A0 SKU Number: Not Specified
> =A0 =A0 =A0 =A0 Family: Not Specified
>=20
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> =A0 =A0 =A0 =A0 Manufacturer: FUJITSU SIEMENS
> =A0 =A0 =A0 =A0 Product Name: AMILO PI 1536

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
