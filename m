From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi bug fixes for 2.6.26-rc (v2)
Date: Tue,  3 Jun 2008 23:36:08 -0300
Message-ID: <1212546971-29736-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45310 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751934AbYFDCgO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Jun 2008 22:36:14 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Len,

This patchset has my current thinkpad-acpi queue for 2.6.26-rc, rebased
to properly apply to latest Linus.  It includes two fixes, one of them
being a regression from 2.6.25 that bites users of older ThinkPads.

Please send them to Linus for mainline merge.

As usual, the patch set is available at:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-release

Shortlog:

Henrique de Moraes Holschuh (3):
      SW_RADIO to SW_RFKILL_ALL rename
      ACPI: thinkpad-acpi: fix initialization error paths
      ACPI: thinkpad-acpi: fix LED handling on older ThinkPads

Thanks!

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
