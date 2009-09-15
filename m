From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 0/4] sony-laptop for 2.6.32
Date: Wed, 16 Sep 2009 00:05:28 +0900
Message-ID: <1253027132-5903-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:43819
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754575AbZIOPO0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2009 11:14:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Hi Len,

please find the following patches for sony-laptop.

Alan Jenkins (1):
  sony-laptop: Don't unregister the SPIC driver if it wasn't registered

Mattia Dongili (3):
  sony-laptop: remove device_ctrl and the SPIC mini drivers
  sony-laptop: SPIC unset IRQF_SHARED, set IRQF_DISABLED
  sony-laptop: remove _INI call at init time

 drivers/platform/x86/sony-laptop.c |  127 +++++++++++++++---------------------
 1 files changed, 53 insertions(+), 74 deletions(-)

