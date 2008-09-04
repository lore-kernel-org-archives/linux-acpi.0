From: Andi Kleen <andi@firstfloor.org>
Subject: Please pull ACPI fixes for 2.6.27
Date: Thu, 4 Sep 2008 21:26:08 +0200
Message-ID: <20080904192608.GA23235@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:46768 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753689AbYIDT0J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2008 15:26:09 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: torvalds@osdl.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org


Linus,

Please pull the latest ACPI fixes from

  git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-2.6 release-2.6.27

This is mostly various small bug fixes, mostly regression fixes, and a 
few minor other fixes.

Also change the ACPI MAINTAINERS entry again back to Len Brown, since he's
back from his sabbatical. This should be my last ACPI merge.

-Andi

Andi Kleen (1):
      ACPI: Make Len Brown the ACPI maintainer again

Bjorn Helgaas (1):
      PNPACPI: ignore the producer/consumer bit for extended IRQ descriptors

Cyrill Gorcunov (1):
      acpi: add checking for NULL early param

Dennis Jansen (1):
      ACPI: Fix typo in "Disable MWAIT via DMI on broken Compal board"

Huang Weiyi (1):
      removed unused #include <version.h>

Jeremy Fitzhardinge (1):
      ACPI: thinkpad-acpi: wan radio control is not experimental

Jonathan Woithe (1):
      fujitsu-laptop: fix regression for P8010 in 2.6.27-rc

Milan Broz (1):
      ACPI: Fix now signed module parameter.

Ming Ling (1):
      ACPI: Change package length error to warning

Russ Dill (1):
      acer-wmi: remove debugfs entries upon unloading

Zhao Yakui (1):
      ACPI: Avoid bogus timeout about SMbus check

 Documentation/laptops/thinkpad-acpi.txt    |   11 +++--------
 MAINTAINERS                                |    3 +--
 drivers/acpi/dispatcher/dsobject.c         |    2 +-
 drivers/acpi/processor_core.c              |    2 +-
 drivers/acpi/processor_perflib.c           |    2 +-
 drivers/acpi/sbshc.c                       |    7 +++++++
 drivers/acpi/tables.c                      |    2 ++
 drivers/char/pcmcia/ipwireless/tty.c       |    1 -
 drivers/char/synclink_gt.c                 |    1 -
 drivers/char/xilinx_hwicap/xilinx_hwicap.c |    1 -
 drivers/misc/acer-wmi.c                    |    3 ++-
 drivers/misc/fujitsu-laptop.c              |    7 +++++++
 drivers/misc/thinkpad_acpi.c               |    1 -
 drivers/pnp/pnpacpi/rsparser.c             |    2 --
 14 files changed, 25 insertions(+), 20 deletions(-)
-- 
ak@linux.intel.com
