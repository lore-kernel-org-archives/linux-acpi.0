From: "Brown, Len" <len.brown@intel.com>
Subject: RE: Intel Entry Server Board - No CPU PM available
Date: Thu, 16 Mar 2006 17:22:24 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3006690634@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr14.intel.com ([192.55.52.68]:50105 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750866AbWCPWWp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Mar 2006 17:22:45 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Pavel Troller <patrol@sinus.cz>, linux-acpi@vger.kernel.org

The important thing isn't the number of idle C-states,
it is the power consumed in the C-states that are used.

Consult the data-sheet for whatever processor you drop
into this box and see what it consumes in C1.

Another thing you can do is see if you can load a cpufreq driver
on this box.  You may be limited to p4-clockmod, which
is just a linear throttling.

Generally you don't want to use throttling, as it is
usually a better power deal to finish work quickly
and then get into idle to enjoy non-linear power savings.
However, if your system is never idle, eg. it always
runs some cpu-soaker background task that never completes
and you don't care so much about its performance,
then throttling can save you power.

Throttling has no effect on power savings when idle
(since the CPU is already running at 0MHz when idle).

cheers,
-Len
