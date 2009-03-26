From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 0/14] sony-laptop for 2.6.30
Date: Thu, 26 Mar 2009 21:58:11 +0900
Message-ID: <1238072305-8085-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:53378
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbZCZM62 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Mar 2009 08:58:28 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Hi Len,

this patch-set includes the great work done by Matthew Garret to add
support for recent Vaio models and better support the old ones too in
addition to other smaller changes I had sitting here for a while now.

Hopefully I got the signoffs correctly this time.


 drivers/platform/x86/sony-laptop.c |  514 ++++++++++++++++++++++++++---------
 include/linux/sonypi.h             |    8 +
 2 files changed, 390 insertions(+), 132 deletions(-)

Thanks,
-- Mattia

