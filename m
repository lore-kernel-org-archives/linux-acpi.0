From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 0/2] sony-laptop for 2.6.23-rc3
Date: Sat, 11 Aug 2007 10:43:05 +0900
Message-ID: <1186796587433-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi16.ns.itscom.net ([219.110.2.186]:56567 "EHLO
	mtoichi16.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754526AbXHKBnh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 10 Aug 2007 21:43:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>

Hi Len,

two more patches for sony-laptop.
Please take a look at the second one (a bit more invasive): it fixes a
regression (http://bugzilla.kernel.org/show_bug.cgi?id=8803) and doesn't break
on my laptops, anyway better look for anything obvious that I may have missed.

---
 drivers/misc/sony-laptop.c |  212 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 153 insertions(+), 59 deletions(-)
-- 
Thanks
Mattia

