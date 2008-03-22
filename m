From: Eric Piel <eric.piel@tremplin-utc.net>
Subject: Re: 2.6.25-rc6 compile error in drivers/acpi/osl.c
Date: Sat, 22 Mar 2008 15:32:04 +0100
Message-ID: <47E51864.5000107@tremplin-utc.net>
References: <47E508B3.8070801@octant-fr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:4706 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218AbYCVOcM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Mar 2008 10:32:12 -0400
In-Reply-To: <47E508B3.8070801@octant-fr.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tobias Oed <tobias.oed@octant-fr.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, matthew@wil.cx, Randy Dunlap <randy.dunlap@oracle.com>

(added Randy as CC just in case it ends up being a problem with=20
7ce9573e093891f5807e6e50f3bd2012f1e5d0fe)
Tobias Oed wrote:
> Hello,
> compiling 2.6.25-rc6 on my up to date fedora 8 system ends with
>=20
>   CC      drivers/acpi/osl.o
> drivers/acpi/osl.c:60:38: error: n: No such file or directory
> drivers/acpi/osl.c: In function =E2=80=98acpi_os_table_override=E2=80=
=99:
> drivers/acpi/osl.c:334: error: =E2=80=98AmlCode=E2=80=99 undeclared (=
first use in this=20
> function)
> drivers/acpi/osl.c:334: error: (Each undeclared identifier is reporte=
d=20
> only once
> drivers/acpi/osl.c:334: error: for each function it appears in.)
> make[2]: *** [drivers/acpi/osl.o] Error 1
> make[1]: *** [drivers/acpi] Error 2
> make: *** [drivers] Error 2
>=20
> Config attached
Hi Tobias,
=46irst, you haven't sent the correct .config file (this one is dated "=
=46ri=20
Mar 14 21:06:35 2008").

To fix your problem you just need to "make menuconfig" and change=20
ACPI_CUSTOM_DSDT_FILE from "n" to "".

Now the question is: how did you end up with this error? Is it just you=
=20
who mistook while answering the questions of "make oldconfig" or did=20
this "n" appeared automatically because was not ACPI_CUSTOM_DSDT is set=
=2E=20
In which case this is a bug in the kernel.

Eric
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
