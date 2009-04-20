From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] PM update for 2.6.30
Date: Mon, 20 Apr 2009 02:56:16 +0200
Message-ID: <200904200256.17028.rjw@sisk.pl>
References: <20090417231009.GB6900@flint.arm.linux.org.uk> <alpine.LFD.2.00.0904191357280.12867@localhost.localdomain> <20090419200330.GA16002@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48406 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753221AbZDTA4Z (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 19 Apr 2009 20:56:25 -0400
In-Reply-To: <20090419200330.GA16002@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Len Brown <lenb@kernel.org>, Linux Kernel List <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

Hi Linus,

Please pull a power management update for 2.6.30 from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git for-linus

This fixes the ARM breakage caused by the recent reordering of suspend code.

 drivers/acpi/sleep.c    |    8 ++++----
 include/linux/suspend.h |   36 ++++++++++++++++++++++++++----------
 kernel/power/main.c     |   24 +++++++++++++++++-------
 3 files changed, 47 insertions(+), 21 deletions(-)

---------------

Rafael J. Wysocki (1):
      PM/Suspend: Introduce two new platform callbacks to avoid breakage


Thanks,
Rafael

