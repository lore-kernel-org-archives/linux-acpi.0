From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi patches for 2.6.24-rc
Date: Tue, 30 Oct 2007 17:46:18 -0200
Message-ID: <1193773585-17202-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44102 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755880AbXJ3Tqb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2007 15:46:31 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Len,

Here is a bunch of thinkpad-acpi changes that fixes some bugs and add key
thinkpad models support that should, if at all possible, be merged for
2.6.24.

They are really important for ThinkPad X60, T61 and R61 users, and the
first patch unbreaks the ThinkPad ACPI hotkey map in all IBM ThinkPads on
several distros.

Please consider sending this patch set to Linus for merging after -rc2 is
out.

All patches in it have been tested, and all comments the individual patches
received (some of them are not new) have been addressed.

As usual, the patch set is available at:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-release

Shortlog of the above branch:

Henrique de Moraes Holschuh (7):
      ACPI: thinkpad-acpi: revert keymap changes
      ACPI: thinkpad-acpi: support 16 levels of brightness (v3)
      ACPI: thinkpad-acpi: add brightness_force parameter
      ACPI: thinkpad-acpi: prefer standard ACPI backlight level control
      ACPI: thinkpad-acpi: bump up version to 0.17
      ACPI: thinkpad-acpi: allow for syscall restart in sysfs handlers
      ACPI: thinkpad-acpi: fix brightness_set error paths

Thanks.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
