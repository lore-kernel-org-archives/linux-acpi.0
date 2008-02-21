From: Len Brown <lenb@kernel.org>
Subject: Re: [BUILD_FAILURE] 2.6.25-rc2-mm1 - Build Failure at acpi_os
Date: Thu, 21 Feb 2008 02:08:47 -0500
Message-ID: <200802210208.47487.lenb@kernel.org>
References: <20080216002522.9c4bd0fb.akpm@linux-foundation.org> <47B73DD8.4030405@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42323 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753843AbYBUHJK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 02:09:10 -0500
In-Reply-To: <47B73DD8.4030405@linux.vnet.ibm.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>

On Saturday 16 February 2008 14:47, Kamalesh Babulal wrote:
> Hi Andrew,
>=20
> The 2.6.25-rc2-mm1 kernel with randconfig build option, fails
> to build on x86_64 machine
>=20
>   CC      drivers/acpi/osl.o
> drivers/acpi/osl.c:60:38: error: empty filename in #include
> drivers/acpi/osl.c: In function =E2=80=98acpi_os_table_override=E2=80=
=99:
> drivers/acpi/osl.c:399: error: =E2=80=98AmlCode=E2=80=99 undeclared (=
first use in this function)
> drivers/acpi/osl.c:399: error: (Each undeclared identifier is reporte=
d only once
> drivers/acpi/osl.c:399: error: for each function it appears in.)
> make[2]: *** [drivers/acpi/osl.o] Error 1
> make[1]: *** [drivers/acpi] Error 2
> make: *** [drivers] Error 2
>=20
> #
> # Automatically generated make config: don't edit
> # Linux kernel version: 2.6.25-rc2-mm1
> # Sun Feb 17 08:07:17 2008
> #

> CONFIG_ACPI_CUSTOM_DSDT=3Dy
> CONFIG_ACPI_CUSTOM_DSDT_FILE=3D""

garbage in, garbage out.

If you don't give this build option a file name where AmlCode lives,
then the build will be unable to find AmlCode[].

http://www.lesswatts.org/projects/acpi/overridingDSDT.php

cheers,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
