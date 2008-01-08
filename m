From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi patches for 2.6.25 (replaces batch 1)
Date: Tue,  8 Jan 2008 13:02:37 -0200
Message-ID: <1199804577-32017-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:52405 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752349AbYAHPDF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Jan 2008 10:03:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org


Len,

This patchset has my current thinkpad-acpi queue.  The target is 2.6.25.

This set *replaces* the previous batch 1 I sent. I have changed a few of the
patches, and added a few new ones in different points of the stack.   It is
simpler to just resubmit them all than to ask you to replace this-and-that
patch in various points of the stack :)

As usual, the patch set is available at:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test

The branch root is latest Linus' tree.

Shortlog of the above branch:

Henrique de Moraes Holschuh (20):
      ACPI: thinkpad-acpi: document keymap gotcha's (v2)
      ACPI: thinkpad-acpi: refactor hotkey_get and hotkey_set (v2)
      ACPI: thinkpad-acpi: prepare for NVRAM polling support
      ACPI: thinkpad-acpi: add CMOS NVRAM polling for hot keys (v9)
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
      ACPI: thinkpad-acpi: add X61t HKEY events
      ACPI: thinkpad-acpi: silence _sta warning
      ACPI: thinkpad-acpi: add poll() support to some sysfs attributes
      ACPI: thinkpad-acpi: update copyright dates to 2008
      ACPI: thinkpad-acpi: bump up version to 0.19

Please merge for acpi-test.

Thanks.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
