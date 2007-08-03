From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 0/3] sony-laptop and sonypi for 2.6.23-rc2
Date: Sat,  4 Aug 2007 00:22:29 +0900
Message-ID: <118615455219-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi12.ns.itscom.net ([219.110.2.182]:58564 "EHLO
	mtoichi12.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762352AbXHCPWr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Aug 2007 11:22:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>

Hi Len,

these 3 patches are aimed at 2.6.23-rc2 if there is time enough.
There's only http://bugzilla.kernel.org/show_bug.cgi?id=8803 left,
I hope to be able to have it sorted out soon.

Please apply
---
 drivers/char/sonypi.c      |    8 ++++++--
 drivers/misc/sony-laptop.c |    9 ++++++---
 2 files changed, 12 insertions(+), 5 deletions(-)
-- 
mattia
