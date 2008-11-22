From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi queue for the next merge window
Date: Sat, 22 Nov 2008 09:48:42 -0200
Message-ID: <1227354533-19788-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40657 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757348AbYKVLs6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Nov 2008 06:48:58 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org


Len,

This patchset contains the queue of changes for thinkpad-acpi, for the
next merge window (2.6.29).  Please merge for acpi-test.

ATTENTION: the very first patch is something that fixes a *tracked*
regression on 2.6.28, and it really should go to Linus as soon as
possible.  Since I have pinged you two times already about it without
any reply, I am ALSO including it on this batch.

As usual, available for git pull from:                                                                                                               
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test                                                                    

Shortlog:

Henrique de Moraes Holschuh (10):
      ACPI: thinkpad-acpi: fix fan sleep/resume path
      ACPI: thinkpad-acpi: debug facility to emulate the rf switches
      ACPI: thinkpad-acpi: resume with radios disabled
      ACPI: thinkpad-acpi: preserve radio state across shutdown
      ACPI: thinkpad-acpi: add UWB radio support
      ACPI: thinkpad-acpi: use killable instead of interruptible mutexes
      ACPI: thinkpad-acpi: clean up hotkey_notify()
      ACPI: thinkpad-acpi: handle HKEY thermal and battery alarms
      ACPI: thinkpad-acpi: start the event hunt season
      ACPI: thinkpad-acpi: clean-up fan subdriver quirk

Kay Sievers (1):
      ACPI: thinkpad-acpi: struct device - replace bus_id with dev_name(), dev_set_name()

Thank you!

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
