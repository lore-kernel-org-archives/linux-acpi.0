From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH v2] thinkpad-acpi first set of changes for 2.6.33 (v2)
Date: Tue,  8 Dec 2009 23:36:20 -0200
Message-ID: <1260322590-5571-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:39098 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S967095AbZLIBgc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Dec 2009 20:36:32 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Len,

This is the second version of the first batch of changes for thinkpad-acpi, for
the merge window.

Patch 4 is already in linux-next through the backlight tree, but it has a merge
problem there, so I have included it on this batch.  I will coordinate with the
backlight maintainer, so that the patch can be merged in mainline through the
acpi tree.

Changes since the last post:
  patch 08 has been refactored as per comments.
  patches 09 and 10 are new.

Please apply to acpi-test.

Thank you!

Shortlog:
Henrique de Moraes Holschuh (10):
      thinkpad-acpi: fix default brightness_mode for R50e/R51
      thinkpad-acpi: preserve rfkill state across suspend/resume
      thinkpad-acpi: fix some version quirks
      thinkpad-acpi: issue backlight class events
      thinkpad-acpi: silence bogus complain during rmmod
      thinkpad-acpi: adopt input device
      thinkpad-acpi: expose module parameters
      thinkpad-acpi: log temperatures on termal alarm (v2)
      thinkpad-acpi: use input_set_capability
      thinkpad-acpi: sync input device EV_SW state directly

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
