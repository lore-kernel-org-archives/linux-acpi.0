From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: acpi-test tree build failure
Date: Sat, 11 Oct 2008 10:47:09 +0100
Message-ID: <48F0761D.9060209@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:16130 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbYJKJrQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Oct 2008 05:47:16 -0400
Received: by ey-out-2122.google.com with SMTP id 6so354808eyi.37
        for <linux-acpi@vger.kernel.org>; Sat, 11 Oct 2008 02:47:13 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

I tried acpi-test to see how it works on my EeePC (with the nasty EC),
but the build fails, complaining about a non-existent file...

    $ make ARCH=i386 oldconfig
    scripts/kconfig/conf -o arch/x86/Kconfig
    arch/x86/Kconfig:1539: can't open file "drivers/idle/Kconfig"
    make[1]: *** [oldconfig] Error 1
    make: *** [oldconfig] Error 2

I can see where the reference to drivers/idle was added, so I've
reverted it locally.  I hope I'm not looking at the wrong tree or
something :-).

Ta,
Alan



commit e8b529091b2ab65f5a4783e292c2b472e309116e
Author: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Date:   Thu Oct 9 11:45:22 2008 -0700

    i7300_idle driver v1.55

    The Intel 7300 Memory Controller supports dynamic throttling of
memory which can
    be used to save power when system is idle. This driver does the memory
    throttling when all CPUs are idle on such a system.

    Refer to "Intel 7300 Memory Controller Hub (MCH)" datasheet
    for the config space description.

    Signed-off-by: Andy Henroid <andrew.d.henroid@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>
    Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ed92864..19cdfe1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1536,6 +1536,8 @@ source "arch/x86/kernel/cpu/cpufreq/Kconfig"

 source "drivers/cpuidle/Kconfig"

+source "drivers/idle/Kconfig"
+
 endmenu

