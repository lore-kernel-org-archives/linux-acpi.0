From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3] ARM64: kernel: implement ACPI parking protocol
Date: Thu, 25 Feb 2016 09:24:27 +0000
Message-ID: <20160225092427.GA31728@red-moon>
References: <1453806638-23167-1-git-send-email-lorenzo.pieralisi@arm.com>
 <20160202182657.GC15706@e104818-lin.cambridge.arm.com>
 <20160203112112.GA18387@red-moon>
 <20160203161834.GB26487@MBP.local>
 <20160224141832.GA26630@red-moon>
 <56CE3C9E.7070505@riken.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49981 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760152AbcBYJWT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 25 Feb 2016 04:22:19 -0500
Content-Disposition: inline
In-Reply-To: <56CE3C9E.7070505@riken.jp>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Itaru Kitayama <itaru.kitayama@riken.jp>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Mark Salter <msalter@redhat.com>, Al Stone <ahs3@redhat.com>, linux-arm-kernel@lists.infradead.org, Loc Ho <lho@apm.com>

On Thu, Feb 25, 2016 at 08:28:30AM +0900, Itaru Kitayama wrote:
> Lorenzo,
> 
> On Mustang the lockdep warning I reported to you is disappeared and
> the system gets to
> the prompt as you implemented, however only 7 CPUs out of 8 brought up.

It is because, as I mentioned in the other reply to this thread,
the VA should be stashed before setting up the mailboxes, patch below,
that should be final (I tested it on AMD Seattle too), please give it a go.

Thanks,
Lorenzo

-- >8 --
diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
index 4b1e5a7..dd671ef 100644
--- a/arch/arm64/kernel/acpi_parking_protocol.c
+++ b/arch/arm64/kernel/acpi_parking_protocol.c
@@ -21,7 +21,14 @@
 
 #include <asm/cpu_ops.h>
 
+struct parking_protocol_mailbox {
+	__le32 cpu_id;
+	__le32 reserved;
+	__le64 entry_point;
+};
+
 struct cpu_mailbox_entry {
+	struct parking_protocol_mailbox __iomem *mailbox;
 	phys_addr_t mailbox_addr;
 	u8 version;
 	u8 gic_cpu_id;
@@ -59,12 +66,6 @@ static int acpi_parking_protocol_cpu_prepare(unsigned int cpu)
 	return 0;
 }
 
-struct parking_protocol_mailbox {
-	__le32 cpu_id;
-	__le32 reserved;
-	__le64 entry_point;
-};
-
 static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
 {
 	struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
@@ -97,6 +98,12 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
 	}
 
 	/*
+	 * stash the mailbox address mapping to use it for further checks
+	 * in postboot method
+	 */
+	cpu_entry->mailbox = mailbox;
+
+	/*
 	 * We write the entry point and cpu id as LE regardless of the
 	 * native endianness of the kernel. Therefore, any boot-loaders
 	 * that read this address need to convert this address to the
@@ -107,8 +114,6 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
 
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
 
-	iounmap(mailbox);
-
 	return 0;
 }
 
@@ -116,32 +121,15 @@ static void acpi_parking_protocol_cpu_postboot(void)
 {
 	int cpu = smp_processor_id();
 	struct cpu_mailbox_entry *cpu_entry = &cpu_mailbox_entries[cpu];
-	struct parking_protocol_mailbox __iomem *mailbox;
+	struct parking_protocol_mailbox __iomem *mailbox = cpu_entry->mailbox;
 	__le64 entry_point;
 
-	/*
-	 * Map mailbox memory with attribute device nGnRE (ie ioremap -
-	 * this deviates from the parking protocol specifications since
-	 * the mailboxes are required to be mapped nGnRnE; the attribute
-	 * discrepancy is harmless insofar as the protocol specification
-	 * is concerned).
-	 * If the mailbox is mistakenly allocated in the linear mapping
-	 * by FW ioremap will fail since the mapping will be prevented
-	 * by the kernel (it clashes with the linear mapping attributes
-	 * specifications).
-	 */
-	mailbox = ioremap(cpu_entry->mailbox_addr, sizeof(*mailbox));
-	if (!mailbox)
-		return;
-
 	entry_point = readl_relaxed(&mailbox->entry_point);
 	/*
 	 * Check if firmware has cleared the entry_point as expected
 	 * by the protocol specification.
 	 */
 	WARN_ON(entry_point);
-
-	iounmap(mailbox);
 }
 
 const struct cpu_operations acpi_parking_protocol_ops = {
