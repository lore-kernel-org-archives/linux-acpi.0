From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI: Fix build errors due objects compiled unconditionally
Date: Thu, 10 Dec 2015 00:13:22 +0100
Message-ID: <12725891.QmF251BB6I@vostro.rjw.lan>
References: <1448040902-1349-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:45903 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750904AbbLIWnX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Dec 2015 17:43:23 -0500
In-Reply-To: <1448040902-1349-1-git-send-email-javier@osg.samsung.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Al Stone <al.stone@linaro.org>, Len Brown <lenb@kernel.org>

On Friday, November 20, 2015 02:35:02 PM Javier Martinez Canillas wrote:
> If the CONFIG_ACPI Kconfig symbol is not enabled and a partial build is
> attempted, compile errors will happen due missing types and identifiers.
> 
> This can be easily reproduced with the following commands:
> 
> $ export CROSS_COMPILE="arm-linux-gnueabihf-" ARCH=arm
> $ make allmodconfig
> $ make M=drivers/acpi/
>   CC      drivers/acpi//tables.o
> drivers/acpi//tables.c:235:3: warning: 'struct acpi_subtable_proc' declared inside parameter list
>    unsigned int max_entries)
>    ^
> drivers/acpi//tables.c:235:3: warning: its scope is only this definition or declaration, which is probably not what you want
> drivers/acpi//tables.c: In function 'acpi_parse_entries_array':
> drivers/acpi//tables.c:269:4: error: invalid use of undefined type 'struct acpi_subtable_proc'
> ...
> scripts/Makefile.build:258: recipe for target 'drivers/acpi//tables.o' failed
> make[1]: *** [drivers/acpi//tables.o] Error 1
> Makefile:1401: recipe for target '_module_drivers/acpi/' failed
> make: *** [_module_drivers/acpi/] Error 2
> 
> This is because objects are tried to be built unconditionally even when
> CONFIG_ACPI is not enabled. This is usually not a problem since arches'
> Kconfig sources drivers/acpi/Kconfig directly and also selects ACPI but
> the Makefile should conditionally build the objects as well to prevent
> these build errors.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

OK, I think this shouldn't hurt anyone.

Queued up for 4.5, thanks!

Rafael

