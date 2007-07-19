From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PULL] thinkpad-acpi queue for 2.6.23 (v3)
Date: Wed, 18 Jul 2007 23:45:25 -0300
Message-ID: <11848131483573-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:53077 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754260AbXGSCpy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jul 2007 22:45:54 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org


Len,

Please pull from:                                                                                                                                     
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test                                                                     

to receive the main batch of thinkpad-acpi changes for the merge window, now
rebased to apply on top of v2.6.22, with changes based on the comments I
received when I posted v2 of this queue.

It replaces all the other patches I sent you (none were merged yet, AFAIK).

Henrique de Moraes Holschuh (23):
      ACPI: thinkpad-acpi: add DMI-based modalias
      ACPI: thinkpad-acpi: remove all uneeded initializers
      ACPI: thinkpad-acpi: update information on T43 thermal sensor 0xc1
      ACPI: thinkpad-acpi: enable more hotkeys
      ACPI: thinkpad-acpi: export hotkey maximum masks
      ACPI: thinkpad-acpi: export to sysfs the state of the radio slider switch
      ACPI: thinkpad-acpi: checkpoint sysfs interface version due to hotkey
      ACPI: thinkpad-acpi: update CMOS commands documentation
      ACPI: thinkpad-acpi: register input device
      ACPI: thinkpad-acpi: add input device support to hotkey subdriver
      ACPI: thinkpad-acpi: make the input event mode the default
      ACPI: thinkpad-acpi: add power-management handler capability
      ACPI: thinkpad-acpi: export EV_SW SW_RADIO events
      ACPI: thinkpad-acpi: checkpoint sysfs interface version due to input layer
      ACPI: thinkpad-acpi: rename pci HID constant
      ACPI: thinkpad_acpi: use bool for boolean parameters
      ACPI: thinkpad-acpi: store ThinkPad model information
      ACPI: thinkpad-acpi: allow use of CMOS NVRAM for brightness control
      ACPI: thinkpad-acpi: react to Lenovo ThinkPad differences in hot key
      ACPI: thinkpad-acpi: make sure DSDT TMPx readings don't return +128
      ACPI: thinkpad-acpi: make EC-based thermal readings non-experimental
      ACPI: thinkpad-acpi: bump up version to 0.15
      ACPI: thinkpad-acpi: add locking to brightness subdriver

These changes are composed mainly of the first part of the effort to move all
the hot keys functionality to the input layer, plus some fixes.

All these patches are targetted to 2.6.23's merge window.  Please merge for
acpi-test.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
