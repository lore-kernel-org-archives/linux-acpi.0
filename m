From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/2] PM: Rearrange core suspend code
Date: Sun, 7 Jun 2009 00:54:18 +0200
Message-ID: <200906070054.19207.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:57066 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803AbZFFXA7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 6 Jun 2009 19:00:59 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

Hi,

Here's something I wanted to do quite some time ago.

kernel/power/main.c becomes more and more difficult to maintain over time,
since it contains both the suspend to RAM core code and some common PM code
that is also used for hibernation.  For this reason [1/2] separates the suspend
to RAM code from main.c and puts it into two new files (the test facility is,
again, separated from the core code for clarity).

[2/2] renames kernel/power/disk.c to kernel/power/hibernate.c, because the role
of this file is analogous to kernel/power/suspend.c (introduced by [1/2]).

Comments welcome.

Best,
Rafael

