From: Len Brown <lenb@kernel.org>
Subject: Re: SBS battery patch series
Date: Sat, 17 Mar 2007 00:35:46 -0400
Message-ID: <200703170035.46836.lenb@kernel.org>
References: <8E389A5F2FEABA4CB1DEC35A25CB39CEB489E7@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50599 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933315AbXCQEhG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 17 Mar 2007 00:37:06 -0400
In-Reply-To: <8E389A5F2FEABA4CB1DEC35A25CB39CEB489E7@mssmsx411>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lebedev, Vladimir P" <vladimir.p.lebedev@intel.com>
Cc: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>, linux-acpi@vger.kernel.org

On Friday 16 March 2007 22:33, Lebedev, Vladimir P wrote:
>=20
> Len, Alexey,
>=20
> This is the final SBS driver patch series.
>=20
> There are two main features:
> 1) Not needed I2C using is removed.
> 2) Common interface with CM battery driver is implemented:
> 	buffering, update_time parameter, etc ...

Does this build in the upstream Linus tree for you?

drivers/acpi/sbs.c:188: error: field =E2=80=98update_timer=E2=80=99 has=
 incomplete type
drivers/acpi/sbs.c: In function =E2=80=98acpi_sbs_update_time=E2=80=99:
drivers/acpi/sbs.c:1608: error: =E2=80=98jiffies=E2=80=99 undeclared (f=
irst use in this function)
drivers/acpi/sbs.c:1608: error: (Each undeclared identifier is reported=
 only once
drivers/acpi/sbs.c:1608: error: for each function it appears in.)
drivers/acpi/sbs.c:1608: error: =E2=80=98HZ=E2=80=99 undeclared (first =
use in this function)
drivers/acpi/sbs.c:1612: warning: implicit declaration of function =E2=80=
=98add_timer=E2=80=99
drivers/acpi/sbs.c: In function =E2=80=98acpi_sbs_add=E2=80=99:
drivers/acpi/sbs.c:1698: warning: implicit declaration of function =E2=80=
=98init_timer=E2=80=99
drivers/acpi/sbs.c: In function =E2=80=98acpi_sbs_remove=E2=80=99:
drivers/acpi/sbs.c:1735: warning: implicit declaration of function =E2=80=
=98del_timer_sync=E2=80=99
make[1]: *** [drivers/acpi/sbs.o] Error 1


When you send the updated series, please include a
Signed-off-by: line at the end of each pach comment.

thanks,
-Len
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
