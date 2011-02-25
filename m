From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [GIT PULL] Power management fix for 2.6.38
Date: Fri, 25 Feb 2011 23:54:53 +0100
Message-ID: <201102252354.53735.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59913 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932539Ab1BYWy7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 Feb 2011 17:54:59 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>

Hi Linus,

Please pull a power management fix for 2.6.38 (and stable) from:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git pm-fixes

It fixes problems with ACPI wakeup from S5 not working without CONFIG_PM_SLEEP.


 include/linux/pm.h        |    2 ++
 include/linux/pm_wakeup.h |   25 ++++++++++++++-----------
 2 files changed, 16 insertions(+), 11 deletions(-)

---------------

Rafael J. Wysocki (1):
      PM: Make ACPI wakeup from S5 work again when CONFIG_PM_SLEEP is unset

