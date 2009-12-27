From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi fixes for 2.6.32-rc2
Date: Sat, 26 Dec 2009 22:52:12 -0200
Message-ID: <1261875137-27565-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60505 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752256AbZL0AwY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Dec 2009 19:52:24 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Len,

This patchset fixes a few problems that have been reported,
including the annoying build problem reported by Ingo.

It mostly updates the new ALSA functionality to be better
behaved, and makes it optional for people who could care
less for on-screen-display of volume hotkeys and would
rather have a kernel that is a few kiB smaller.

Please apply.

Thanks.

Shortlog:
Henrique de Moraes Holschuh (5):
      thinkpad-acpi: don't take the first ALSA slot by default
      thinkpad-acpi: don't fail to load the entire module due to ALSA problems
      thinkpad-acpi: make volume subdriver optional
      thinkpad-acpi: update volume documentation
      thinkpad-acpi: improve Kconfig help text

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
