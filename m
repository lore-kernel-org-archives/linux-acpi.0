From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 0/7] sony-laptop for 2.6.23 (updated)
Date: Mon, 16 Jul 2007 02:34:32 +0900
Message-ID: <1184520879452-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi12.ns.itscom.net ([219.110.2.182]:55210 "EHLO
	mtoichi12.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbXGORez (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Jul 2007 13:34:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>

Hi Len,

These patches a targeted to 2.6.23.
I updated the previous series with a couple more patches one of which fixes a
bug present in 2.6.22 and that I'll push to the stable maintainers.
Important changes include the scancode enabling work done by Richard Hughes and
support for some recent vaio models.

Many thanks
---
 drivers/misc/sony-laptop.c |  312 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 252 insertions(+), 60 deletions(-)
-- 
mattia
:wq
