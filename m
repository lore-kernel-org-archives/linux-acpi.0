From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 0/6 try2] sony-laptop for 2.6.25
Date: Sun, 13 Jan 2008 13:23:26 +0900
Message-ID: <1200198212-10526-1-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi14.ns.itscom.net ([219.110.2.184]:35100 "EHLO
	mtoichi14.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbYAMEXr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Jan 2008 23:23:47 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

Gah,
numbered patches this time.

As said these are just some updates for 2.6.25.
I still have pending code for the HD accelerometer and still need to
remove the acpi_bus_generate_genetlink_event call from the ISR.
My spare time is not very much recently but we will get there.

cheers
---
 drivers/misc/sony-laptop.c |  485 ++++++++++++++++++++++++++-------------------
 include/linux/sonypi.h     |    2 
 2 files changed, 286 insertions(+), 201 deletions(-)
-- 
mattia
