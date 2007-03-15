From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [GIT PULL] ibm-acpi move to drivers/misc
Date: Thu, 15 Mar 2007 00:10:15 -0300
Message-ID: <20070315031015.GA6292@khazad-dum.debian.net>
References: <11736588493609-git-send-email-hmh@hmh.eng.br> <200703112054.41560.lenb@kernel.org> <20070312012700.GB19808@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:47352 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965029AbXCODK0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 Mar 2007 23:10:26 -0400
Content-Disposition: inline
In-Reply-To: <20070312012700.GB19808@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Len,

Please pull from:
git://repo.or.cz/linux-2.6/linux-acpi-2.6/ibm-acpi-2.6.git
branch for-upstream/acpi-test

to receive the following patch, targetted at 2.6.22:
	ACPI: ibm-acpi: move driver to drivers/misc hierarchy

Note: the branch I am asking you to pull from is the same branch I asked you
to pull for acpi-test before, rebased to your current linus branch.  So, it
contains the other patches you have already accepted, whitespace-stripped by
git rebase.

I hope this doesn't cause you trouble for the pull, if it does, please tell
me how you'd rather I prepare such branches in the future, when it is
impossible to have them against Linus' tree.

The patch follows this message in email format, using git format-patch -M
to reduce the noise tremendously.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
