From: Len Brown <lenb@kernel.org>
Subject: ACPI patch queue for 2.6.27
Date: Fri, 20 Jun 2008 03:43:02 -0400
Message-ID: <1213947852-10924-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:53282 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbYFTHoR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 03:44:17 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R007X13UKC1B3@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 02:37:33 -0500 (CDT)
Received: from localhost.localdomain (d975xbx2 [127.0.0.1])
	by localhost.localdomain (8.14.2/8.14.2) with ESMTP id m5K7iC18011256	for
 <linux-acpi@vger.kernel.org>; Fri, 20 Jun 2008 03:44:12 -0400
Received: (from lenb@localhost)	by localhost.localdomain (8.14.2/8.14.2/Submit)
 id m5K7iCZV011254	for linux-acpi@vger.kernel.org; Fri,
 20 Jun 2008 03:44:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Here is the current ACPI queue for 2.6.27

fujitsu-laptop and compal-laptop are new.

I'll be impressed (and delighted) if Bjorn's PNP-v3 series
requires no modification before then.
We know it has a few checkpatch issues...

We cherry-picked the important patches out of the ACPICA
series into 2.6.26 already, so what remains here is
less exciting.

Per notes on the list, I expect some changes to
the idle= param patches, but here is what we have now.

I'd also like to see Rui's enhancement to /sys/firmware/acpi/interrupts
make 2.6.27 -- it is excluded here due to a conflict
with the ACPICA branch.

thanks,
-Len


