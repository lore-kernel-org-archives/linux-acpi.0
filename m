From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi first set of changes for 2.6.33
Date: Thu,  3 Dec 2009 09:41:17 -0200
Message-ID: <1259840485-2516-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:47529 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753482AbZLCLl2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2009 06:41:28 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Len,

This is the first batch of changes for thinkpad-acpi, for the merge window.

Patch 4 is already in linux-next through the backlight tree, but it has a merge
problem there, so I have included it on this batch.  I will coordinate with the
backlight maintainer, so that the patch can be merged in mainline through the
acpi tree.

Please apply to acpi-test.

Thank you!

Shortlog:
Henrique de Moraes Holschuh (8):
      thinkpad-acpi: fix default brightness_mode for R50e/R51
      thinkpad-acpi: preserve rfkill state across suspend/resume
      thinkpad-acpi: fix some version quirks
      thinkpad-acpi: issue backlight class events
      thinkpad-acpi: silence bogus complain during rmmod
      thinkpad-acpi: adopt input device
      thinkpad-acpi: expose module parameters
      thinkpad-acpi: log temperatures on termal alarm

 Documentation/laptops/thinkpad-acpi.txt |   51 +++--------
 drivers/platform/x86/thinkpad_acpi.c    |  150 +++++++++++++++++++-----------
 2 files changed, 107 insertions(+), 94 deletions(-)
