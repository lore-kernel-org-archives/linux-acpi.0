From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi late changes for the merge window
Date: Sat, 18 Oct 2008 14:23:51 -0300
Message-ID: <1224350635-14021-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:44491 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750930AbYJRRYD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Oct 2008 13:24:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org


Len,

This patchset has the changes for thinkpad-acpi that I would like to see merged
for 2.6.28 (while the window is still open).

It includes the patch for http://bugzilla.kernel.org/show_bug.cgi?id=11331,
which is the same as the one you already got in acpi-test as far as code goes,
but it might have differences in the changelog.   If you prefer what you
already merged into acpi-test, just skip patch 01.

Please consider sending the patchset to Linus for merge on mainline.

As usual, available for git pull from:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-test

Shortlog:

Henrique de Moraes Holschuh (2):
      ACPI: thinkpad-acpi: attempt to preserve fan state on resume
      ACPI: thinkpad-acpi: Remove firmware backlight delays for Intel ACPI IGD OpRegion

Mariusz Kozlowski (1):
      ACPI: thinkpad-acpi: trivial fix of error message

Pascal Terjan (1):
      ACPI: thinkpad-acpi: Remove duplicate line

Thank you!

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
