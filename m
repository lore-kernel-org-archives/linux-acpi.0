From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 0/4] swsusp: Fix hibernation/restore code ordering
Date: Fri, 18 May 2007 00:19:34 +0200
Message-ID: <200705180019.35548.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:60793 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755524AbXEQWX7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 May 2007 18:23:59 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <aystarik@gmail.com>, Johannes Berg <johannes@sipsolutions.net>

Hi,

In the face of this change:

http://marc.info/?l=linux-acpi&m=117938245931603&w=2

I think we should also modify the code ordering in swsusp so that
hibernation_ops->prepare() is executed after device_suspend().

However, for this purpose it seems reasonable to eliminate the code duplication
between kernel/power/disk.c and kernel/power/user.c first.  By eliminating it
we can reduce the size of user.c quite substantially and remove the
maintenance difficulty with making essentially the same changes in two
different places.

Moreover, we should also remove the calls to "platform" functions from the
restore code path, since it doesn't carry out any power transition of the
system, but we generally need to disable the GPEs before the restore if the
'platform' hibernation mode has been used.  To do this, we can introduce
two new hibernation_ops to be used in the restore code.

Comments welcome.

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King

