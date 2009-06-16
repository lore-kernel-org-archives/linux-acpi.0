From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 00/15] acpi4asus updates
Date: Tue, 16 Jun 2009 21:28:41 +0200
Message-ID: <1245180536-28009-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:60957 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505AbZFPTbW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Jun 2009 15:31:22 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Hi Len,
It's mainly new features for eeepc-laptop and bugfix.

There is also some change for asus-laptop, which is no
longer marked as EXPERIMENTAL, when asus_acpi is now
DEPRECATED.

You can directly pull from the git tree if you want
  git://git.iksaif.net/acpi4asus.git for-next

Thanks

Corentin Chary (11):
  asus-laptop: platform dev as parent for led and backlight
  acpi4asus: update MAINTAINER and KConfig links
  asus_acpi: Deprecate in favor of asus-laptop
  asus-laptop: use pr_fmt and pr_<level>
  eeepc-laptop: rfkill refactoring
  eeepc-laptop: right parent device
  eeepc-laptop: sync eeepc-laptop with asus_acpi
  eeepc-laptop: makes get_acpi() returns -ENODEV
  eeepc-laptop: get the right value for CMSG
  eeepc-laptop: add rfkill support for the 3G modem in Eee PC 901 Go
  eeepc-laptop: cpufv updates

Joe Perches (1):
  eeepc-laptop.c: use pr_fmt and pr_<level>

Matthew Garrett (1):
  eeepc-laptop: Register as a pci-hotplug device

Pekka Enberg (1):
  eeepc-laptop: enable camera by default

Randy Dunlap (1):
  eeepc: fix kconfig selects

 MAINTAINERS                         |    8 +-
 drivers/platform/x86/Kconfig        |   17 +-
 drivers/platform/x86/asus-laptop.c  |   92 ++++----
 drivers/platform/x86/eeepc-laptop.c |  502 +++++++++++++++++++++++++----------
 4 files changed, 428 insertions(+), 191 deletions(-)

