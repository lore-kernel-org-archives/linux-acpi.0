From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 0/5] sony-laptop for 2.6.23
Date: Wed, 11 Jul 2007 00:04:30 +0900
Message-ID: <1184079875379-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi15.ns.itscom.net ([219.110.2.185]:43867 "EHLO
	mtoichi15.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754535AbXGJPEr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jul 2007 11:04:47 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Hi Len.

The following patches a targeted to 2.6.23.
Important changes include the scancode enabling work done by Richard Hughes and
support for some recent vaio models. More of them may be added later once I get
answers from users who I asked to run some tests.

Please apply.
Many thanks
---
 drivers/misc/sony-laptop.c |  273 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 221 insertions(+), 52 deletions(-)
-- 
mattia
:wq
