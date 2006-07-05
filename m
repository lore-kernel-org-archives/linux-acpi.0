From: Henrique de Moraes Holschuh <hmh@debian.org>
Subject: ACPI 20060623 patches do not apply cleanly to 2.6.17
Date: Wed, 5 Jul 2006 14:48:58 -0300
Message-ID: <20060705174858.GC8452@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:25061 "EHLO
	out3.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S964926AbWGERtF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 5 Jul 2006 13:49:05 -0400
Received: from frontend3.internal (frontend3.internal [10.202.2.152])
	by frontend1.messagingengine.com (Postfix) with ESMTP id B8AB4D8D15F
	for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2006 13:49:03 -0400 (EDT)
Received: from khazad-dum.debian.net (c91fc7f8.cps.virtua.com.br [201.31.199.248])
	by mail.messagingengine.com (Postfix) with ESMTP id 9EFD2AA9B
	for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2006 13:49:05 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost.khazad-dum.debian.net (Postfix) with ESMTP id 6F42528125
	for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2006 14:48:59 -0300 (BRT)
Received: from khazad-dum.debian.net ([127.0.0.1])
	by localhost (khazad-dum.debian.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id nWies+ibQrQE for <linux-acpi@vger.kernel.org>;
	Wed,  5 Jul 2006 14:48:58 -0300 (BRT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

The 20060623 patches available at:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.17/

Do not apply cleanly on a 2.6.17 mainline tree.  Both bz2 and gz-packed
patchsets tested.

On top of which tree should they be applied?   20060608 applies just fine on
top of 2.6.17.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
