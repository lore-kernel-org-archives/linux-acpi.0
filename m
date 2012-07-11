From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Power management fix for 3.5-rc7
Date: Wed, 11 Jul 2012 19:43:19 +0200
Message-ID: <201207111943.19405.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:35765 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755957Ab2GKRho (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Jul 2012 13:37:44 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Len Brown <lenb@kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>

Hi Linus,

Please pull one power management fix for 3.5-rc7 on top of commit
bd0a521e88aa7a06ae7aabaed7ae196ed4ad867a:

  Linux 3.5-rc6

with commit hash dc332fdf9f373a87b1e2f423b5b004b2a3c37e1a

  ACPI / PM: Leave Bus Master Arbitration enabled for suspend/resume

from the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-for-3.5-rc7

It removes some old code known to cause problems to happen that was
re-introduced by mistake during the 3.4 merge window.  Since this code causes
systems to crash and the fix is -stable material, I'm regarding it as serious
enough.  It technically belongs to ACPI, but since it affects suspend/resume
I hope Len won't mind me pushing it.

Thanks!


 drivers/acpi/acpica/hwsleep.c | 22 ----------------------
 1 file changed, 22 deletions(-)

---------------

Jonathan Nieder (1):
      ACPI / PM: Leave Bus Master Arbitration enabled for suspend/resume

