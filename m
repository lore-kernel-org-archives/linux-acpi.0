From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [RFC][PATCH] Document what in IRQ is.
Date: Tue, 02 May 2006 07:52:22 -0600
Message-ID: <m1aca07cvd.fsf_-_@ebiederm.dsl.xmission.com>
References: <CFF307C98FEABE47A452B27C06B85BB652DF16@hdsmsx411.amr.corp.intel.com>
	<200605020946.46050.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964822AbWEBNxO@vger.kernel.org>
In-Reply-To: <200605020946.46050.ak@suse.de> (Andi Kleen's message of "Tue,
 2 May 2006 09:46:45 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: "Brown, Len" <len.brown@intel.com>, "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>, sergio@sergiomb.no-ip.org, Kimball Murray <kimball.murray@gmail.com>, linux-kernel@vger.kernel.org, akpm@digeo.com, kmurray@redhat.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> P.S.: There seems to be a lot of confusion about all this.
> Maybe it would make sense to do a write up defining all the terms
> and stick it into Documentation/* ? 

How does this look?

I am pretty horrible when it comes to Documentation,
but this seems to be the essence of what I was saying earlier.

Eric


diff --git a/Documentation/IRQ.txt b/Documentation/IRQ.txt
new file mode 100644
index 0000000..5340369
--- /dev/null
+++ b/Documentation/IRQ.txt
@@ -0,0 +1,22 @@
+What is an IRQ?
+
+An IRQ is an interrupt request from a device.
+Currently they can come in over a pin, or over a packet.
+IRQs at the source can be shared.
+
+An IRQ number is a kernel identifier used to talk about a hardware
+interrupt source.  Typically this is an index into the global irq_desc
+array, but except for what linux/interrupt.h implements the details
+are architecture specific.
+
+An IRQ number is an enumeration of the possible interrupt sources on a
+machine.  Typically what is enumerated is the number of input pins on
+all of the interrupt controller in the system.  In the case of ISA
+what is enumerated are the 16 input pins to the pair of i8259
+interrupt controllers.
+
+Architectures can assign additional meaning to the IRQ numbers, and
+are encouraged to in the case  where there is any manual configuration
+of the hardware involved.  The ISA IRQ case on x86 where anyone who
+has been around a while can tell you how the first 16 IRQs map to the
+input pins on a pair of i8259s is the classic example.
