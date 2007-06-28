From: Mikhail Gusarov <dottedmag@dottedmag.net>
Subject: Asus M6*, A6*, L5D - can't reboot after suspend/resume
Date: Fri, 29 Jun 2007 03:52:05 +0700
Message-ID: <87myyjdcp6.fsf@vertex.dottedmag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dottedmag.net ([85.118.226.199]:54659 "EHLO dottedmag.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756303AbXF1UwG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Jun 2007 16:52:06 -0400
Received: from vertex.dottedmag.net (unknown [10.10.31.3])
	by dottedmag.net (Postfix) with ESMTP id B62101DE21
	for <linux-acpi@vger.kernel.org>; Fri, 29 Jun 2007 03:52:05 +0700 (NOVST)
Received: from vertex.dottedmag.net (localhost [127.0.0.1])
	by vertex.dottedmag.net (Postfix) with ESMTP id 5AE3A13BD3
	for <linux-acpi@vger.kernel.org>; Fri, 29 Jun 2007 03:52:05 +0700 (NOVST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi.

ping'ing mailing list: there is stuck bug in bugzilla and probably fresh eyes
need to look at it to find the obvious solution :) Sorry if this noise is
unnecessary.

Bug is http://bugzilla.kernel.org/show_bug.cgi?id=8598

Summary:

Most recent kernel where this bug did not occur: n/a
Distribution: debian/sid
Hardware Environment: Asus A6B, A6BA, M6A, M6N, M6NE, L5D notebooks
Problem Description: After S3 STR reboot does not work, reboot=w,h and
reboot=c,b, no luck. System shows message about restarting system. Caps lock and
num lock LEDs flash, but it does not reboot.

I personally have only M6N notebook, so can test things only on it.

-- 
JID: dottedmag@jabber.dottedmag.net
