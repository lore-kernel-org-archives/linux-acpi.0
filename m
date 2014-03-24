From: Stefan Biereigel <security@biereigel-wb.de>
Subject: [REGRESSION 3.14-rc6] Samsung N150 lid does not "open" after suspend
 to RAM.
Date: Mon, 24 Mar 2014 08:50:10 +0100
Message-ID: <532FE3B2.9060808@biereigel-wb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.131]:52537 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbaCXHuP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Mar 2014 03:50:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Stefan Biereigel <stefan@biereigel.de>, lenb@kernel.org, rjw@rjwysocki.net

Hi,

starting with 3.14-rc6, the lid on my Samsung N150 behaves weird: My
system is set up, so that it should suspend to RAM as soon as the lid is
closed. Beginning with 3.14-rc6, the lid goes from "open" to "closed"
correctly the first time (and the system suspends), but after resuming
from standby (by opening the lid), the lid does not change to "open" again.
Of course, closing the lid again does not induce suspend to RAM then.
Opening the lid now (while not sleeping), makes ACPI notify the opening,
so I guess ACPI "misses" or discards the lid open event from the EC when
coming from sleep.
Now, closing the lid again does induce suspend to RAM. This behaviour is
reproducible: every other time, suspending works.

This behaviour seems to be introduced by commit ad332c8a: ACPI / EC:
Clear stale EC events on Samsung systems.
Which was introduced after 3.14-rc5.

When opening the lid to resume from standby, i see in dmesg:
Mar 23 22:12:04 little1 kernel: [ 7630.932074] ACPI : EC: 1 stale EC
events cleared
(which comes from drivers/acpi/ec.c)

Seems to me, that the "open" event is cleared from the EC, but also
discarded instead of passed on. Shouldn't the correct behaviour be to
report all the pending events, read from the EC, as ACPI events? Can you
point me in a direction for fixing the issue cleanly, then I will try to
find a solution and prepare a patch for this issue.

Best regards,
Stefan

