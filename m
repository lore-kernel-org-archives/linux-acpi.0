From: Ye Xiaolong <xiaolong.ye@intel.com>
Subject: Re: [PATCH v2 0/4] Revert works for the mapping of cpuid <-> nodeid
Date: Tue, 21 Feb 2017 09:02:18 +0800
Message-ID: <20170221010218.GA9932@yexl-desktop>
References: <1487580471-17665-1-git-send-email-douly.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4436 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbdBUBDM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Feb 2017 20:03:12 -0500
Content-Disposition: inline
In-Reply-To: <1487580471-17665-1-git-send-email-douly.fnst@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org, rjw@rjwysocki.net, hpa@zytor.com, rafael@kernel.org, cl@linux.com, tj@kernel.org, akpm@linux-foundation.org, rafael.j.wysocki@intel.com, len.brown@intel.com, izumi.taku@jp.fujitsu.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 02/20, Dou Liyang wrote:
>Currently, We make the mapping of "cpuid <-> nodeid" fixed at the booting time.
>It keeps consistent with the WorkQueue and avoids some bugs which may be caused
>by the dynamic assignment.
>As we know, It is implemented by the patches as follows: 2532fc318d, f7c28833c2,
>8f54969dc8, 8ad893faf2, dc6db24d24, which depend on ACPI table. Simply speaking:
>
>Step 1. Make the "Logical CPU ID <-> Processor ID/UID" fixed Using MADT:
>We generate the logical CPU IDs by the Local APIC/x2APIC IDs orderly and
>get the mapping of Processor ID/UID <-> Local Apic ID directly in MADT.
>So, we get the mapping of
>*Processor ID/UID <-> Local Apic ID <-> Logical CPU ID*
>
>Step 2. Make the "Processor ID/UID <-> Node ID(_PXM)" fixed Using DSDT:
>The maaping of "Processor ID/UID <-> Node ID(_PXM)" is ready-made in
>each entities. we just use it directly.
>
>So, at last we get the maaping of *Node ID <-> Logical CPU ID* according to
>step1 and step2:
>*Node ID(_PXM) <-> Processor ID/UID <-> Local Apic ID <-> Logical CPU ID*
>
>But, The ACPI table is unreliable and it is very risky that we use the entity
>which isn't related to a physical device at booting time. Here has already two
>bugs we found.
>1. Duplicated Processor IDs in DSDT.
>	It has been fixed by commit 8e089eaa19, fd74da217d.
>2. The _PXM in DSDT is inconsistent with the one in MADT.
>	It may cause the bug, which is shown in:
>		https://lkml.org/lkml/2017/2/12/200
>There may be more later. We shouldn't just only fix them everytime, we should
>solve this problem from the source to avoid such problems happend again and
>again.
>
>Now, a simple and easy way is found, we revert our patches. Do the Step 2 
>at hot-plug time, not at booting time where we did some useless work.
>
>It also can make the mapping of "cpuid <-> nodeid" fixed and avoid excessive
>use of the ACPI table.
>
>We have tested them in our box: Fujitsu PQ2000 with 2 nodes for hot-plug.
>To Xiaolong: 
>	Please help me to test it in the special machine.

Got it, I'll queue the tests on the previous machine and let you know the result
once I get it.

Thanks,
Xiaolong
>
>Change log:
>  v1 -> v2: 1. fix some comments.
>            2. add the verification of duplicate processor id.
>
>Dou Liyang (4):
>  Revert"x86/acpi: Set persistent cpuid <-> nodeid mapping when booting"
>  Revert"x86/acpi: Enable MADT APIs to return disabled apicids"
>  acpi: Fix the check handle in case of declaring processors using the
>    Device operator
>  acpi: Move the verification of duplicate proc_id from booting time to
>    hot-plug time
>
> arch/x86/kernel/acpi/boot.c   |   2 +-
> drivers/acpi/acpi_processor.c |  50 +++++++++++-----
> drivers/acpi/bus.c            |   1 -
> drivers/acpi/processor_core.c | 133 +++++++-----------------------------------
> include/linux/acpi.h          |   5 +-
> 5 files changed, 59 insertions(+), 132 deletions(-)
>
>-- 
>2.5.5
>
>
>
