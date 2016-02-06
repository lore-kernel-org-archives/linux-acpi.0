From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 00/14] ACPI 2.0: Enable TermList interpretion and early opeartion region accesses for table loading
Date: Sat,  6 Feb 2016 11:52:14 +0800
Message-ID: <cover.1454730659.git.lv.zheng@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

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

This test reveals the de-facto table loading behaviors to us:
1. During the table loading, AML opcodes out of a control method (this is
   called as module level code in ACPICA term) will be executed by the
   interpreter;
2. Not only the module level AML opcodes wrapped around by If/Else/While
   (this is the current ACPICA interpreter limitation), but all module
   level AML opcodes, including the operation region accesses, method
   invocations, will be executed by the interpreter;
3. Not only the module level AML opcodes put under the root scope (this is
   another current ACPICA interpreter limitation), but the module level AML
   opcodes under any scope will be executed by the interpreter;
4. Not only after the table loading (this is another current ACPICA
   interpreter limitation), but when the table is being loaded, the module
   level AML opcodes will be executed by the interpreter, please refer to
   the above CondRefOf validations;
5. For SystemIo, not only after the _REG(1, 1) is evaluated (this is
   another current ACPICA interpreter limitation), but when the table is
   being loaded, the SystemIo (the debugging port) is accessible.

In fact, the above behaviors has already been clarified in ACPI 2.0
specification, so the compliance issue is not that Linux is not compliant
to the de-facto standard OS, but that Linux is not compliant to ACPI 2.0.
1. Definition tables in fact is defined by the spec as TermList, which has
   no difference than the control methods:
     AMLCode := DefBlockHeader TermList
     DefMethod := MethodOp PkgLength NameString MethodFlags TermList
   Thus the interpretion of the table should be no difference that the
   control method evaluation;
2. Spec allows the default operation regions to be accessed before the
   namespace is ready (which exactly means the table loading), such
   operation regions include SystemIo, SystemMemory, PciConfig and
   EmbeddedControl provided by ECDT, note that ECDT is also an ACPI 2.0
   feature.

Why ACPICA interpreter is acting so differently from this definition?
This is because, there are many software entropies preventing this from
being enabled, such entropies need to be cleaned up first in order not
to trigger regressions for specific platforms. These entropies include:
1. ECDT support is broken. In fact, the original EC driver was correct, but
   devlopers start to use the namespace EC instead of ECDT just because
   several broken ECDT tables were reported on the bugzilla. They trusted
   the namespace EC settings rather than the ECDT ones, this leads to the
   evaluation of _REG/_GPE/_CRS and namespace walk before executing the
   module level AML opcodes. And this in fact disables early EC usages
   (used during table loading and early device enumeration processes).
2. _REG evaluations are wrong. ACPICA provides APIs for OSPMs to register
   operation region handlers. But for the early operation region accesses,
   ACPI spec declares that the evaluations of _REG are not required, but
   the ACPICA API doesn't avoid running _REG to meet this early
   requirements. Code to fix this is partially upstreamed during previous
   ACPICA release cycle.
3. _REG associations are wrong. ACPICA associate _REG control method to
   all operation region objects before executing the _REG control method.
   This can happen even when a control method is evaluated and operation
   regions defined in the method is initialized
   (acpi_ev_initialize_region). As a part of the ACPICA internal _REG
   evaluation state machine, it requires the namespace walk, and all
   namespace walk should be ensured to happen only "AFTER THE NAMESPACE IS
   INITIALIZED". But when this logic happens during the table loading, it
   may fail in finding the _REG method since the _REG method may not be
   created by the interpreter just because _REG is defined after the
   operation region object's declaration.
4. _REG(CONNECT)/_REG(DISCONNECT) executions are not balanced, this can
   lead to wrong table loading/unloading results. Since _REG evaluations
   require the releasing of all interpreter/namespace locks in order to
   allow another evaluation to happen, and ACPICA operand object
   destruction code can be invoked from different locking environment, this
   becomes difficult for the developers to provide one single function to
   make _REG(CONNECT)/_REG(DISCONNECT) balanced.
5. \_SB._INI is not the first control method evaluated by the interpreter.
   Many platforms put initialization code in \_SB._INI in order to have
   named objects initialized very early during the device enumeration
   process. Without this order is strictly ensured, early operation region
   access enabling could break these platforms.
6. Linux initialization order is wrong, it is now:
   a. load namespace without executing root scope If/Else/While module
      level code blocks;
   b. probe ECDT and instal EmbeddedControl operation region handler with
      _REG evaluated;
   c. install SystemMemory, SystemIo, PciConfig operation region handlers
      without evaluating _REG;
   d. run _REG for SystemMemory, SystemIo, PciConfig operation regions;
   e. execute root scope If/Else/While module level code blocks;
   f. enable GPE and namespace EC.
   While the correct order should be:
   a. probe ECDT and instal EmbeddedControl operation region handler with
      _REG evaluated;
   b. install SystemMemory, SystemIo, PciConfig operation region handlers
      without evaluating _REG;
   c. load namespace, in the meanshile, execute all module level AML
      opcodes;
   d. run _REG for SystemMemory, SystemIo, PciConfig operation regions;
   e. enable GPE and namespace EC.

Now it's correct timing to make things back to be spec compliant. In
order to achieve this for Linux, we need to:
1. Stop evaluating control methods before namespace is fully loaded,
   this in fact means no GPEs should be enabled during table loading since
   GPE indications may lead to _Lxx/_Exx evaluations; no EC event should be
   enabled during table loading since SCI_EC indications may lead to _Qxx
   evaluations; no _REG/_CRS should be evaluated since they apparently
   should happen in the device enumeration process which is performed after
   loading the namespace, and no namespace walk is allowed.
2. Default operation regions should be initialized and ready for accessing
   before loading the table.
This patchset fixes all above entropies and ensures the 2 above rules,
after that it enables module level AML execution in 2 steps:
1. Improve module level execution support by disabling
   acpi_gbl_group_module_level_code, this helps to move module level
   execution to per-table basis.
2. Fix module level execution support by enabling
   acpi_gbl_parse_table_as_term_list, this helps to execute the entire
   table as the way similar to a control method evaluation.
The series is tested by running Linux on Dell Latitude 6430u. Since the
platform doesn't contain ECDT, the patchset also enables initrd table
installation mechanism to fake an ECDT for testing. The patform can be
successfully powered on/off, suspended/resumed, device are also correctly
enumerated and GPEs/EC events are correctly handled.

PATCH 01-02: The initrd installation testing facility.
PATCH 03-07: Entropy reduction stuff in ACPICA.
PATCH 08-10: Entropy reduction stuff in EC driver and ACPI subsystem's
             initialization order.
PATCH 12:    The first step enabling.
PATCH 13:    The code to facilitate AML 2.0 table loading.
PATCH 14:    The second step enabling.

Lv Zheng (14):
  ACPI / OSL: Cleanup initrd table override code
  ACPI / OSL: Add support to install tables via initrd
  ACPI 2.0 / AML: Make default region accessible during the table load
  ACPI 2.0 / AML: Tune _REG evaluations order in the initialization
    steps
  ACPI 2.0 / AML: Ensure \_SB._INI executed before any _REG
  ACPI 2.0 / AML: Rename acpi_gbl_reg_methods_enabled to
    acpi_gbl_namespace_initialized
  ACPICA: Events: Fix an issue that _REG association can happen before
    namespace is initialized
  ACPI 2.0 / ECDT: Split EC_FLAGS_HANDLERS_INSTALLED
  ACPI 2.0 / ECDT: Remove early namespace reference from EC
  ACPI 2.0 / ECDT: Enable correct ECDT initialization order
  ACPI 2.0 / AML: Improve module level execution by moving the
    If/Else/While execution to per-table basis
  ACPI 2.0 / AML: Add TermList parsing support for table loading
  ACPI 2.0 / AML: Enable correct ACPI subsystem initialization order
    for new table loading mode
  ACPI 2.0 / AML: Fix module level execution by correctly parsing table
    as TermList

 drivers/acpi/acpica/acevents.h |    2 -
 drivers/acpi/acpica/acglobal.h |    2 +-
 drivers/acpi/acpica/acnamesp.h |    5 +-
 drivers/acpi/acpica/acparser.h |    2 +
 drivers/acpi/acpica/evregion.c |   71 ++++--------
 drivers/acpi/acpica/evrgnini.c |    1 -
 drivers/acpi/acpica/exconfig.c |    7 +-
 drivers/acpi/acpica/nsinit.c   |  135 +++++++++++++---------
 drivers/acpi/acpica/nsload.c   |    3 +-
 drivers/acpi/acpica/nsparse.c  |  163 +++++++++++++++++++++------
 drivers/acpi/acpica/psparse.c  |    4 +-
 drivers/acpi/acpica/psxface.c  |   73 ++++++++++++
 drivers/acpi/acpica/tbxfload.c |   23 ++++
 drivers/acpi/acpica/utxfinit.c |   46 +++-----
 drivers/acpi/bus.c             |   41 ++++---
 drivers/acpi/ec.c              |  241 ++++++++++++++++++----------------------
 drivers/acpi/internal.h        |    1 +
 drivers/acpi/osl.c             |  158 ++++++++++++++++----------
 drivers/acpi/tables.c          |    2 +
 include/acpi/acpixf.h          |    9 +-
 20 files changed, 611 insertions(+), 378 deletions(-)

-- 
1.7.10
