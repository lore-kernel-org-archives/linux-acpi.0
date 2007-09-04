From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PATCH] thinkpad-acpi changes targeted at 2.6.23-rc6 (v2)
Date: Tue,  4 Sep 2007 11:13:14 -0300
Message-ID: <1188915196931-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39133 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753696AbXIDON0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Sep 2007 10:13:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org


Len,

Here is a new version of the patches for thinkpad-acpi that I'd like to
see merged in mainline before 2.6.23-rc6 is out.  There were *no* code
chages since the last version.  I have updated the patch comments and
title as you suggested, and also made some changes to the thinkpad-acpi
documentation in the patch.

As usual, it is available at:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-release                                                                  

Shortlog of the above branch:
Henrique de Moraes Holschuh (3):
      ACPI: event: fix acpi_bus_generate_netlink_event call
      ACPI: thinkpad-acpi: revert new 2.6.23 CONFIG_THINKPAD_ACPI_INPUT_ENABLED option
      ACPI: thinkpad-acpi: bump up version to 0.16

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
