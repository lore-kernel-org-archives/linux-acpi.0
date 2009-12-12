From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 0/2] sony-laptop patches for 2.6.33
Date: Sat, 12 Dec 2009 14:09:37 +0900
Message-ID: <1260594579-16027-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:55342
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758095AbZLLFJ5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Dec 2009 00:09:57 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Mattia Dongili <malattia@linux.it>

Hi Len,

Please apply the following two patches to your next submission for 2.6.33.
Nothing terribly dramatic, just a new key being mapped and the removal of
sony-laptop's private workqueue.
Thanks.

Dmitry Torokhov (1):
  sony-laptop - remove private workqueue, use keventd instead

Mattia Dongili (1):
  sony-laptop: add AVMode key mapping

 drivers/platform/x86/sony-laptop.c |   61 ++++++++++++++++++++---------------
 include/linux/sonypi.h             |    1 +
 2 files changed, 36 insertions(+), 26 deletions(-)
-- 
mattia
