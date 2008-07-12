From: Kyler Laird <kyler-dated-1216295104.2e2eca@lairds.com>
Subject: re: [PATCH] Panasonic Let's Note laptop extras driver v0.94
Date: Sat, 12 Jul 2008 07:53:45 -0400
Message-ID: <20080712115345.GD8673@lairds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.phaseit.net ([66.90.70.200]:52333 "EHLO smtp.phaseit.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751037AbYGLMns (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 12 Jul 2008 08:43:48 -0400
Received: from [127.0.0.1] (helo=flews.lairds.us)
	by smtp.phaseit.net with esmtp (Exim 4.62)
	(envelope-from <kyler-dated-1216295104.2e2eca@lairds.com>)
	id 1KHdfd-0002ah-AT
	for linux-acpi@vger.kernel.org; Sat, 12 Jul 2008 11:53:45 +0000
Received: from kyler by flews.lairds.us with local (Exim 4.69)
	(envelope-from <kyler-dated-1216295104.2e2eca@lairds.com>)
	id 1KHdfd-00082U-Lc
	for linux-acpi@vger.kernel.org; Sat, 12 Jul 2008 07:53:45 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I just applied the 2008-07-04 3:44:19 to 2.6.26-rc9 and it seems to work
well for my Panasonic CF-74.  It'll be wonderful to have this in the
mainline kernel!  (I won't need to add anything now.  Yea!)

In userspace, note that this requires a change from the proc interface
to sys for /etc/acpi/panabright.sh.  In Ubuntu Hardy I also disabled
/etc/acpi/mutebtn.sh (by setting the first line to "#!/bin/true")
because there seems to be a mute toggle elsewhere and the two toggle
events were canceling each other.

Thanks!

--kyler
