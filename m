From: "Brown, Len" <len.brown@intel.com>
Subject: MSR Len Brown Oct 11, 2012
Date: Thu, 11 Oct 2012 19:05:42 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C94828CE0D26@FMSMSX108.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46944 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964914Ab2JKTFr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Oct 2012 15:05:47 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Schlobohm, Bruce" <bruce.schlobohm@intel.com>
Cc: SSD-OTC ALL <ssd-otc.all@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-power-mgmt@linux.intel.com" <linux-power-mgmt@linux.intel.com>

> Upstream Linux 3.7 merge window

Enabled IVT support in intel_idle driver.  This should give better scaling
than the default acpi-idle driver on big systems.  It also allows us to tune
where acpi-idle doesn't allow us to tune.  (IVB was enabled in 3.6)

(For HSW, hoping to get a probing mechanism working where we don't
need to get C-state information documented in public before we
add processor support to intel_idle.)

Found a minor bug in IVT while testing this support (HSD 4677325).
The wrong residency counter (C6) would increment on entering C7.
The fix is actually to de-feature C7, which is identical to C6
on IVT.  Indeed, SNB-Xeon should have de-featured it too,
but at least they got the counters right.

Pushed acpidump utility into upstream Linux kernel git tree.
This utility is used for ACPI debugging on Linux,
and needed a home since kernel.org web vanished last year.
SuSE and some others ship this utility in their distro.

Pushed an update to the turbostat utility to count SMI's,
Thank you to Andi Kleen for suggesting it -- very handy.

Send upstream Linux pull request for Zhang-Rui's Thermal tree.
Rui has a Linux-next tree, and next release will
likely push his release branch directly to Linus.

> Idle power management

IVT architects have accepted our request to create a mechanism
where the BIOS can remove C-states from CPUID.MWAIT leaf.
Large OEM BIOS teams are accustomed to being able to disable
C-states from the BIOS for performance and RAS reasons, and
complained about losing that capability in NHM/WSM/SNB.
Unfortunately, they'll have to settle for using Linux
to enable/disable C-states until IVT.  The IVT proposal
must get through CART.

> Memory power management

Welcome Srinivas Pandruvada!
Srinivas has transferred to our team to focus on memory power management.
We will explore if we can better expose the value of the Precharge-Power-Down (PPD)
capability that is supported in SNB-Xeon and later.

> Welcome Rafael Wysocki!

Rafael Wysocki joins Intel/OTC from U. Warsaw.
Rafael will continue his upstream power management responsibilities,
and also add ACPI sub-system maintenance to that list.

> Logistics

Have initiated a US/Europe weekly forum to help coordinate
and communicate the various power-related projects cooking.
This is in addition to the traditional US/China forum.

WW42.Mon,Tue will attend "Linux Technology Days" in Portland.
WW42.Wed-Fri will work from JF, as will Rafael.

