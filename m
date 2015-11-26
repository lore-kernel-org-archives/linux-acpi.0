From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/7] ACPI / LPSS: fix system hangup on BYT/BSW/CHT
Date: Thu, 26 Nov 2015 17:19:06 +0200
Message-ID: <1448551153-84719-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9601 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbbKZPTS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Nov 2015 10:19:18 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Here is a next generation (previous one is [1]) of the long standing power
issue fix regarding to LPSS on Intel Baytrail and Braswell SoCs, in
particularly ASuS T100TA. There are few bugs already opened on kernel.org's and
RedHat's bugzilla sites.

The series depends on the patch submitted earlier [2].

The patch 1 brings a new notification to handle the case when ->probe() of the
driver fails. It allows to avoid a potential resource leak. I've noticed couple
of drivers that are using that in assumption that ->probe() never fails.

The patch 2 is needed to fix an I2C issue which Jarkko is currently
investigating.

It seems the best way to push it through linux-pm tree. Thus, it would be good
to get ACKs from the rest of maintainers.

Rafael, it would be nice to have an immutable branch or tag for this sice I
have more patches coming for dw_dmac driver which are based on top of this
series.

The patches have been tested on ASuS T100TA, Intel Cherrytrail, and Intel
Braswell SoCs.

[1] http://www.spinics.net/lists/linux-acpi/msg53963.html
[2] http://www.spinics.net/lists/kernel/msg2119229.html

Andy Shevchenko (7):
  device core: add BUS_NOTIFY_BIND_DRIVER_ERROR notification
  ACPI / LPSS: allow to use specific PM domain during ->probe()
  ACPI / LPSS: do delay for all LPSS devices when D3->D0
  ACPI / LPSS: override power state for LPSS DMA device
  dmaengine: dw: platform: power on device on shutdown
  dmaengine: dw: return immediately from IRQ when DMA isn't in use
  Revert "dmaengine: dw: platform: provide platform data for Intel"

 arch/x86/Kconfig                |   3 +-
 arch/x86/include/asm/iosf_mbi.h |   2 +
 drivers/acpi/acpi_lpss.c        | 184 ++++++++++++++++++++++++++++++++++++----
 drivers/base/dd.c               |   8 +-
 drivers/dma/dw/core.c           |   9 +-
 drivers/dma/dw/platform.c       |  29 +++----
 include/linux/device.h          |   1 +
 7 files changed, 198 insertions(+), 38 deletions(-)

-- 
2.6.2

