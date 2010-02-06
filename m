From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi patches for 2.6.33-rc
Date: Sat,  6 Feb 2010 13:30:26 -0200
Message-ID: <1265470230-30797-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:56364 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753003Ab0BFPaj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Feb 2010 10:30:39 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Len,

This is the current queue of patches for thinkpad-acpi.

Patch 1 and 2 can go in acpi-test to be merged in the next merge window
(AND go to -stable). OTOH, if you feel they can go in 2.6.33-rc, it
would mean the driver would not pester some users needlessly.

Patches 3 and 4 fix real problems and regressions, and should go to
Linus ASAP.

Thank you.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
