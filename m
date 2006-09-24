From: Dieter Jurzitza <dieter.jurzitza@t-online.de>
Subject: Re: Blacklisted system / blacklisting bad
Date: Sun, 24 Sep 2006 20:35:54 +0200
Message-ID: <200609242035.55163.dieter.jurzitza@t-online.de>
References: <200609031134.33024.dieter.jurzitza@t-online.de> <200609200055.42958.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout08.sul.t-online.com ([194.25.134.20]:37258 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1752137AbWIXSnA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 24 Sep 2006 14:43:00 -0400
In-Reply-To: <200609200055.42958.len.brown@intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>

Dear Len,
using 2.6.18-rc7 on this box works like charm - using acpi=3Dforce. The=
 bad=20
thing about it stems from the additional fact, that acpi has been disab=
led for=20
elder bioses by a switch checking for the bios age. I did not know abou=
t this=20
because 2.6.11 doesn't use the age checking.
However things may be, I tested according to your suggestion and things=
 simply=20
work as expected.
You can argue that the compile time option for the age check is optiona=
l - but=20
i. e. SuSE is using it, at last.
So you may remove the blacklisting entry, but things will not change fo=
r the=20
user as the age checking forces me to use acpi=3Dforce anyway.
IMHO a "normal" user would have failed with this, both kinds of blackli=
sting=20
are bad (sure, for this specific system).
Is there any option to white-list systems in order to avoid the acpi=3D=
force=20
commandline switch? IMHO it will be hard for a "normal" user to cope wi=
th=20
this and to understand the relation between an "acpi=3Dforce" - switch =
on the=20
boot-commandline and a disfunctional USB interface. Just my two cent he=
re ...


Anyway, patch for 2.6.18 is attached, thanks for your efforts,
take care



Dieter Jurzitza

***********************************************************************=
***************************************
--- linux/arch/i386/kernel/acpi/boot.c  2006-09-13 03:41:36.000000000 +=
0200
+++ linux/arch/i386/kernel/acpi/boot.c  2006-09-22 21:42:46.000000000 +=
0200
@@ -951,14 +951,6 @@
         },
        {
         .callback =3D force_acpi_ht,
-        .ident =3D "HP VISUALIZE NT Workstation",
-        .matches =3D {
-                    DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
-                    DMI_MATCH(DMI_PRODUCT_NAME, "HP VISUALIZE NT=20
Workstation"),
-                    },
-        },
-       {
-        .callback =3D force_acpi_ht,
         .ident =3D "Compaq Workstation W8000",
         .matches =3D {
                     DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
***********************************************************************=
***************************************

Am Mittwoch, 20. September 2006 06:55 schrieb Len Brown:
******
> ACPI is necessary to get the interrupts right for USB to work on this=
 box.
> pci=3Dnoacpi and acpi=3Dht will cause ACPI to be disabled for interru=
pt routing
> and thus USB will fail with those.
******
--=20
-----------------------------------------------------------

                               |
                                \
                 /\_/\           |
                | ~x~ |/-----\   /
                 \   /-       \_/
  ^^__   _        /  _  ____   /
 <=B0=B0__ \- \_/     |  |/    |  |
  ||  ||         _| _|    _| _|

if you really want to see the pictures above - use some font
with constant spacing like courier! :-)
-----------------------------------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
