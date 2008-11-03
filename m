From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 0/7] sony-laptop for acpi-test
Date: Mon,  3 Nov 2008 18:41:13 +0900
Message-ID: <1225705280-12775-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:48097
	"EHLO tadamune.kami.home" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754904AbYKCJlY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Nov 2008 04:41:24 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Hi Len,

here is a first submission with some of the backlog I accumulated in
these months.
The target is 2.6.29.

Thanks
---
 drivers/misc/sony-laptop.c |  116 ++++++++++++++++++++++++++++++++++-----------
 include/linux/sonypi.h     |    3 +
 2 files changed, 93 insertions(+), 26 deletions(-)
-- 
mattia
