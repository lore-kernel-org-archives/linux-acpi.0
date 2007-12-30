From: Andrew Morton <akpm@linux-foundation.org>
Subject: Fw: [Bugme-new] [Bug 9663] New: in 2.6.24-rc6 function keys on my
 notebook doesn`t work
Date: Sat, 29 Dec 2007 18:36:38 -0800
Message-ID: <20071229183638.a601641d.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53412 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752262AbXL3Cic (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 29 Dec 2007 21:38:32 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
Cc: "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>, msnkipa@mail.ru


Another regression.

Begin forwarded message:

Date: Sat, 29 Dec 2007 16:07:30 -0800 (PST)
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 9663] New: in 2.6.24-rc6 function keys on my notebook doesn`t work


http://bugzilla.kernel.org/show_bug.cgi?id=9663

           Summary: in 2.6.24-rc6 function keys on my notebook doesn`t work
           Product: ACPI
           Version: 2.5
     KernelVersion: 2.6.24-rc6
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: ACPICA-Core
        AssignedTo: acpi_acpica-core@kernel-bugs.osdl.org
        ReportedBy: msnkipa@mail.ru


Most recent kernel where this bug did not occur: 2.6.23.12
Distribution: debian unstable
Hardware Environment: toshiba u300-13m
Software Environment: -
Problem Description: function keys that tune the brightness of lcd on my
notebook stop to work. function key that enable/disable touchpad stop to work.
on 2.6.23.12 kernel it work fine, but atkbd.c always report about unknown key
code but keys work! on .24 kernel no such reports happen but keys doesn`t work!

Steps to reproduce: install 2.6.24-rc6 kernel


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
