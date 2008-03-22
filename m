From: Corentin CHARY <corentincj@iksaif.net>
Subject: Re: 2.6.25-rc6 compile error in drivers/acpi/osl.c
Date: Sat, 22 Mar 2008 15:35:33 +0100
Message-ID: <200803221535.34026.corentincj@iksaif.net>
References: <47E508B3.8070801@octant-fr.com>
Reply-To: corentincj@iksaif.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.dns26.com ([84.246.226.15]:34301 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753251AbYCVOhD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Mar 2008 10:37:03 -0400
In-Reply-To: <47E508B3.8070801@octant-fr.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tobias Oed <tobias.oed@octant-fr.com>
Cc: linux-acpi@vger.kernel.org, matthew@wil.cx

On Saturday 22 March 2008 14:25:07 Tobias Oed wrote:
> Hello,
> compiling 2.6.25-rc6 on my up to date fedora 8 system ends with
>
>    CC      drivers/acpi/osl.o
> drivers/acpi/osl.c:60:38: error: n: No such file or directory
> drivers/acpi/osl.c: In function =E2=80=98acpi_os_table_override=E2=80=
=99:
> drivers/acpi/osl.c:334: error: =E2=80=98AmlCode=E2=80=99 undeclared (=
first use in this
> function)
> drivers/acpi/osl.c:334: error: (Each undeclared identifier is reporte=
d
> only once
> drivers/acpi/osl.c:334: error: for each function it appears in.)
> make[2]: *** [drivers/acpi/osl.o] Error 1
> make[1]: *** [drivers/acpi] Error 2
> make: *** [drivers] Error 2
>
> Config attached
> Tobias Oed

Hi,
can you send the output of:

cd /usr/src/linux
grep ACPI_CUSTOM_DSDT .config
grep ACPI_CUSTOM_DSDT include/config/auto.conf
grep ACPI_CUSTOM_DSDT include/linux/autoconf.h

Thanks.
--=20
Corentin 'Iksaif' CHARY
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
