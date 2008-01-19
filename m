From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode output for Sony Vaio VGN-FZ11M laptop
Date: Fri, 18 Jan 2008 21:16:21 -0500
Message-ID: <200801182116.21651.lenb@kernel.org>
References: <200707291318.42184.ian.snow@btinternet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57482 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764812AbYASCQh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 21:16:37 -0500
In-Reply-To: <200707291318.42184.ian.snow@btinternet.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ian Snow <ian.snow@btinternet.com>
Cc: linux-acpi@vger.kernel.org

On Sunday 29 July 2007 08:18, Ian Snow wrote:
> System Information
> =C2=A0 =C2=A0 Manufacturer: Sony Corporation
> =C2=A0 =C2=A0 Product Name: VGN-FZ11M
> =C2=A0 =C2=A0 Version: C3LP8MZ3
> =C2=A0 =C2=A0 Serial Number: 28201150-5000954
> =C2=A0 =C2=A0 UUID: 25BBA8A0-08D1-11DC-874E-0013A9C09B3B
> =C2=A0 =C2=A0 Wake-up Type: Power Switch
> =C2=A0 =C2=A0 SKU Number: N/A
> =C2=A0 =C2=A0 Family: N/A
>=20
> Handle 0x0002, DMI type 2, 10 bytes
> Base Board Information
> =C2=A0 =C2=A0 Manufacturer: Sony Corporation
> =C2=A0 =C2=A0 Product Name: VAIO

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
