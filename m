From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH v2] thinkpad-acpi changes for the merge window (part 1)
Date: Sat, 22 Sep 2007 22:10:35 -0300
Message-ID: <11905098422303-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:44922 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751571AbXIWBKq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Sep 2007 21:10:46 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Len,

Here is (again) the first batch of changes for thinkpad-acpi, targetted at the
next merge window.   They're mostly non-critical fixes.

I have fixed the hot key / HKEY naming on patch 6 in this second version of the
batch.

Please merge this batch to acpi-test.

As usual, it is available at:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test

Shortlog of the above branch:

Henrique de Moraes Holschuh (7):
      ACPI: thinkpad-acpi: make room for more features in tp_features bitfield
      ACPI: thinkpad-acpi: issue EV_SYNC after EV_SWITCH
      ACPI: thinkpad-acpi: add mutex-based locking to input device event send path
      ACPI: thinkpad-acpi: keep track of module state
      ACPI: thinkpad-acpi: check version of hot key firmware
      ACPI: thinkpad-acpi: dequeue all pending hot key events at once (v2)
      ACPI: thinkpad-acpi: fix regression on HKEY LID event handling

Thanks.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
