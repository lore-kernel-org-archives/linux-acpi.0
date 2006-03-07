From: Peter Wainwright <prw@ceiriog.eclipse.co.uk>
Subject: Concurrency in the execution of ACPI control methods
Date: Tue, 07 Mar 2006 20:22:35 +0000
Message-ID: <1141762955.19595.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mra03.ch.as12513.net ([82.153.252.25]:9428 "EHLO
	mra03.ch.as12513.net") by vger.kernel.org with ESMTP
	id S932155AbWCGUUd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Mar 2006 15:20:33 -0500
Received: from localhost (localhost [127.0.0.1])
	by mra03.ch.as12513.net (Postfix) with ESMTP id BF145D436C
	for <linux-acpi@vger.kernel.org>; Tue,  7 Mar 2006 20:20:30 +0000 (GMT)
Received: from mra03.ch.as12513.net ([127.0.0.1])
 by localhost (mra03.ch.as12513.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 06330-01-11 for <linux-acpi@vger.kernel.org>;
 Tue,  7 Mar 2006 20:20:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [82.153.72.42])
	by mra03.ch.as12513.net (Postfix) with ESMTP id 1AAF7D4231
	for <linux-acpi@vger.kernel.org>; Tue,  7 Mar 2006 20:20:30 +0000 (GMT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id k27KMZTj020220
	for <linux-acpi@vger.kernel.org>; Tue, 7 Mar 2006 20:22:35 GMT
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

this is my first posting to this list. I recently purchased a HP nx6125
laptop. This
laptop is known to suffer from a number of bugs when used with linux;
these have
been reported on Suse, Gentoo and Debian lists as well as on kernel
bugzilla.
The kernel bug is http://bugzilla.kernel.org/show_bug.cgi?id=5534.

I posted my own analysis of this bug on bugzilla, but there has been no
reply
so far. I am posting here because I think it may raise an issue which is
wider than
the scope of that bug, which seemingly affects only nx6125 owners. I
think the ACPI
spec is unclear on certain points so that the linux implementation may
not be adequate
for some machines.

<gory_technical_details>

In brief, the bug is that thermal Notify events are never processed
until
someone explicitly reads the temperature
(e.g. /proc/acpi/thermal_zone/TZ1/temperature).
According to my analysis, thermal events on the nx6125 are handled by a
control method
(_L19) which issues a Notify event to the OS and then Sleeps and loops
waiting for the
OS to reset the trip points and clear the exception condition.

It seems to me that this causes a deadlock, because the GPE events and
the Notify
events are queued in a single-threaded workqueue and the Notify events
cannot be
processed until after _L19 returns.

</gory_technical_details>

This is described in http://bugzilla.kernel.org/show_bug.cgi?id=5534#c65
and
http://bugzilla.kernel.org/show_bug.cgi?id=5534#c66.

My question is this: If this analysis is true, it means that the HP BIOS
is
expecting some type of concurrent execution of ACPI control methods.
This seems to
go against (one interpretation of) the ACPI spec. However, the ACPI spec
is not
entirely clear on the issue. The ACPI CA Reference Manual by Intel (one
of the
authors of the ACPI spec) says "If a control method blocks (an event
that can occur
only under a few limited conditions), another method may begin
execution. However, ???it can be said that the specification precludes
the concurrent execution of control methods???. Therefore, the AML
interpreter itself is essentially a single-threaded component of the
ACPI subsystem". This looks like equivocation to me - surely it's either
single-threaded or not! "essentially" - "it can be said" - what are they saying
here? Anyway, it seems to me that to successfully interpret this DSDT
(http://acpi.sourceforge.net/dsdt/view.php?id=558) it would be necessary to use
multiple threads in kacpid. Are there any other machines which do this kind
of clever stuff? What is the correct interpretation of the ACPI spec here?



Peter Wainwright


