From: Len Brown <lenb@kernel.org>
Subject: Re: HP dv6535ep dmidecode
Date: Fri, 18 Jan 2008 22:49:43 -0500
Message-ID: <200801182249.43562.lenb@kernel.org>
References: <20070911171927.572087e0.miknix@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36510 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757326AbYASDt7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Jan 2008 22:49:59 -0500
In-Reply-To: <20070911171927.572087e0.miknix@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?utf-8?q?=C3=82ngelo_Miguel_Arrifano?= <miknix@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Tuesday 11 September 2007 12:19, =C3=82ngelo Miguel Arrifano wrote:
> Hello,
>=20
>   In sequence of
> ACPI: System BIOS is requesting _OSI(Linux)
> ACPI: Please test with "acpi_osi=3D!Linux"
> Please send dmidecode to linux-acpi@vger.kernel.org
>=20
> I'm sending information of my new laptop.
> It's a HP dv6535ep but should be simillar to the dv65xx series.
>=20
> Everything is working fine (one-touch hotkeys, suspend-to-ram
> by simply issuing echo "mem" > /sys/power/state, sound, ...)
> except the Fn+F7/Fn+F8 keys to increase/decrease DFP brightness
> (i really don't have more ideas how to set screen brightness : \).
> Also when I plug headphones, laptop speakers doesn't turn off
> but this should be a alsa problem.

brightness on these new boxes will eventually be handled
by some extensions to the native X grahics drivers.

> I tried disabling Linux OSI and comparing both dmesg but they are
> similar. Disabling Linux OSI and enabling 'Windows 2006' OSI
> makes GL acceleration crash the laptop.

That is pretty unexpected, because Linux already supports
OSI(Windows 2006) -- so your change should have had no effect.

> PS: I'm curious about 'processor CPU0 00000080 00000000' acpi
> event messages that I usually receive when compiling stuff.

If these are not gone in the latest 2.6.24 rc, then please
file a bug here:

http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI

> I think its about CPU temperature but according to Google it's=20
> a change on the number of CPU P-states. I'm trying to figure
> out what to do when receiving these events.
>=20
> Just another thing, there is a dsdt parsing error during boot:
> ACPI Error (dsopcode-0548): Field [I9MN] at 544 exceeds Buffer [IORT]=
 size 464 (bits) [20070126]
> ACPI Error (psparse-0537): Method parse/execution failed [\_SB_.PCI0.=
LPC0.PMIO._CRS] (Node ffff81007ff40760), AE_AML_BUFFER_LIMIT
> ACPI Error (uteval-0236): Method execution failed [\_SB_.PCI0.LPC0.PM=
IO._CRS] (Node ffff81007ff40760), AE_AML_BUFFER_LIMIT
> pnp: PnPACPI: METHOD_NAME__CRS failure for PNP0c02

This should also be gone in the latest kerel.
If it still complains (when running the original DSDT, not a modified o=
ne),
then please file a bug here:

http://bugzilla.kernel.org/enter_bug.cgi?product=3DACPI

> is this '\_SB_.PCI0.LPC0.PMIO' important to my system?

assume it is.

System Information
	Manufacturer: Hewlett-Packard
	Product Name: HP Pavilion dv6500 Notebook PC   =20
	Version: Rev 1
	Serial Number: CNF73002RR
	UUID: 434E4637-3330-3032-5252-001B24767D17
	Wake-up Type: Power Switch
	SKU Number: GT373EA#AB9
	Family: 103C_5335KV

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Quanta
	Product Name: 30D0

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
