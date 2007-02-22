From: Janosch Machowinski <scotch@tzi.de>
Subject: Re: C-States Usage/Accounting
Date: Thu, 22 Feb 2007 20:31:37 +0100
Message-ID: <45DDEF99.40102@tzi.de>
References: <FE6DEEF0-61B3-44D4-AA62-E8CE04C7FD8E@badopi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-bremen.de ([134.102.201.18]:52466 "EHLO
	informatik.uni-bremen.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751799AbXBVTqL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Feb 2007 14:46:11 -0500
In-Reply-To: <FE6DEEF0-61B3-44D4-AA62-E8CE04C7FD8E@badopi.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?ISO-8859-1?Q?Eduard_Gim=E9nez_Cerd=E0?= <edu@badopi.org>
Cc: linux-acpi@vger.kernel.org

Eduard Gim=E9nez Cerd=E0 schrieb:
> Hello,
>=20
> I've two machines with the following configuration:
>     Processor:    Intel Core Solo T1300 / Intel Celeron M 420
>     Mainboard:    Asus N4L-VM DH with Intel 945GM Chipset with an AMI=
 BIOS
>     (I suppose the drives and the memory are not important)
>=20
> With the vanilla kernels 2.6.18 and 2.6.19 the=20
> /proc/acpi/processor/CPU1/info file shows that there is no bus master=
ing=20
> nor power management, and looking at /proc/acpi/processor/CPU1/power =
the=20
> states accounting only shows the C1 state but without any data (0 or =
--=20
> on all the values), although it shows that the maximum C-State is C8.
C8 is the maximum C-State supported by Linux.

Actually is could be, that nothing is broken. If the bios does not=20
export more than one C-State, than everything is (from the view of=20
linux) ok. If you want to find out, what C-States are exported by the=20
bios, decompile your DSDT (can be found under /proc/acpi/dsdt) with the=
=20
  IASL compiler=20
(http://www.intel.com/technology/iapc/acpi/license2.htm), and search in=
=20
the decompiled version for _CST. More information about the _CST object=
=20
can be found in the ACPI-Specification (www.acpi.info)

	Janosch

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
