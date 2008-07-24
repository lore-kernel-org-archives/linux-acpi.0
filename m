From: Andi Kleen <andi@firstfloor.org>
Subject: Please pull ACPI updates
Date: Thu, 24 Jul 2008 22:36:36 +0200
Message-ID: <20080724203636.GA22485@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out01.alice-dsl.net ([88.44.60.11]:55531 "EHLO
	smtp-out01.alice-dsl.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751244AbYGXUhG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Jul 2008 16:37:06 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: torvalds@osdl.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


Linus,

Please pull ACPI updates from 

  git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-2.6.git release-2.6.27

which contains

Andi Kleen (5):
      Revert "Fix FADT parsing"
      Revert "dock: bay: Don't call acpi_walk_namespace() when ACPI is disabled."
      Merge branch 'merge' into release-2.6.27
      Revert "ACPI: don't walk tables if ACPI was disabled"
      Merge branch 'for-upstream/acpi-test' of git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6 into release-2.6.27

Bjorn Helgaas (1):
      ACPI: stop complaints about interrupt link End Tags and blank IRQ descriptors

Henrique de Moraes Holschuh (7):
      ACPI: thinkpad-acpi: minor refactor on radio switch init
      ACPI: thinkpad-acpi: consolidate wlsw notification function
      ACPI: thinkpad-acpi: prepare for bluetooth and wwan rfkill support
      ACPI: thinkpad-acpi: WLSW overrides other rfkill switches
      ACPI: thinkpad-acpi: add bluetooth and WWAN rfkill support
      ACPI: thinkpad-acpi: bump up version to 0.21
      ACPI: thinkpad-acpi: don't misdetect in get_thinkpad_model_data() on -ENOMEM

Ingo Molnar (1):
      acpi: fix crash in core ACPI code, triggered by CONFIG_ACPI_PCI_SLOT=y

Zhao Yakui (2):
      ACPI: Ignore _BQC object when registering backlight device
      ACPI : Set FAN device to correct state in boot phase

 Documentation/laptops/thinkpad-acpi.txt |   26 ++-
 drivers/acpi/namespace/nsnames.c        |    8 +
 drivers/acpi/pci_link.c                 |   31 ++-
 drivers/acpi/tables/tbfadt.c            |   17 +-
 drivers/acpi/thermal.c                  |   43 +++
 drivers/acpi/utilities/utalloc.c        |    4 +
 drivers/acpi/video.c                    |   14 +-
 drivers/misc/Kconfig                    |    2 +
 drivers/misc/thinkpad_acpi.c            |  475 ++++++++++++++++++++++---------
 9 files changed, 446 insertions(+), 174 deletions(-)
