From: Len Brown <lenb@kernel.org>
Subject: Re: build #313 failed for 2.6.23-rc5-gb21010e in linux/drivers/acpi/event.c
Date: Thu, 6 Sep 2007 06:30:01 -0400
Message-ID: <200709060630.01925.lenb@kernel.org>
References: <200709061051.30497.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:48136 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757466AbXIFK43 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Sep 2007 06:56:29 -0400
In-Reply-To: <200709061051.30497.toralf.foerster@gmx.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc: linux-acpi@vger.kernel.org

On Thursday 06 September 2007 04:51, Toralf F=C3=B6rster wrote:
> Hello,
>=20
> the build with the attached .config failed, make ends with:
> ...
>   CC      drivers/acpi/pci_root.o
>   CC      drivers/acpi/pci_link.o
>   CC      drivers/acpi/pci_irq.o
>   CC      drivers/acpi/pci_bind.o
>   CC      drivers/acpi/power.o
>   CC      drivers/acpi/system.o
>   CC      drivers/acpi/event.o
> drivers/acpi/event.c:243: error: 'acpi_generate_netlink_event' undecl=
ared here (not in a function)
> drivers/acpi/event.c:243: warning: type defaults to 'int' in declarat=
ion of 'acpi_generate_netlink_event'
> make[2]: *** [drivers/acpi/event.o] Error 1
> make[1]: *** [drivers/acpi] Error 2
> make: *** [drivers] Error 2
>=20
> The build was made with :
> $> make mrproper && make rndconfig && <tweak config file> && make old=
config && make

This is due to CONFIG_NET=3Dn, which Henrique fixed last week
and will be in -rc6.

thanks,
-Len

commit 66baf327ae5d4c17e75d1f501145e79eaeeaf649
Author: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date:   Mon Sep 3 00:03:35 2007 -0300

    ACPI: fix CONFIG_NET=3Dn acpi_bus_generate_netlink_event build fail=
ure
   =20
    drivers/acpi/event.c:243: error: 'acpi_generate_netlink_event' unde=
clared
    here (not in a function)
   =20
    Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/drivers/acpi/event.c b/drivers/acpi/event.c
index a2b9304..5c95863 100644
--- a/drivers/acpi/event.c
+++ b/drivers/acpi/event.c
@@ -240,7 +240,7 @@ int acpi_bus_generate_netlink_event(const char *dev=
ice_class,
 	return 0;
 }
=20
-EXPORT_SYMBOL(acpi_generate_netlink_event);
+EXPORT_SYMBOL(acpi_bus_generate_netlink_event);
=20
 static int acpi_event_genetlink_init(void)
 {

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
