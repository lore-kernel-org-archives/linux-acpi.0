From: Len Brown <lenb@kernel.org>
Subject: Re: Fwd: FSC Esprimo Mobile V5505 - dmidecode
Date: Fri, 18 Jan 2008 23:29:49 -0500
Message-ID: <200801182329.49567.lenb@kernel.org>
References: <200710122357.46851.dl9pf@gmx.de> <200710131013.55290.dl9pf@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37738 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758400AbYASEaE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 23:30:04 -0500
In-Reply-To: <200710131013.55290.dl9pf@gmx.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jan-Simon =?utf-8?q?M=C3=B6ller?= <dl9pf@gmx.de>
Cc: linux-acpi@vger.kernel.org

On Saturday 13 October 2007 04:13, Jan-Simon M=C3=B6ller wrote:
> System Information
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: FUJITSU SIEMENS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: ESPRIMO Mobile V5505
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Version: 20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Wake-up Type: Power Switch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 SKU Number: Not Specified
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Family: Not Specified
>=20
> Handle 0x0002, DMI type 2, 8 bytes
> Base Board Information
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Manufacturer: FUJITSU SIEMENS
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Product Name: ESPRIMO Mobile V5505

Jan-Simon,
Thanks for the dmidecode output.

Did the console dmesg ask you to send it because
of OSI(Linux)?

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
