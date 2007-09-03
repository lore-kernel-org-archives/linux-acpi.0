From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi changes targeted at 2.6.23-rc6
Date: Mon,  3 Sep 2007 00:16:26 -0300
Message-ID: <1188789388345-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49067 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752888AbXICDQc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Sep 2007 23:16:32 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org


Len,

The two patches that follow this email update thinkpad-acpi userspace
interface into a much friendlier shape, taking advantage of the new
netlink functionality in the ACPI core.

Please send them to Linus ASAP for merging, so that they get included in
2.6.23.  That will make my life (and HAL's, as well as the user's) a lot
easier...  The solution currently in mainline is not nearly as nice and
transparent as the one in these patches.

As usual, these patches are available for git pull from:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-release

Shortlog follows:

Henrique de Moraes Holschuh (3):
      ACPI: event: fix acpi_bus_generate_netlink_event call
      		(the above patch was sent separately)
      ACPI: thinkpad-acpi: always enable input layer, add hotkey_report_mode
      ACPI: thinkpad-acpi: bump up version to 0.16

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
