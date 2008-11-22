From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Regression: ACPI AC driver doesn't work on Toshiba Portege R500
Date: Sun, 23 Nov 2008 00:53:13 +0100
Message-ID: <200811230053.14211.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:38081 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753588AbYKVXxo (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Nov 2008 18:53:44 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi,

With current mainline (2.6.28-rc6-git1 as of today) on Toshiba Portege R500 the
status of the AC adapter is not updated when the adapter is unplugged and
plugged in.  Evidently, /sys/class/power_supply/ADP1/online always contains the
same value.  Interestingly enough, though, if the box is suspended to RAM and
resumed, the status of the AC adapter is correctly updated, but the value read
at that time remains in /sys/class/power_supply/ADP1/online until the next
suspend/resume cycle regardless of what's going on with the AC adapter.

2.6.27.7 works correctly on this box so the recent EC patches don't seem to
cause this regression to happen.

Any other ideas?

Rafael
