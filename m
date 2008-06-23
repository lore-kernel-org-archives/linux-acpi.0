From: Len Brown <lenb@kernel.org>
Subject: Re: [lm-sensors] [REGRESSION, ABI] Re:  LMSENSORS: 2.6.26-rc,
 enabling ACPI Termal Zone support costs sensors
Date: Mon, 23 Jun 2008 13:54:56 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806231333030.2984@localhost.localdomain>
References: <485DA11C.7050906@keyaccess.nl> <485DFF35.6080008@hhs.nl>
 <485E505F.8010306@keyaccess.nl> <485E61DE.6020202@hhs.nl>
 <485E6F12.4010307@keyaccess.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:64726 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754165AbYFWRz0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Jun 2008 13:55:26 -0400
In-reply-to: <485E6F12.4010307@keyaccess.nl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Hans de Goede <j.w.r.degoede@hhs.nl>, linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, "Mark M. Hoffman" <mhoffman@lightlink.com>, Zhang Rui <rui.zhang@intel.com>

Rene,
Thank you for reporting this.

I agree that this failure is an unwelcome surprise to those users
who upgrade to 2.6.26 but are still using libsensors <= 2.10.6.

Jean, Mark, Hans,

I'm actually fine with adding a temporary kernel config option
along the lines Rene suggested to ease the  migration
to linux-2.6.26 for those users.

But the config option would need to be scheduled for removal
after a certain period (say 6 months) so we don't have to maintain
it forever.

More importantly, I think it would also have to be disabled by default
so that it would not have a negative impact on what we think are the
majority of properly configured systems.  After all, we fixed this
bug in user-space about out 4 months ago and as you point out, the
distro upgrade path is actually quite well looked after.

So I'm not sure how useful it would be to the target users.
After they run into the problem, they'd probably google it
and find that they can either tweak a kernel config option
or upgrade libsensors.  And we'd prefer that they do the
later rather than the former, yes?

just let me know.

thanks,
-Len
