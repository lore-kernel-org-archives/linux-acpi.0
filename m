From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Fwd: [Bug 92111] Power regression from 3.17 to 3.18 and 3.19
Date: Wed, 11 Feb 2015 01:29:36 +0100
Message-ID: <1790277.SYbcblnshn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1634036.8sX0qIkGjz"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53951 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750878AbbBKAGc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Feb 2015 19:06:32 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>, Andreas Noever <andreas.noever@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, attila.jakosa@gmail.com

This is a multi-part message in MIME format.

--nextPart1634036.8sX0qIkGjz
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi,

The _OSI("Darwin") support seems to break CPU power management for Attila.

Is there anything we can possibly do about that?

Rafael
--nextPart1634036.8sX0qIkGjz
Content-Type: message/rfc822
Content-Disposition: inline; filename="forwarded message"
Content-Description: bugzilla-daemon@bugzilla.kernel.org: [Bug 92111] Power regression from 3.17 to 3.18 and 3.19

Return-Path: <bugzilla-daemon@bugzilla.kernel.org>
Received: from mail.kernel.org (198.145.29.136) (HELO mail.kernel.org) by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer v0.80) id 343545c7ab4db29f; Wed, 11 Feb 2015 00:50:23 +0100
Received: from mail.kernel.org (localhost [127.0.0.1]) by mail.kernel.org (Postfix) with ESMTP id 7B3B8201F2 for <rjw@rjwysocki.net>; Tue, 10 Feb 2015 23:50:21 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52]) by mail.kernel.org (Postfix) with ESMTP id 08050201FE for <rjw@rjwysocki.net>; Tue, 10 Feb 2015 23:50:20 +0000 (UTC)
Received: by bugzilla2.web.kernel.org (Postfix, from userid 48) id E8F769F583; Tue, 10 Feb 2015 23:50:19 +0000 (UTC)
From: bugzilla-daemon@bugzilla.kernel.org
To: rjw@rjwysocki.net
Subject: [Bug 92111] Power regression from 3.17 to 3.18 and 3.19
Date: Tue, 10 Feb 2015 23:50:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Power Management
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Severity: normal
X-Bugzilla-Who: attila.jakosa@gmail.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: rjw@rjwysocki.net
X-Bugzilla-Target-Milestone: ---
Message-ID: <bug-92111-76231-fcRlm4ifRg@https.bugzilla.kernel.org/>
In-Reply-To: <bug-92111-76231@https.bugzilla.kernel.org/>
References: <bug-92111-76231@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,T_RP_MATCHES_RCVD, UNPARSEABLE_RELAY autolearn=unavailable version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on mail.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP

https://bugzilla.kernel.org/show_bug.cgi?id=92111

--- Comment #32 from Attila <attila.jakosa@gmail.com> ---
Strange result, but git bisect shows this commit to be the first bad:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=7bc5a2bad0b8d9d1ac9f7b8b33150e4ddf197334

I guess this acpi change results that CPU is not allowed to go deeper states
than pc3. I will do a build of 3.18 reverting this commit to make sure this was
the problem.

I will enclose a bisect log soon.

-- 
You are receiving this mail because:
You are the assignee for the bug.

--nextPart1634036.8sX0qIkGjz--

