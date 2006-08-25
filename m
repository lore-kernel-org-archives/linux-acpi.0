From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [patch 11/14] ACPI: change GFP_ATOMIC to GFP_KERNEL for non-atomic allocation
Date: Fri, 25 Aug 2006 07:48:25 -0700
Message-ID: <EB12A50964762B4D8111D55B764A84548005C1@scsmsx413.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36114 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030184AbWHYOtW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Aug 2006 10:49:22 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiri Kosina <jikos@jikos.cz>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

 

>-----Original Message-----
>From: Jiri Kosina [mailto:jikos@jikos.cz] 
>Sent: Friday, August 25, 2006 7:27 AM
>To: Len Brown; Pallipadi, Venkatesh
>Cc: linux-acpi@vger.kernel.org
>Subject: Re: [patch 11/14] ACPI: change GFP_ATOMIC to 
>GFP_KERNEL for non-atomic allocation
>
>On Fri, 25 Aug 2006, Jiri Kosina wrote:
>
>> > to address this on boot, Linux uses system-state. I 
>suggested doing the
>> > same for resume, but Andrew didn't like it, so here we are 
>chasing a
>> > bunch of spurious warning messages. Got any random 
>examples that are
>> > still valid in greg's tree, my tree, or the latest mm?
>> Actually I just pulled from the acpi git tree, and with this 
>kernel my IBM 
>> T42p hangs approximately 10s after the kernel is started 
>(hard lockup, no 
>> caps/numlock). Will investigate.
>
>Bisection shows that it is caused by commit 
>f62d31ee2f2f453b07107465fea54540cab418eb ACPI: Support 
>Processor Native 
>C-state using Intel "mwait" instruction. 
>
>I guess that the detection whether current CPU supports mwait 
>insn does 
>not work, but I am not too familiar with this.
>
>cpuinfo:
>
>processor	: 0
>vendor_id	: GenuineIntel
>cpu family	: 6
>model		: 13
>model name	: Intel(R) Pentium(R) M processor 1.80GHz
>stepping	: 6
>cpu MHz		: 1800.000
>cache size	: 2048 KB
>fdiv_bug	: no
>hlt_bug		: no
>f00f_bug	: no
>coma_bug	: no
>fpu		: yes
>fpu_exception	: yes
>cpuid level	: 2
>wp		: yes
>flags		: fpu vme de pse tsc msr mce cx8 sep mtrr pge 
>mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe est tm2
>bogomips	: 3590.77
>
>-- 
>JiKos.

Interesting. Let me try to reproduce the problem on a similar system
locally and look at what is happening. I should have more update by the
end of the day.

Thanks,
Venki
