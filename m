From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 0/4] sony-laptop fixes for 2.6.30
Date: Wed,  1 Apr 2009 22:10:43 +0900
Message-ID: <1238591447-13338-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:56570
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753949AbZDANKt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Apr 2009 09:10:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Hi Len,

a few fixes on top of my previous submission (diffed against your test branch).
There are fixes for spelling mistakes, a build fix and the new style events
reporting issue spotted by Matthias[1]. The only remaining problem is the
rfkill not enabling the devices if inserting the module with the switch on and
turning if off afterwards but I's day this is a good start to add support for a
number of vaio models.

 drivers/platform/x86/Kconfig       |    1 +
 drivers/platform/x86/sony-laptop.c |   53 +++++++++++++++++++----------------
 2 files changed, 30 insertions(+), 24 deletions(-)

[1]: I splitted Matthias patch in two and modified some bits for the event
reporting, I hope the attribution is ok.
-- 
mattia

