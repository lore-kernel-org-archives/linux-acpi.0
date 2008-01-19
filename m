From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - Apple MacPro
Date: Fri, 18 Jan 2008 22:36:40 -0500
Message-ID: <200801182236.40494.lenb@kernel.org>
References: <200708291349.46987.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58566 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762076AbYASDhE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 22:37:04 -0500
In-Reply-To: <200708291349.46987.rene@exactcode.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?iso-8859-1?q?Ren=E9_Rebe?= <rene@exactcode.de>
Cc: linux-acpi@vger.kernel.org

On Wednesday 29 August 2007 07:49, Ren=E9 Rebe wrote:
> Hi all,
>=20
> I just post because my dmesg says so:
>=20
> ACPI: System BIOS is requesting _OSI(Linux)
> ACPI: Please test with "acpi_osi=3D!Linux"
> Please send dmidecode to linux-acpi@vger.kernel.org
>=20
> Handle 0x003A, DMI type 0, 24 bytes
> BIOS Information
>         Vendor: Apple Computer, Inc.
>         Version:     MP21.88Z.007F.B02.0703191612
>         Release Date: 03/19/07
>=20
> Handle 0x003B, DMI type 1, 27 bytes
> System Information
>         Manufacturer: Apple Computer, Inc.
>         Product Name: MacPro2,1
>         Version: 1.0
>=20
> ...
>=20
> If you need more let me know. I mostly looked thru the dmesg
> because the box shuts down sometimes, randomly. Maybe too hot?
> But I still investigate.
>=20
> However, the box (2 Quad-Core CPUs) even awakes from echo mem >
> /sys/power/state (without graphic though, maybe s2ram posting would f=
ix
> that - but I do not really care about the graphic as it is indended t=
o be used
> as server anyway).

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
