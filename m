From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PULL] ibm-acpi changes for acpi-test/2.6.22 (try 2)
Date: Fri, 23 Mar 2007 17:33:53 -0300
Message-ID: <11746820402862-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:53895 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753423AbXCWUeH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Mar 2007 16:34:07 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

Len,

After you have updated to the latest linus tree, please pull from:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
branch for-upstream/acpi-test

to receive the following patches:
      ACPI: ibm-acpi: kill trailing whitespace
      ACPI: ibm-acpi: rename some identifiers
      ACPI: ibm-acpi: add header file
      ACPI: ibm-acpi: organize code
      ACPI: ibm-acpi: update copyright notice
      ACPI: ibm-acpi: update documentation
      ACPI: ibm-acpi: move driver to drivers/misc hierarchy

Please merge them into acpi-test, targetting 2.6.22.

This is almost the same patch set I had sent before, but properly rediffed to
apply to the latest 2.6.21 tree.  It also includes one extra patch to move
ibm-acpi to drivers/misc.

Note that this patch set was generated using git format-patch -M to avoid the
noise caused by the renames, and may require git-apply to apply.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
