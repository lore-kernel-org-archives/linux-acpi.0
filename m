From: shaohua.li@intel.com
Subject: [RFC 0/5] device wakeup event support
Date: Mon, 08 Sep 2008 17:19:26 +0800
Message-ID: <20080908091926.785882370@sli10-desk.sh.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36579 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752195AbYIHJX0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Sep 2008 05:23:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org
Cc: stern@rowland.harvard.edu, dbrownell@users.sourceforge.net

This series add device wakeup event detection support. This is the base to
implement runtime device suspend/resume, though we don't support it now.
But David said USB is approaching to this. See this bugzilla
http://bugzilla.kernel.org/show_bug.cgi?id=6892 for detail.

The current process to handle wakeup event is:
1. driver enable wakeup event line pme and suspend
2. NPME or ACPI receives wakeup event
3. NPME or ACPI call .wakeup_event() to clear and disable wakeup event. Driver can do extra things in .wakeup_event() too.
4. NPME or ACPI call generic wakeup event handler (device_receive_wakeup_event())
5. device resumes, and goto 1 for next round of suspend

There are somethings we need discuss:
1. is this generic for other platforms?
2. what should the generic wakeup event handler do?

Comments and suggestions are welcome!

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
-- 
