From: Andi Kleen <andi@firstfloor.org>
Subject: Please pull more ACPI/cpuidle updates
Date: Fri, 15 Aug 2008 21:33:38 +0200
Message-ID: <20080815193338.GA3594@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:55044 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756461AbYHOTdl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Aug 2008 15:33:41 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: torvalds@osdl.org, venki.pallipadi@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org


Linus, 

please pull more ACPI updates. This mainly includes the cpuidle 
latency updates Venki did some time ago for your system (due to some SNAFU
they didn't get included earlier) and also a fix for a ioremap
PAT regression exposed by ACPI.

-Andi

  git://git.kernel.org/pub/scm/linux/kernel/git/ak/linux-acpi-2.6 release-2.6.27

Andi Kleen (3):
      x86: Fix ioremap off by one BUG
      Merge branch 'ioremap' into release-2.6.27
      Merge branch 'cpuidle' into release-2.6.27

venkatesh.pallipadi@intel.com (3):
      cpuidle: Do not use poll_idle unless user asks for it
      cpuidle: Menu governor fix wrong usage of measured_us
      cpuidle: Make ladder governor honor latency requirements fully

 arch/x86/mm/ioremap.c              |    2 +-
 drivers/cpuidle/governors/ladder.c |   26 ++++++++++++++++++---
 drivers/cpuidle/governors/menu.c   |   42 ++++++++++++++++++++++++------------
 3 files changed, 51 insertions(+), 19 deletions(-)
