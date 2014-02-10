From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH v3 0/3] Prepare for running ACPI on !x86 and !ia64
Date: Mon, 10 Feb 2014 15:48:59 +0800
Message-ID: <1392018542-10949-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:43116 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbaBJHtn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Feb 2014 02:49:43 -0500
Received: by mail-pb0-f49.google.com with SMTP id up15so5894815pbc.22
        for <linux-acpi@vger.kernel.org>; Sun, 09 Feb 2014 23:49:42 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lan Tianyu <tianyu.lan@intel.com>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

Some of the ACPI code is arch-dependent and make the code can't be
compiled on !x86 or !ia64, the first two patches just do some rework
on the idle_boot_override and _PDC related stuff to make the ACPI
code more arch-independent.

The third patch just introduce map_gic_id() for ACPI processor core
followed the ACPI 5.0 spec.

I have compiled the kernel successfully after appling this patch set
on x86 and ia64.

Changes for v3:
Fix the issues pointed out by Lan Tianyu and and the Reviewed-by for
first patch.

Changes for v2:
a) add #if defined(CONFIG_X86) || defined(CONFIG_IA64) for
   idle_boot_override related code;
b) Rebased on 3.14-rc1.

Changes since the RFC version:
a) Remove the RFC tag;
b) Move idle_boot_override out of the arch directory suggested
   by Alan;
c) Make these 3 patches as a separate patch set since there are
   not not related to the ARM/ARM64 platform.

Hanjun Guo (3):
  ACPI / idle: Make idle_boot_override depend on x86 and ia64
  ACPI / processor_core: Rework _PDC related stuff to make it more
    arch-independent
  ACPI: Introduce map_gic_id() to get apic id from MADT or _MAT method

 arch/ia64/include/asm/acpi.h  |    5 +--
 arch/ia64/kernel/acpi.c       |   17 +++++++++
 arch/x86/include/asm/acpi.h   |   19 +--------
 arch/x86/kernel/acpi/cstate.c |   31 +++++++++++++++
 drivers/acpi/processor_core.c |   85 ++++++++++++++++++++++++-----------------
 5 files changed, 99 insertions(+), 58 deletions(-)

-- 
1.7.9.5

