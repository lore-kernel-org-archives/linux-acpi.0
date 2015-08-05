From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v2 0/4] ACPI: Update method tracing facility.
Date: Wed,  5 Aug 2015 16:23:36 +0800
Message-ID: <cover.1438762804.git.lv.zheng@intel.com>
References: <cover.1437627016.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437627016.git.lv.zheng@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

ACPICA subsystem provides debugging outputs when CONFIG_ACPI_DEBUG is
enabled. The debugging messages which are deployed via ACPI_DEBUG_PRINT()
macro can be reduced at 2 levels - per-component level (known as debug
layer) and per-type level (known as debug level). But when the particular
layer/level is specified for all control method evaluations, the quantity
of the debugging outputs may still be too huge to be put into the kernel
log buffer.
Originally we have a method tracing facility to further reduce the
debugging output so that the debugging output can be bounded to the
specified control method evaluation(s).
Let me call it "log reducer" to distinguish another feature provided by the
method tracing facility.
We can specify a method name, for example, "_PS0", and corresponding debug
layer/level for the "log reducer". When the AML interpreter starts to
execute the method, the tracing debug layer/level will be applied. When the
AML interpreter stops to execute the method, the original debug layer/level
is restored.
In this way, the useful debug layer/level can only apply when the matched
method is executed and the debugging output thus can be reduced.

The facility invokes acpi_debug_trace() to do the flexible settings.
See Documentation/acpi/method-tracing.txt for reference.

Actually, the "log reducer" facility is buggy and some of the shortcomings
put us into the trouble in using it.
1. We cannot specify a full path for the tracing method. For example,
   though we only want to track \_SB,PCI0.I2C0._PS0, we can only specify
   "_PS0" and all _PS0 method execution logs will be dumped, the unwanted
   _PS0 execution trace logs may still blow the kernel log buffer up.
2. We can only specify a method that is passed to acpi_evaluate_object().
   For example, if \_SB.LID0._LID invokes \_SB.PCI0.LPCB.H_EC.ECRD, since
   Linux never passes \_SB.PCI0.LPCB.H_EC.ECRD to acpi_evaluate_object(),
   specifying "ECRD" cannot match the start of the execution to enable the
   "log reducer".

In order to achieve the fixes, the following enhancements are done during
this ACPICA 20150717 release:
1.  During this ACPICA 20150717 release, we re-implement the facility in the
ACPICA dispatcher rather than implementing it in acpi_evaluate_object() and
allows the full path to be specified to precisely lock on a specific
control method. It is achieved by doing the following improvements:
1. Re-implements the facility in the ACPICA dispatcher component ratner
   than implementing it in acpi_evaluate_object().
2. Allows full path to be specified to precisely lock on a specific control
   method.
3. Introduce a new AML path -> ASL path decoding facility to zap the
   trailing underscore. Originally ACPICA decodes AML path into such a
   format that the user must explicitly specify the trailing. And users are
   likely to forget to put the underscores and leave us with useless trace
   logs.
4. Move the exception stack walker from the ACPICA debugger component to
   the ACPICA dispatcher component. When an exception is encountered, AML
   interpreter just jumps to the top of the stack. Thus we need a facility
   to walk the stack so that the method can be matched to implement the
   "end of the tracing".

And with the improvements, we now can do an exciting tracing:
1. When the trace is enabled, we add new log entries for the begin/end of
   each control method that is executed by the interpreter.
2. When the trace is enabled, we add new log entries for the begin/end of
   each opcode that is executed by the interpreter.
3. We allow the method virtual address and the opcode virtual address to be
   dumped along with the begin/end logs.
This makes it possible to draw a AML call graph using the dumped log and we
can calculate the execution time of a control method/opcode. We can use it
either for performance tuning or remote debugging. Let me call the new
feature as "AML tracer" to distinguish it from the feature described above.

All of the above improvements are done to the acpi_debug_trace(), new
features/parameters are added to this ACPICA interface. Now
acpi_debug_trace() can be used not only as the "log reducer" but also the
"AML tracer".

As the userspace interface of acpi_debug_trace(),
/sys/modules/acpi/parameters/trace_xxx files need to be updated so that we
can use the fixed/improved old feature and the new feature in the Linux
kernel.

Lv Zheng (4):
  ACPI / sysfs: Add ACPI_LV_REPAIR debug level.
  ACPI / sysfs: Update method tracing facility.
  ACPI / sysfs: Add support to allow leading "\" missing in
    trace_method_name.
  ACPI / Documentation: Update method tracing documentation.

 Documentation/acpi/method-tracing.txt |  204 ++++++++++++++++++++++++++++++---
 drivers/acpi/osl.c                    |    8 ++
 drivers/acpi/sysfs.c                  |  133 +++++++++++++++------
 3 files changed, 291 insertions(+), 54 deletions(-)

-- 
1.7.10
