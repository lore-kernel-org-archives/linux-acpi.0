From: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
Subject: Please include commit 8931d9e, acpi fix, to 3.0+ stable
Date: Thu, 19 Apr 2012 15:05:10 -0300
Message-ID: <20120419180509.GC2638@herton-Z68MA-D2H-B3>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56448 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab2DSSFR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Apr 2012 14:05:17 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: stable@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Jim Green <student.northwestern@gmail.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org

I noted that commit 8931d9ea78848b073bf299594f148b83abde4a5e added on 
3.3 isn't included on previous stable releases. I think it was supposed
to be added, based on this message on linux-acpi:
http://marc.info/?l=linux-acpi&m=131675442503494&w=2 

But it wasn't marked as Cc: stable so I guess it went unnoticed. Some 
users with some Asus based mainboards are reporting that this change 
fixs a suspend/resume issue addressed by the ACPI fix: for example
http://bugs.debian.org/661581 and
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/968016

So based on that I would like to request the change to be included (at 
least to 3.0.y, 3.1.y, 3.2.y, where it "cherry-picks"). I think the
patch also apply to releases previous to 3.0, but it may require some
backport, example for 2.6.32 longterm, if anyone wants I can backport it
if acpi guys can review it.

thanks,
-- 
[]'s
Herton
