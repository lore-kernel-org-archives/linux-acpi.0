From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode of FSC Amilo Pa 2510
Date: Fri, 18 Jan 2008 22:12:40 -0500
Message-ID: <200801182212.40400.lenb@kernel.org>
References: <200708121802.41426.crunchy@bitkipper.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56893 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756454AbYASDM6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 22:12:58 -0500
In-Reply-To: <200708121802.41426.crunchy@bitkipper.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andreas =?utf-8?q?B=C3=BCsching?= <crunchy@bitkipper.net>
Cc: linux-acpi@vger.kernel.org

On Sunday 12 August 2007 12:02, Andreas B=C3=BCsching wrote:
> Hi,
>=20
> A "nice" kernel message informed that I might get some help here ;-)
>=20
> I'm trying get a Linux kernel verion 2.6.22 or higher to work on my n=
otebook=20
> (a FSC Amilo Pa 2510). It just stops the boot process with the messag=
e that I=20
> should try to append the option acpi_osi=3DLinux. That did not help.
>=20
> I've tried the kernel versions 2.6.22 and a 2.6.23rc2 with several=20
> combinations of kernel options like (not that I really knew what I'm =
doing=20
> there ;-):
>=20
> acpi_osi=3DLinux
> acpi_osi=3D!Linux
>=20
> I've also tried to update the BIOS from 1.04 to 1.06 but that didn't =
help.
>=20
> Currently I'm running kernel verison 2.6.18 (based on the Debian Etch=
 kernel).
>=20
> Any help is appreciated. If you need any further information just ask=
=2E =C2=A0I've=20
> attached the dmidecode output and the kernel config.
>=20
> I've not subscribed to the list, so please add me in CC if you reply =
to this=20
> message.

Andreas,
have you got past the booting problem on this box?
if 2.6.18 boots but the latest kernel doesn't, that is something
we need to figure out....

Re: OSI(Linux)...

System Information
	Manufacturer: FUJITSU SIEMENS
	Product Name: AMILO Pa 2510
	Version: 20
	Serial Number: 12345678
	UUID: 006581C7-5E2A-DB11-B7FE-D1AD14F053E9
	Wake-up Type: Power Switch
	SKU Number: 12345678
	Family: AMILO

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: FUJITSU SIEMENS
	Product Name: F37    =20

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
