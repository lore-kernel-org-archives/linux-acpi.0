From: Mattia Dongili <malattia@linux.it>
Subject: [PATCH 0/3] sony-laptop for 2.6.23-rc3
Date: Sun, 12 Aug 2007 16:20:25 +0900
Message-ID: <11869032283795-git-send-email-malattia@linux.it>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mtoichi12.ns.itscom.net ([219.110.2.182]:64571 "EHLO
	mtoichi12.ns.itscom.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385AbXHLHUk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Aug 2007 03:20:40 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>

Hi Len,

here's the resend I promised before with an additional bonus patch.
1- new FZ model added

2- fix the oops I mentioned before, it's totally unrelated to the other bugfix
   (patch #3) and it was there far before

3- the http://bugzilla.kernel.org/show_bug.cgi?id=8803 fix:
   since it should be completely harmless on non C1VE/C1VN laptops I'd say we
   should push it but if you think it's too big/invasive for 2.6.23 then
   letting it sit in the test branch for a while won't hurt (except meye is
   unusable).  My Type3 and Type2 vaios aren't showing any problem with
   this patch applied.
   I purposedly left it as the last patch to make it easier to split the serie,
   just in case.

thanks
---
 drivers/misc/sony-laptop.c |  231 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 166 insertions(+), 65 deletions(-)
-- 
mattia
