From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v3 0/5] Do repair works for the mapping of cpuid <-> nodeid
Date: Fri, 3 Mar 2017 16:02:22 +0800
Message-ID: <1488528147-2279-1-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:22579 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751512AbdCCILg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2017 03:11:36 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, rjw@rjwysocki.net, lenb@kernel.org, xiaolong.ye@intel.com, guzheng1@huawei.com, izumi.taku@jp.fujitsu.com
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dou Liyang <douly.fnst@cn.fujitsu.com>

[Summary]:

1, Revert two commits
2, Fix the order of Logical CPU IDs
3, Move the validation of processor IDs to hot-plug time. 

The mapping of "cpuid <-> nodeid" is established at boot time via ACPI
tables to keep associations of workqueues and other node related items
consistent across cpu hotplug as following:  

Step 1. Make the "Logical CPU ID <-> Processor ID/UID" fixed Using MADT:
We generate the logical CPU IDs by the Local APIC/x2APIC IDs orderly and
get the mapping of Processor ID/UID <-> Local Apic ID directly in MADT.
So, we get the mapping of
*Processor ID/UID <-> Local Apic ID <-> Logical CPU ID*

Step 2. Make the "Processor ID/UID <-> Node ID(_PXM)" fixed Using DSDT:
The maaping of "Processor ID/UID <-> Node ID(_PXM)" is ready-made in
each entities. we just use it directly.

But, ACPI tables are unreliable and failures with that boot time mapping
have been reported on machines where the ACPI table and the physical
information which is retrieved at actual hotplug is inconsistent. Here
has already two bugs we found:

1. Duplicated Processor IDs in DSDT.
	It has been fixed by commits:
	'8e089eaa1999 ("acpi: Provide mechanism to validate processors
in the ACPI tables")' and 'fd74da217df7 ("acpi: Validate processor id
when mapping the processor")'

2. The _PXM in DSDT is inconsistent with the one in MADT.
	It may cause the bug, which is shown in:
		https://lkml.org/lkml/2017/2/12/200

And one phenomenon is happened in some specific boxes:

1. The logical CPU IDs is discrete. Such as:
	Node2: 64-69, 72-77, 80-85, 88-93,...

There may be more strange things happened in the futher. We shouldn't just
only fix them everytime, we should solve this problem from the source to
avoid such problems happened again and again.

Find a simple and easy way:

1. Do the step 1 when the CPU flag is enabled
2. Do the step 2 at hot-plug time, not at boot time when we did some
useless work.

It also can make the mapping of "cpuid <-> nodeid" fixed and avoid
excessive using of the ACPI tables.

Change log:
  v2 -> v3: 1. rewirte the changelogs
		copy the changelogs Thomas Gleixner <tglx@linutronix.de>
		rewrite for the patch 1,2,4,5.
            2. s/duplicate_processor_id()/acpi_duplicate_processor_id().
		by Thomas Gleixner <tglx@linutronix.de>'s advice.
            3. modify the error handle in acpi_processor_ids_walk()
		by Thomas Gleixner <tglx@linutronix.de>'s advice.
            4. add a new patch for restoring the order of CPU IDs

  v1 -> v2: 1. fix some comments.
            2. add the verification of duplicate processor id.

Dou Liyang (5):
  Revert"x86/acpi: Set persistent cpuid <-> nodeid mapping when booting"
  Revert"x86/acpi: Enable MADT APIs to return disabled apicids"
  x86/acpi: Restore the order of CPU IDs
  acpi/processor: Implement DEVICE operator for processor enumeration
  acpi/processor: Check for duplicate processor ids at hotplug time

 arch/x86/kernel/acpi/boot.c   |   9 ++-
 arch/x86/kernel/apic/apic.c   |  26 +++------
 drivers/acpi/acpi_processor.c |  57 +++++++++++++-----
 drivers/acpi/bus.c            |   1 -
 drivers/acpi/processor_core.c | 133 +++++++-----------------------------------
 include/linux/acpi.h          |   5 +-
 6 files changed, 79 insertions(+), 152 deletions(-)

-- 
2.5.5



