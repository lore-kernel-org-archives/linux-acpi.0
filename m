From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 00/10] acpi4asus updates (eeepc-laptop, asus_acpi and asus-laptop)
Date: Tue, 20 Jan 2009 16:17:39 +0100
Message-ID: <1232464669-29619-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:59548 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756673AbZATPRy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jan 2009 10:17:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Corentin Chary <corentincj@iksaif.net>

Hi len,
Here is a group of update for asus related platform drivers.
You can also pull  git://git.iksaif.net/acpi4asus.git acpi4asus
Thanks

Corentin Chary (7):
  eeepc-laptop: split eeepc_backlight_exit()
  asus_acpi: Add R1F support
  asus-laptop: use generic netlink interface
  asus-laptop: hotkeys via the generic input interface
  asus-laptop: update Kconfig for input layer
  asus-laptop: fix label indentation
  eeepc-laptop: use netlink interface

Matthew Garrett (3):
  eeepc-laptop: Add support for extended hotkeys
  eeepc-laptop: Check return values from rfkill_register
  eeepc-laptop: Implement rfkill hotplugging in eeepc-laptop

 drivers/platform/x86/Kconfig        |    1 +
 drivers/platform/x86/asus-laptop.c  |  176 ++++++++++++++++++++++++++++++++--
 drivers/platform/x86/asus_acpi.c    |   16 +++-
 drivers/platform/x86/eeepc-laptop.c |  161 ++++++++++++++++++++++++++++----
 4 files changed, 323 insertions(+), 31 deletions(-)

