From: Andrew Morton <akpm@linux-foundation.org>
Subject: Fw: Re: [PATCH 1/5] RT kernel: force detect HPET from PCI space
Date: Sat, 31 Mar 2007 12:14:18 -0700
Message-ID: <20070331121418.c2b45ecd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:33207 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170AbXCaTO2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 31 Mar 2007 15:14:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Mikko Tiihonen <mikko.tiihonen@iki.fi>


I assume this is an acpi table bug.

Is there any way in which we can get a workaround in place to fix this for real?


Begin forwarded message:

Date: Sat, 31 Mar 2007 18:00:34 +0300 (EEST)
From: Mikko Tiihonen <mikko.tiihonen@iki.fi>
To: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, linux-kernel@vger.kernel.org, ranma@tdiedrich.de, om.turyx@gmail.com
Subject: Re: [PATCH 1/5] RT kernel: force detect HPET from PCI space




On Sat, 31 Mar 2007, Nicolas Mailhot wrote:

> [adding some people in CC that expressed interest in the problem before]
>
> I'm crazy enough to test a patch if someone cooks it, but I'm way out of
> my depth there :)

After struggling with totally broken kernels for the whole morning I got the 
HPET to work with my NForce4 with the following hard coded ACPI quirk. My 
machine has been now stable for few hours and I tested that the HPET really 
seems to be working by switching the clock source using

echo hpet|tsc|acpi_pm > /sys/devices/system/clocksource/clocksource0/current_clocksource

Results of a simple benchmark show that the time to execute gettimeofday 
really varies based on the clock source: (performance normalised to tsc)
tsc:      1x
hpet:     4x
acpi_pm: 12x

At least on my motherboard it seems to be enough to just grab the HPET address 
from the lspci output and not bother with any of the other changing bits.

--- linux-2.6.21-rc5-git5/arch/i386/kernel/acpi/boot.c	2007-03-31 17:49:24.000000000 +0300
+++ linux-2.6.21-rc5-git5.hpet/arch/i386/kernel/acpi/boot.c	2007-03-31 17:02:27.000000000 +0300
@@ -1189,6 +1189,8 @@ int __init acpi_boot_table_init(void)

  int __init acpi_boot_init(void)
  {
+        struct acpi_table_hpet hpet_tbl;
+
  	/*
  	 * If acpi_disabled, bail out
  	 * One exception: acpi=ht continues far enough to enumerate LAPICs
@@ -1208,7 +1210,12 @@ int __init acpi_boot_init(void)
  	 */
  	acpi_process_madt();

-	acpi_table_parse(ACPI_SIG_HPET, acpi_parse_hpet);
+	hpet_tbl.address.address = 0xfefff000L;
+	hpet_tbl.address.space_id = ACPI_SPACE_MEM;
+	hpet_tbl.sequence = 0;
+	hpet_tbl.id = 0xbabe;
+        acpi_parse_hpet((struct acpi_table_header *) &hpet_tbl);
+	//	acpi_table_parse(ACPI_SIG_HPET, acpi_parse_hpet);

  	return 0;
  }

-Mikko
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
