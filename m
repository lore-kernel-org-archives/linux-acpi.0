From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] ACPI: Update method tracing facility.
Date: Fri, 24 Jul 2015 21:55:44 +0200
Message-ID: <1562441.fPJgJEEk7h@vostro.rjw.lan>
References: <cover.1437627016.git.lv.zheng@intel.com> <34244569.GOGYy9Zd5r@vostro.rjw.lan> <1AE640813FDE7649BE1B193DEA596E881EF10D85@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52879 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752539AbbGXT2y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 24 Jul 2015 15:28:54 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E881EF10D85@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Friday, July 24, 2015 02:02:33 AM Zheng, Lv wrote:
> Hi, Rafael

Hi,

> ACPICA logs contain details (trace logs) that may be useful for development.
> But the quantity of the trace logs are huge to be put into the kernel log buffer.
> Originally, we have a "trace log reducer" in /sys/modules/acpi/parameter, it is the method tracing facility.
> We can specify a method name, for example, "_PS0", and corresponding debug layer/level for the "trace log reducer".
> When the AML interpreter starts to execute the method, the tracing debug level/layer will be applied.
> When the AML interpreter stops to execute the method, the original debug level/layer is restored.
> Thus the ACPICA trace logs can only be enabled during the period the specified method is executed and its output thus can be reduced.
> The facility invokes acpi_debug_trace() to do the flexible settings.
> See Documentation/acpi/method-tracing.txt for reference.
> 
> Actually, the "trace log reducer" facility is buggy and some of the shortcomings put us into the trouble in using it.
> 1. We cannot specify a full path for the tracing method. For example, though we only want to track \_SB,PCI0.I2C0._PS0, we can only specify "_PS0" and all _PS0 method execution logs will be dumped, the unwanted _PS0 execution trace logs may still blow the kernel log buffer up.
> 2. We can only specify a method that is passed to acpi_evaluate_object(). For example, if \_SB.LID0._LID invokes \_SB.PCI0.LPCB.H_EC.ECRD, since Linux never passes \_SB.PCI0.LPCB.H_EC.ECRD to acpi_evaluate_object(), specifying "ECRD" cannot match the start of the execution to enable the "trace log reducer".
> 
> So during this ACPICA release, we re-implement the facility in the ACPICA dispatcher rather than implementing it in acpi_evaluate_object and allows the full path to be specified to precisely lock on a specific control method.
> It is achieved by doing the following improvements:
> 1. Re-implements the facility in the ACPICA dispatcher component.
> 1. Introduce a new AML path -> ASL path decoding facility to zap the trailing underscore. Originally ACPICA decodes AML path into such a format that the user must explicitly specify the trailing. And users are likely to forget to put the underscores and leave us with useless trace logs.
> 2. Move the exception stack walker from the ACPICA debugger component to the ACPICA dispatcher component. When an exception is encountered, AML interpreter just jumps to the top of the stack. Thus we need a facility to walk the stack so that the method can be matched to implement the "end of the tracing".
> 
> And with the improvements, we now can do an exciting tracing:
> 1. When the trace is enabled, we add new log entries for the begin/end of each control method that is executed by the interpreter.
> 2. When the trace is enabled, we add new log entries for the begin/end of each opcode that is executed by the interpreter.
> 3. We allow the method virtual address and the opcode virtual address to be dumped along with the begin/end logs.
> This makes it possible to draw a AML call graph using the dumped log and we can calculate the execution time of a control method/opcode.
> We can use it either for performance tuning or remote debugging.
> The new feature is known as "AML execution tracer".
> 
> All of above improvements are done to the acpi_debug_trace(), new features/parameters are added to this ACPICA interface.
> Now acpi_debug_trace() can be used not only as the "trace log reducer" but also the "AML execution tracer".
> As its user, /sys/modules/acpi/parameters/trace_xxx files need to be updated so that we can use the fixed/improved old feature and the new feature in the Linux kernel.
> 
> There is an user experience example of the new feature (AML execution tracer) on the kernel Bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id=70891
> The user reported a delay to the ACPICA developers mailing list and I helped to file a bug there.
> With the assistance of this debugging facility (see comment 29, 30, 31), I found the delay was caused by the EC driver (so this is really an effective debugging facility).
> This bug (erroneously reported as an ACPICA issue) motivated me to look at the Linux EC driver and offered the fixes to help to improve the quality of the EC/GPE implementations.
> 
> Hope this explanation can help.

All of that is good information, so what about sending a documentation patch
with it?

Rafael

