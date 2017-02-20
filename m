From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH 0/2] Revert works for the mapping of cpuid <-> nodeid
Date: Mon, 20 Feb 2017 13:28:19 +0800
Message-ID: <1487568501-16795-1-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:17655 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750737AbdBTF2o (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Feb 2017 00:28:44 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org, rjw@rjwysocki.net, hpa@zytor.com, rafael@kernel.org, cl@linux.com, tj@kernel.org, akpm@linux-foundation.org, rafael.j.wysocki@intel.com, len.brown@intel.com, izumi.taku@jp.fujitsu.com
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>

Currently, We make the mapping of "cpuid <-> nodeid" fixed at the booting time.
It keeps consistent with the WorkQueue and avoids some bugs which may be caused
by the dynamic assignment.
As we know, It is implemented by the patches as follows: 2532fc318d, f7c28833c2,
8f54969dc8, 8ad893faf2, dc6db24d24, which depend on ACPI table. Simply speaking:

Step 1. Make the "Logical CPU ID <-> Processor ID/UID" fixed Using MADT:
We generate the logical CPU IDs by the Local APIC/x2APIC IDs orderly and
get the mapping of Processor ID/UID <-> Local Apic ID directly in MADT.
So, we get the mapping of
*Processor ID/UID <-> Local Apic ID <-> Logical CPU ID*

Step 2. Make the "Processor ID/UID <-> Node ID(_PXM)" fixed Using DSDT:
The maaping of "Processor ID/UID <-> Node ID(_PXM)" is ready-made in
each entities. we just use it directly.

So, at last we get the maaping of *Node ID <-> Logical CPU ID* according to
step1 and step2:
*Node ID(_PXM) <-> Processor ID/UID <-> Local Apic ID <-> Logical CPU ID*

But, The ACPI table is unreliable and it is very risky that we use the entity
which isn't related to a physical device at booting time. Here has already two
bugs we found.
1. Duplicated Processor IDs in DSDT.
	It has been fixed by commit 8e089eaa19, fd74da217d.
2. The _PXM in DSDT is inconsistent with the one in MADT.
	It may cause the bug, which is shown in:
		https://lkml.org/lkml/2017/2/12/200
There may be more later. We shouldn't just only fix them everytime, we should
solve this problem from the source to avoid such problems happend again and
again.

Now, a simple and easy way is found, we revert our patches. Do the Step 2 
at hot-plug time, not at booting time where we did some useless work.

It also can make the mapping of "cpuid <-> nodeid" fixed and avoid excessive
use of the ACPI table.

We have tested them in our box: Fujitsu PQ2000 with 2 nodes for hot-plug.
To Xiaolong: 
	Please help me to test it in the special machine.

Dou Liyang (2):
  Revert"x86/acpi: Set persistent cpuid <-> nodeid mapping
  Revert"x86, acpi, cpu-hotplug: Enable MADT APIs to return disabled
    apicid"

 arch/x86/kernel/acpi/boot.c   |   2 +-
 drivers/acpi/acpi_processor.c |   5 --
 drivers/acpi/bus.c            |   1 -
 drivers/acpi/processor_core.c | 133 +++++++-----------------------------------
 include/linux/acpi.h          |   3 -
 5 files changed, 23 insertions(+), 121 deletions(-)

-- 
2.5.5



