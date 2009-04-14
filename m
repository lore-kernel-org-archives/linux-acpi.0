From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi late queue
Date: Mon, 13 Apr 2009 23:44:09 -0300
Message-ID: <1239677054-3221-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60367 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750721AbZDNCoV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Apr 2009 22:44:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Len,

This patchset has some fixes for thinkpad-acpi in 2.6.30-rc.  The first
one fixes a regression, the second fixes code that has never worked in the
first place, and the others are safe nice-to-haves.  Please consider
sending them to Linus for 2.6.30-rc2/rc3.

Henrique de Moraes Holschuh (5):
      thinkpad-acpi: silence hotkey enable warning for module parameter
      thinkpad-acpi: fix LED blinking through timer trigger
      thinkpad-acpi: fix use of MODULE_AUTHOR
      thinkpad-acpi: simplify module autoloading
      thinkpad-acpi: bump up version to 0.23

Thank you!

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
