From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PULL] thinkpad-acpi sysfs interface fix
Date: Fri, 25 May 2007 20:53:20 -0300
Message-ID: <1180137201942-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49676 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752816AbXEYXx1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 May 2007 19:53:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Len,

Please pull from:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git for-upstream/acpi-release

to receive the following patch:
	ACPI: thinkpad-acpi: do not use named sysfs groups

(the above git tree is based on 2.6.22-rc2).

The patch fixes a major bad design decision I made in the sysfs interface, and
it needs to go into 2.6.22 to avoid the bad ABI making it to a stable kernel
release (which would make it that much harder to change).

Please send it to Linus for merging.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
