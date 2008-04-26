From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi queue for the 2.6.26 merge window (v2)
Date: Sat, 26 Apr 2008 01:02:16 -0300
Message-ID: <1209182550-32725-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:58879 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750698AbYDZECe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Apr 2008 00:02:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Len,

This patchset has my current thinkpad-acpi queue.  The target is 2.6.26's
merge window.

Some of the thinkpad-acpi patches require patches from Richard Purdie's LED
tree that have been recently merged in mainline.

As usual, the patch set is available at:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test

Shortlog:

Henrique de Moraes Holschuh (14):
      ACPI: thinkpad-acpi: BIOS backlight mode helper (v2.1)
      ACPI: thinkpad-acpi: warn once about weird hotkey masks
      ACPI: thinkpad-acpi: enhance box identification output (v2)
      ACPI: thinkpad-acpi: rate-limit CMOS/EC unsynced error messages
      ACPI: thinkpad-acpi: fix brightness dimming control bug
      ACPI: thinkpad-acpi: claim tpacpi as an official short handle (v1.1)
      ACPI: thinkpad-acpi: prepare light and LED for sysfs support
      ACPI: thinkpad-acpi: add sysfs led class support for thinklight (v3.1)
      ACPI: thinkpad-acpi: add sysfs led class support to thinkpad leds (v3.2)
      ACPI: thinkpad-acpi: use uppercase for "LED" on user documentation
      ACPI: thinkpad-acpi: fluff really minor fix
      ACPI: thinkpad-acpi: use a private workqueue
      ACPI: thinkpad-acpi: fix selects in Kconfig
      ACPI: thinkpad-acpi: bump up version to 0.20

Please merge the thinkpad-acpi changesets for acpi-test, for submission in
the currently open mainline merge window.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
