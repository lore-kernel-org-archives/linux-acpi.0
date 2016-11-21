From: Vegard Nossum <vegard.nossum@gmail.com>
Subject: undefined reference to `devm_watchdog_register_device'
Date: Mon, 21 Nov 2016 10:07:05 +0100
Message-ID: <CAOMGZ=EuLB0=HwGcMXj0=gP2Av_sCVg-pm_b5cGeYHnZwhqY0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:36125 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbcKUJHH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Nov 2016 04:07:07 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, rafael@kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi,

I updated my config and set CONFIG_WDAT_WDT=y, got this:

drivers/built-in.o: In function `wdat_wdt_probe':
/home/vegard/linux/drivers/watchdog/wdat_wdt.c:444: undefined
reference to `devm_watchdog_register_device'
Makefile:962: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Looks like it's missing a select for WATCHDOG_CORE in the Kconfig?


Vegard
