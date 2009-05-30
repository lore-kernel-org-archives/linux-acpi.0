From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi queue for 2.6.31
Date: Sat, 30 May 2009 13:25:04 -0300
Message-ID: <1243700709-25977-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:40667 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757972AbZE3QZR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 30 May 2009 12:25:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Len,

This patchset has some changes for thinkpad-acpi that I would like to see
merged for 2.6.31.   I will likely have a few more during the merge
window.

Shortlog:

Henrique de Moraes Holschuh (5):
      thinkpad-acpi: store fw version with strict checking
      thinkpad-acpi: add quirklist engine
      thinkpad-acpi: fix BEEP ACPI handler warnings
      thinkpad-acpi: enhance led support
      thinkpad-acpi: silence bogus warning when ACPI video is disabled

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
