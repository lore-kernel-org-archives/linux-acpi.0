From: "Brown, Len" <len.brown@intel.com>
Subject: kernel vs user power management
Date: Sat, 8 Apr 2006 02:42:12 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB622B194@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:10134 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751356AbWDHGmS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 8 Apr 2006 02:42:18 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: thoenig@suse.de, Holger Macht <hmacht@suse.de>
Cc: linux-acpi@vger.kernel.org, linux-laptop@vger.kernel.org, Andi Kleen <ak@suse.de>

Timo, Holger,
Andi pointed me to your FOSDEM Linux Power Management presentation:

http://en.opensuse.org/FOSDEM2006

http://files.opensuse.org/opensuse/en/b/b5/One_step_opendesign.pdf

And I'm glad to see you working on Linux Power Management.

But I'm a little concerned that user-space and the kernel are
a little out of sync on a few things.

I'm happy to see that the userspace p-state governor
is no longer enabled by default on SuSE systems.
While it was passable on servers with steady-state
workloads, it was very bad for laptops where the
machine spends a lot of time idle, but has short
bursts of processing need which userspace could
not detect.  These laptops would spend virtually
all their time in Pn when using the userspace governor.

The next step is to delete the userspace governor
as a valid governor selection entirely.  If somebody
really wants manual control, they can still set the
limits within which "ondemand" will stay.

I'm happy to see that clock throttling is not enabled by
default in recent SuSE release, at least on my laptop
which supports P-states.

I'd like to see no option to enable clock-throttling on
systems that support real p-states.

It is useful only for workloads which have an infinite
amount of non-idle computing which you don't care how
slow it computes.  For the vast majority of workloads
it just slows down the machine and delays the processor
from getting into idle where it can save a non-linear
amount of power.  Further, there exist today systems which
will consume MORE power in deep C-states when throttled
vs. when not throttled.

The other major topic is the user/kernel interface
for power management policy.  there needs to be in-kernel
state for this, else the device drivers will have no low-latency
way to get the answer to the simple policy question of how they should
optimize for performance vs power at any given instant when they
recognize their device is idle..  this state should be controlled
by user space, but I think it is most practical for it to
be kernel resident.

thanks,
-Len
