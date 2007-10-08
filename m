From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH v2] thinkpad-acpi changes for the merge window (part 2)
Date: Mon,  8 Oct 2007 10:12:55 -0300
Message-ID: <1191849179-24087-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50182 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753434AbXJHNNH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Oct 2007 09:13:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org


(resending, I missed one patch in the series. Sorry about that)

Len,                                                                                                                                                  

Here is the second batch of thinkpad-acpi changes for the merge window (target:
2.6.24).  There will probably be a third batch later, I am waiting some reports
from testers.

This batch improves brightness support on Lenovo ThinkPads, and also disables
said support by default in any notebook that seems to do well without it :-)

Please merge this batch to acpi-test.

As usual, the patch set is available at:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test

Shortlog of the above branch:

Henrique de Moraes Holschuh (13):
  (already submitted)
      ACPI: thinkpad-acpi: make room for more features in tp_features bitfield
      ACPI: thinkpad-acpi: issue EV_SYNC after EV_SWITCH
      ACPI: thinkpad-acpi: add mutex-based locking to input device event send path
      ACPI: thinkpad-acpi: keep track of module state
      ACPI: thinkpad-acpi: check version of hot key firmware
      ACPI: thinkpad-acpi: dequeue all pending hot key events at once (v2.2)
      ACPI: thinkpad-acpi: fix regression on HKEY LID event handling
      ACPI: thinkpad-acpi: use a separate platform device for hwmon and name it (v2)
      ACPI: thinkpad-acpi: duplicate driver attributes to new hwmon pdrv
  (new)
      ACPI: thinkpad-acpi: skip blanks before the data when parsing sysfs
      ACPI: thinkpad-acpi: support 16 levels of brightness (v2)
      ACPI: thinkpad-acpi: disable backlight handler if ACPI generic could do it
      ACPI: thinkpad-acpi: bump up version to 0.17

Thanks.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
