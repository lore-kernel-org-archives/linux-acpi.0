From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v5 0/5] ACPI 2.0: Stop defer-executing module level code
Date: Fri, 23 Sep 2016 11:26:26 +0800
Message-ID: <cover.1474600034.git.lv.zheng@intel.com>
References: <0e65135af51d94db0410c7059f3bc3a2300fc3b5>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:25525 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934088AbcIWD0f (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Sep 2016 23:26:35 -0400
In-Reply-To: <0e65135af51d94db0410c7059f3bc3a2300fc3b5>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

After fixing ACPICA internal locking issues, we can enable the correct
grammar support for the table loading. The new grammar treats the entire
table as TermList rather than ObjectList, thus the module level code should
be executed right in place.

MLC (module level code) is an ACPICA terminology describing the AML code
out of any control method, currently only Type1Opcode (If/Else/While)
wrapped MLC code blocks are executed by the AML interpreter after the table
loading. But the issue which is fixed by this patchset is:
   Not only Type1Opcode, but also Type2Opcode will be executed as MLC and
   MLC is not defer-executed after loading the table, but is executed right
   in place.

The following AML code is assembled into a static loading SSDT, and used
as an instrumentation to pry into the de-facto standard AML interpreter
behaviors:
  Name (ECOK, Zero)
  Scope (\)
  {
      DBUG ("TermList 1")
      If (LEqual (ECOK, Zero))
      {
          DBUG ("TermList 2")
          Device (MDEV)
          {
              DEBUG (TermList 3")
              If (CondRefOf (MDEV))
              {
                  DBUG ("MDEV exists")
              }
              If (CondRefOf (MDEV._STA))
              {
                  DBUG ("MDEV._STA exists")
              }
              If (CondRefOf (\_SB.PCI0.EC))
              {
                  DBUG ("\\_SB.PCI0.EC exists")
              }
              Name (_HID, EisaId ("PNP9999"))
              Method (_STA, 0, Serialized)
              {
                  DEBUG ("\\_SB.MDEV._STA")
                  Return (0x0F)
              }
          }
          DBUG ("TermList 4")
      }
      Method (_INI, 0, Serialized)
      {
          DBUG ("\\_SB._INI")
      }
  }
  Scope (_SB.PCI0)
  {
      Device (EC)
      {
          ...
      }
  }
The DBUG function is a function to write the debugging messages into a
SystemIo debug port.
Running Windows with the BIOS providing this SSDT via RSDT, the following
messages are obtained from the debug port:
  TermList 1
  TermList 2
  TermList 3
  \_SB.MDEV exists
  TermList 4
  \_SB._INI
  ...

This test reveals the de-facto grammar for the AMLCode to us:
1. During the table loading, MLC will be executed by the interpreter, this
   is partially supported by the current ACPICA;
2. For SystemIo, not only after the _REG(1, 1) is evaluated (current ACPICA
   interpreter limitation), but when the table is being loaded, the
   SystemIo (the debugging port) is accessible, this is recently fixed in
   the upstream, now all early operation regions are accessible during the
   table loading;
3. Not only Type1Opcode, but also Type2Opcode will be executed as MLC and
   MLC is not executed after loading the table, but is executed right in
   place, the Linux upstream is not compliant to this behavior.

The last compliance issue has already been clarified in ACPI 2.0
specification, so the compliance issue is not that Linux is not compliant
to the de-facto standard OS, but that Linux is not compliant to ACPI 2.0.
Definition block tables in fact is defined by the spec as TermList, which
has no difference than the control methods, thus the interpretion of the
table should be no difference that the control method evaluation:
     AMLCode := DefBlockHeader TermList
     DefMethod := MethodOp PkgLength NameString MethodFlags TermList
Now the new upcoming ACPI specification has been clarified around the above
grammar primitives, so we need to implement them for Linux.

This patchset also contains 2 required fixes generated to fix the
regressions detected by the ACPICA ASLTS tool. The ASLTS 'table' test suite
has detected such regressions. The fixes have been accepted by the ACPICA
upstream (please refer to the ACPICA upstream URL in the description of the
2 patches). And they are sent to Linux community as urgent materials along
with the module level code enabling series. With the additional regression
fixes, new grammar changes have passed all ASLTS 'table' cases:
  https://bugs.acpica.org/show_bug.cgi?id=1327
  https://github.com/acpica/acpica/pull/177

Lv Zheng (5):
  ACPICA: Tables: Fix "UNLOAD" code path lock issues
  ACPICA: Parser: Fix a regression in LoadTable support
  ACPI 2.0 / AML: Enable correct ACPI subsystem initialization order
    for new table loading mode
  ACPI 2.0 / AML: Improve module level execution by moving the
    If/Else/While execution to per-table basis
  ACPI 2.0 / AML: Fix module level execution by correctly parsing table
    as TermList

 drivers/acpi/acpica/exconfig.c |   23 +++++++++++++++++++----
 drivers/acpi/acpica/psxface.c  |   11 +++++++++++
 drivers/acpi/acpica/tbdata.c   |    7 +------
 drivers/acpi/acpica/tbxfload.c |    9 ++++++---
 drivers/acpi/bus.c             |    6 ++++--
 include/acpi/acpixf.h          |    7 +++----
 6 files changed, 44 insertions(+), 19 deletions(-)

-- 
1.7.10

