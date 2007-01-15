From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 7828] New: Reboot instead of powerdown with
 2.6.20-rc4 or 2.6.20-rc5
Date: Mon, 15 Jan 2007 13:50:43 -0800
Message-ID: <20070115135043.4518efa3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:49784 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbXAOVut (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Jan 2007 16:50:49 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: francois.valenduc@skynet.be, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>


hm, this could be anything - a triple-fault on the shutdown path would cause
the machine to reboot.

Perhaps you could try booting with acpi=off?

Begin forwarded message:

Date: Mon, 15 Jan 2007 10:18:53 -0800
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 7828] New: Reboot instead of powerdown with 2.6.20-rc4 or 2.6.20-rc5


http://bugzilla.kernel.org/show_bug.cgi?id=7828

           Summary: Reboot instead of powerdown with 2.6.20-rc4 or 2.6.20-
                    rc5
    Kernel Version: 2.6.20-rc5
            Status: NEW
          Severity: normal
             Owner: power-management_other@kernel-bugs.osdl.org
         Submitter: francois.valenduc@skynet.be


Most recent kernel where this bug did *NOT* occur: 2.6.19.2 (or maybe 2.6.20
until rc3, I haven't tested 2.6.20 before rc4)
Distribution: Debian sid
Hardware Environment: ACER Travelmate 4001 WMli, processor Intel centrino 1,5
GhZ (pentium M family)
Software Environment: I don't think it's relevant
Problem Description: When I wan't to shutdown the computer, the shutdown
sequence occurs as expected, however, when the computer is supposed to power
down, it reboots.

Steps to reproduce: Try to powerdown the computer.

Please don't hesitate to ask more info if needed.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
