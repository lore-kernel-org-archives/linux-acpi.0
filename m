From: mel@skynet.ie (Mel Gorman)
Subject: Re: 2.6.23-rc6-mm1
Date: Tue, 18 Sep 2007 19:05:25 +0100
Message-ID: <20070918180525.GD1804@skynet.ie>
References: <20070918011841.2381bd93.akpm@linux-foundation.org> <a44ae5cd0709181020p65635567k3ac67f47f852a9b9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gir.skynet.ie ([193.1.99.77]:46517 "EHLO gir.skynet.ie"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756275AbXIRSGa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Sep 2007 14:06:30 -0400
Content-Disposition: inline
In-Reply-To: <a44ae5cd0709181020p65635567k3ac67f47f852a9b9@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Miles Lane <miles.lane@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On (18/09/07 13:20), Miles Lane didst pronounce:
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `acpi_ac_remove':
> ac.c:(.text+0x3eeec): undefined reference to `power_supply_unregister'
> drivers/built-in.o: In function `acpi_ac_add':
> ac.c:(.text+0x3f10b): undefined reference to `power_supply_register'
> make: *** [.tmp_vmlinux1] Error 1
> 

Hi Miles,

The problem appears to be that ACPI_AC is compiled in but POWER_SUPPLY is
a module. You could workaround it by making them both modules but I believe
the root cause may be a dependency problem. I've included a patch below that
when you apply and run make oldconfig should allow you to build your kernel.

ACPI folks, is this a fix? If so, there may be other dependency issues that
allow a compiled-in feature to depend on a module.

Signed-off-by: Mel Gorman <mel@csn.ul.ie>

---
 Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -rup -X /usr/src/patchset-0.6/bin//dontdiff linux-2.6.23-rc6-mm1-015_fix_ia64_kgdb/drivers/acpi/Kconfig linux-2.6.23-rc6-mm1-020_fix_acpi/drivers/acpi/Kconfig
--- linux-2.6.23-rc6-mm1-015_fix_ia64_kgdb/drivers/acpi/Kconfig	2007-09-11 03:50:29.000000000 +0100
+++ linux-2.6.23-rc6-mm1-020_fix_acpi/drivers/acpi/Kconfig	2007-09-18 19:03:32.000000000 +0100
@@ -88,7 +88,7 @@ config ACPI_PROC_EVENT
 
 config ACPI_AC
 	tristate "AC Adapter"
-	depends on X86
+	depends on X86 && POWER_SUPPLY
 	default y
 	help
 	  This driver adds support for the AC Adapter object, which indicates
