From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 0/3] ACPI autoloading of linux specific HIDs
Date: Fri, 07 Dec 2007 13:20:18 +0100
Message-ID: <1197030019.28990.126.camel@queen.suse.de>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:34659 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074AbXLGMUU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 7 Dec 2007 07:20:20 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm <akpm@linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, fseidel <fseidel@suse.de>, Kay Sievers <kay.sievers@vrfy.org>, Holger Macht <hmacht@suse.de>

These are fixes which are in OpenSUSE 10.3 for some time already.
I split patch 1 and 2, which was one originally and fixed a minor bug
there:
Fix autloading of dock, video, bay and all linux specific HID drivers
-> If a video/bay/dock/... device has no HID, do not add the Linux
specific HID to the list of CIDs, but add it as HID.

Those should have posted a bit earlier.., but are no critical fixes.
Len, I expect you don't want to have them in 2.6.24?
Andrew, can you take them please, then, so that they are not missed on
the next cycle again...

Frank, Kay, it is already some time ago when you gave your
signed-offs..., I made this little adjustment mentioned above and the
split. As these were only small changes, I kept your signed-offs, hope
this is ok with you.

Thanks,

  Thomas

