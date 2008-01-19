From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - dv9500
Date: Fri, 18 Jan 2008 23:30:33 -0500
Message-ID: <200801182330.33809.lenb@kernel.org>
References: <1192260691.7970.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37755 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759933AbYASEau convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 23:30:50 -0500
In-Reply-To: <1192260691.7970.1.camel@localhost>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Siegfried =?utf-8?q?L=C3=B6sch?= <S.Loesch@inode.at>
Cc: linux-acpi@vger.kernel.org

On Saturday 13 October 2007 03:31, Siegfried L=C3=B6sch wrote:
> System Information
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: Hewlett-Packard
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: HP Pavilion dv9500 Notebook=
 PC =C2=A0 =C2=A0
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Version: Rev 1
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Serial Number: CNF7364LT9
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 UUID: 434E4637-3336-344C-5439-001B2496B6B=
B
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Wake-up Type: Power Switch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKU Number: GU135EA#ABD=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Family: 103C_5335KV
>=20
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: Quanta
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: 30CB

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
