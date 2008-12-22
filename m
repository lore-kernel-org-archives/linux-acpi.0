From: Len Brown <lenb@kernel.org>
Subject: Git PULL ACPI patches for 2.6.28-rc9
Date: Mon, 22 Dec 2008 17:44:51 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812221741530.20902@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:42365 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560AbYLVWpF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Dec 2008 17:45:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release

This will fix two regressions, and update the files shown below.

thanks!

--
Len Brown
Intel Open Source Technology Center


ps. individual patches are available on linux-acpi@vger.kernel.org
and a consolidated plain patch is available here:
ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.28/acpi-release-20081031-2.6.28-rc9.diff.gz

 Documentation/kernel-parameters.txt |   11 +++++++----
 drivers/acpi/bus.c                  |    8 --------
 drivers/acpi/utilities/utglobal.c   |    2 +-
 include/acpi/acoutput.h             |    2 +-
 include/acpi/platform/aclinux.h     |    6 +++++-
 5 files changed, 14 insertions(+), 15 deletions(-)

through these commits:

Bjorn Helgaas (1):
      ACPI: fix 2.6.28 acpi.debug_level regression

Wu Fengguang (1):
      ACPI: don't cond_resched() when irqs_disabled()

with this log:

commit abe1dfab60e1839d115930286cb421f5a5b193f3
Author: Wu Fengguang <fengguang.wu@intel.com>
Date:   Wed Nov 26 14:35:22 2008 +0800

    ACPI: don't cond_resched() when irqs_disabled()
    
    The ACPI interpreter usually runs with irqs enabled.
    However, during suspend/resume it runs with
    irqs disabled to evaluate _GTS/_BFS, as well as
    by irqrouter_resume() which evaluates _CRS, _PRS, _SRS.
    
    http://bugzilla.kernel.org/show_bug.cgi?id=12252
    
    Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

commit e76f42761197dd6e9405e2eeb35932acfede115a
Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
Date:   Thu Nov 13 17:30:13 2008 -0600

    ACPI: fix 2.6.28 acpi.debug_level regression
    
    acpi_early_init() was changed to over-write the cmdline param,
    making it really inconvenient to set debug flags at boot-time.
    
    Also,
    This sets the default level to "info", which is what all the ACPI
    drivers use.  So to enable messages from drivers, you only have to
    supply the "layer" (a.k.a. "component").  For non-"info" ACPI core
    and ACPI interpreter messages, you have to supply both level and
    layer masks, as before.
    
    Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
    Signed-off-by: Len Brown <len.brown@intel.com>
