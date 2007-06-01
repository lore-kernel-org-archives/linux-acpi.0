From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH]: ACPI: preserve the ebx value in acpi_copy_wakeup_routine
Date: Fri, 1 Jun 2007 18:27:00 +0800
Message-ID: <823A93EED437D048963A3697DB0E35DE16B6CB@pdsmsx414.ccr.corp.intel.com>
References: <20070601101707.GC31453@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54360 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757619AbXFAK1P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jun 2007 06:27:15 -0400
Content-class: urn:content-classes:message
In-Reply-To: <20070601101707.GC31453@elf.ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, "Tian, Kevin" <kevin.tian@intel.com>

According to the SYSTEM V APPLICATION BINARY INTERFACE,
Intel386 Architecture:
"ecx and edx: Scratch registers have no specified role in the standard =
calling
sequence. Functions do not have to preserve their values for the
caller."

Best regards,
Zhang.Rui(Ray)

=20
-----Original Message-----
=46rom: Pavel Machek [mailto:pavel@ucw.cz]=20
Sent: 2007=C4=EA6=D4=C21=C8=D5 18:17
To: Zhang, Rui
Cc: linux-acpi@vger.kernel.org; lenb@kernel.org; Tian, Kevin
Subject: Re: [PATCH]: ACPI: preserve the ebx value in acpi_copy_wakeup_=
routine

Hi!

> From: Tian Kevin <kevin.tian@intel.com>
>=20
> Register %ebx serves as the "global offset table base register"
> for position-independent code. For absolute code, %ebx serves
> as a local register and has no specified role in the function
> calling sequence. In either case, a function must preserve the
> register value for the caller.
>=20
> acpi_copy_wakeup_routine overrides %ebx without saving it,
> this may corrupt the called data.
>=20
> Kevin found that most time the value of Sx is saved in %esi,
> however sometimes compiler also uses %ebx. When this happens,
> suspends fails since sleep value in ebx is changed by
> acpi_copy_wakeup_routine.
>=20
> The same funtion in X86_64 doesn't have this problem.
>=20
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Looks okay to me. That routine also corrupts ecx and edx, hopefully
that's okay?
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses=
/blog.html
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
