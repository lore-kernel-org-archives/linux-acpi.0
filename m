From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi patches for 2.6.25 (batch 1)
Date: Thu, 15 Nov 2007 01:36:47 -0200
Message-ID: <1195097822-24738-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47054 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754567AbXKODhK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Nov 2007 22:37:10 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Len,

This patchset has most of my current thinkpad-acpi queue.  The target is
2.6.25, I am submitting they early for testing in acpi-test.

As usual, the patch set is available at:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test

The branch root is latest Linus' tree.

Shortlog of the above branch:

(these have been sent already, for 2.6.24-rc2)
      ACPI: thinkpad-acpi: revert keymap changes
      ACPI: thinkpad-acpi: support 16 levels of brightness (v3)
      ACPI: thinkpad-acpi: add brightness_force parameter
      ACPI: thinkpad-acpi: prefer standard ACPI backlight level control
      ACPI: thinkpad-acpi: bump up version to 0.17
      ACPI: thinkpad-acpi: allow for syscall restart in sysfs handlers
      ACPI: thinkpad-acpi: fix brightness_set error paths

(these are new ones, for 2.6.25)
      ACPI: thinkpad-acpi: refactor hotkey_get and hotkey_set
      ACPI: thinkpad-acpi: prepare for NVRAM polling support
      ACPI: thinkpad-acpi: add CMOS NVRAM polling for hot keys (v6)
      ACPI: thinkpad-acpi: let threads be frozen
      ACPI: thinkpad-acpi: bump up version to 0.18
      ACPI: thinkpad-acpi: spring cleanup part 1
      ACPI: thinkpad-acpi: spring cleanup part 2
      ACPI: thinkpad-acpi: spring cleanup part 3
      ACPI: thinkpad-acpi: spring cleanup part 4
      ACPI: thinkpad-acpi: module glue cleanups
      ACPI: thinkpad-acpi: rename IBM in defines
      ACPI: thinkpad-acpi: some checkpatch.pl fluff
      ACPI: thinkpad-acpi: add suspend handler
      ACPI: thinkpad-acpi: cleanup hotkey_notify and HKEY log messages
      ACPI: thinkpad-acpi: wakeup on hotunplug reporting

Please merge for acpi-test.

Thanks.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
