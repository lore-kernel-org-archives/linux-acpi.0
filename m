From: Len Brown <lenb@kernel.org>
Subject: 00/65 ACPI & driver patch queue 2.6.31
Date: Fri, 29 May 2009 22:12:34 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905292204500.32282@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:50526 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbZE3CMo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 May 2009 22:12:44 -0400
Received: from localhost.localdomain ([98.118.45.40])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KKF00BPJQ4ZYC64@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 29 May 2009 21:12:37 -0500 (CDT)
Received: from localhost.localdomain (d975xbx2 [127.0.0.1])
	by localhost.localdomain (8.14.2/8.14.2) with ESMTP id n4U2CYhi032302	for
 <linux-acpi@vger.kernel.org>; Fri, 29 May 2009 22:12:34 -0400
Received: from localhost (lenb@localhost)
	by localhost.localdomain (8.14.2/8.14.2/Submit) with ESMTP id n4U2CYVs032298
	for <linux-acpi@vger.kernel.org>; Fri, 29 May 2009 22:12:34 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Those with sharp eyes will notice that series of 65 patches
included again the 11 that were just sent to 2.6.30.

(By mistake, I generated the series with
linus..test, rather release..test)

So there should have been only 55 patches

(and when I noticed that ^C killed the intro message,
 but went ahead and sent the 65 patches:-(

Anyway, that series includes everything in the acpi test tree
(and thus in linux-next).  Except for the reset patch,
they're all expected to go into 2.6.31, some with some updates.

I've got some more patches to sift through on patchwork:
http://patchwork.kernel.org/project/linux-acpi/list/

If you have something that you'd like in 2.6.31
that isn't represented above, this would be a good
time to let that be known.

thanks,
-Len

