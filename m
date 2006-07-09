From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Linux/ACPI vs ACPICA audit -- ACPICA 20060707
Date: Sun, 9 Jul 2006 14:10:10 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECF9C6@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3518 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161033AbWGISKO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jul 2006 14:10:14 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-acpi@vger.kernel.org

>> For the files that Linux gets from ACPICA, this diff shows how Linux
>> has diverged from upstream.
>> 
>> acpica-unix-20060707.audit.diff:# 42 files changed, 211 
>insertions(+), 92 deletions(-)
>
>300+ lines in 42 files.  That doesn't look huge,
>but then I'm not trying to maintain it.

It isn't huge because we continuously work to minimize it.

>Is there supposed to be some kind of value judgment (implied)
>in this diff-from-upstream?  Is the Linux code worse/better
>or just "fixed" to work with Linux?

We want to be in a place where there is 0 divergence necessary
for Linux (and other OS's) to use ACPICA.  This is a measure
of how successful we are for each snapshot on Linux.

Andy Grover didn't allow divergence in the old days.
Some other OSs use ACPICA with zero changes.
I allow divergence, but for it not to drive me insane with
patch conflicts, it needs to be managed.

>Is the diff-from-upstream a maintainer headache?

Yes, but not a large one, on the grand scale of headaches --
as long as we keep it under control.

>What is the purpose of these audit reports?

What is measured, improves.  Bob is the primary customer of these
and he looks to see if he can massage ACPICA such that we don't
need to touch it to integrate it -- or he pings me on why I
made a change, or allowed a change, when I didn't have to.

It also notifies the list that a new ACPICA version is
available in a Linux patch.  Though we're working towards
a different release process such that we'll integrate
individual patches rather than "releases".

cheers,
-Len

ps. 20060707 is up as a plain patch, but I didn't push it
to the git tree (and thus mm) b/c I didn't have time to test
it Friday, which I'm doing now.
