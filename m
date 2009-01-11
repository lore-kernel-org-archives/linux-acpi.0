From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH][REPOST] thinkpad-acpi queue for 2.6.29
Date: Sun, 11 Jan 2009 03:00:57 -0200
Message-ID: <1231650070-21722-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38329 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750893AbZAKFBP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Jan 2009 00:01:15 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Len,

This is a repost of the thinkpad-acpi queue.  I sent it to you on
2008-11-22, but apparently it fell through the cracks...

The patchset was rebased to apply on top of 2.6.29-rc1.

Patches 1, 12 and 13 are new, but they are trivial.

Please, if at all possible, send it to Linus for 2.6.29 merging.

As usual, available for git pull from:                                                                                                               
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test                                                                    

Shortlog:

Henrique de Moraes Holschuh (12):
      ACPI: thinkpad-acpi: update documents for the new location
      ACPI: thinkpad-acpi: debug facility to emulate the rf switches
      ACPI: thinkpad-acpi: resume with radios disabled
      ACPI: thinkpad-acpi: preserve radio state across shutdown
      ACPI: thinkpad-acpi: add UWB radio support
      ACPI: thinkpad-acpi: use killable instead of interruptible mutexes
      ACPI: thinkpad-acpi: clean up hotkey_notify()
      ACPI: thinkpad-acpi: handle HKEY thermal and battery alarms
      ACPI: thinkpad-acpi: start the event hunt season
      ACPI: thinkpad-acpi: clean-up fan subdriver quirk
      ACPI: thinkpad-acpi: handle HKEY event 6030
      ACPI: thinkpad-acpi: bump up version to 0.22

Kay Sievers (1):
      ACPI: thinkpad-acpi: struct device - replace bus_id with dev_name(), dev_set_name()

Thank you!

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
