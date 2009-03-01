From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 0/9] sony-laptop for 2.6.30
Date: Sun,  1 Mar 2009 13:40:36 +0900
Message-ID: <1235882445-2404-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:48647
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756328AbZCAEuR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Feb 2009 23:50:17 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Hello Len,

This is a list of long overdue patches I had sitting in my local tree.
Please could you include them in you batch for 2.6.30?

PS: apologies to those who receive these emails twice (due to me trying
git-send-email ;))

Thanks
---
 drivers/platform/x86/sony-laptop.c |  126 +++++++++++++++++++++++++-----------
 include/linux/sonypi.h             |    3 +
 2 files changed, 91 insertions(+), 38 deletions(-)
-- 
mattia

