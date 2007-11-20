From: Len Brown <lenb@kernel.org>
Subject: Re: acpi_osi=!Linux work better than acpi_osi=Linux
Date: Tue, 20 Nov 2007 18:44:51 -0500
Message-ID: <200711201844.51354.lenb@kernel.org>
References: <e859aabc0710261813t468447e7ue074bd5c7974cfee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54731 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754966AbXKTXpK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Nov 2007 18:45:10 -0500
In-Reply-To: <e859aabc0710261813t468447e7ue074bd5c7974cfee@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?utf-8?q?=E9=99=B3=E7=8E=8B=E5=B1=95?= <cwz0522@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Friday 26 October 2007 21:13, =E9=99=B3=E7=8E=8B=E5=B1=95 wrote:
> Dear all,
> after trying all the combinations from en.opensuse.org/S2ram, the
> s2ram still hang or immediately shutdown the system.
> But, I try to pass the acpi_osi=3D!Linux to the kernel, it work well!
>=20
> the following settings is ok for me.
> s2ram --force  --vbe_post
>=20
> If you still need any further information, please contact to me.
>=20
> PS. I don't known how to set the gnome-power-manager to use the
> settings above, is there anyone can give me some advices?  I only can
> use root to use the s2ram command to STR. Thanks
> PS. s2disk is ok whether or not I pass the acpi_osi=3DLinux to the ke=
rnel.
>=20
> Best Regards,
> Peter Chen
>=20
> # dmidecode 2.9
> SMBIOS 2.4 present.
> 28 structures occupying 1179 bytes.
> Table at 0x7FEDF000.
>=20
> Handle 0x0000, DMI type 0, 24 bytes
> BIOS Information
>         Vendor: Phoenix Technologies LTD
>         Version: V1.06
>         Release Date: 07/11/2007
>         Address: 0xE5F80
>         Runtime Size: 106624 bytes
>         ROM Size: 1024 kB
>         Characteristics:
>                 ISA is supported
>                 PCI is supported
>                 PC Card (PCMCIA) is supported
>                 PNP is supported
>                 BIOS is upgradeable
>                 BIOS shadowing is allowed
>                 ESCD support is available
>                 Boot from CD is supported
>                 ACPI is supported
>                 USB legacy is supported
>                 AGP is supported
>                 BIOS boot specification is supported
>                 Targeted content distribution is supported
>=20
> Handle 0x0001, DMI type 1, 27 bytes
> System Information
>         Manufacturer: Acer
>         Product Name: Aspire 4920

Thanks for the note.

What release of Linux are you running?
acpi_osi=3D!Linux is the default starting in 2.6.23.

Any chance you can open a bug report and put the output of acpidump the=
re?
I'd like to see what Acer is doing in this case.

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
