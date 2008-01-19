From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - MacBook2,1
Date: Fri, 18 Jan 2008 23:21:56 -0500
Message-ID: <200801182321.56923.lenb@kernel.org>
References: <413515090710060238x4af5f54fsd558841153480b42@mail.gmail.com> <413515090710060905u2efdafa9m55e3dbce4586e50a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42741 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757890AbYASEWL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 23:22:11 -0500
In-Reply-To: <413515090710060905u2efdafa9m55e3dbce4586e50a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Samae <lord.myyl@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Saturday 06 October 2007 12:05, Samae wrote:
> System Information
> =A0 =A0 Manufacturer: Apple Inc.
> =A0 =A0 Product Name: MacBook2,1
> =A0 =A0 Version: =A01.0
> =A0 =A0 Serial Number: W87311YWZ5X
> =A0 =A0 UUID: 61F9E18A-38B2-B440-A87E-7457DF18863C
> =A0 =A0 Wake-up Type: Power Switch
> =A0 =A0 SKU Number: System SKUNumber
> =A0 =A0 Family: MacBook
>=20
> Handle 0x0002, DMI type 2, 16 bytes
> Base Board Information
> =A0 =A0 Manufacturer: Apple Inc.
> =A0 =A0 Product Name: Mac-F4208CAA


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
