From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH v3 0/5] ACPI 2.0: Enable TermList interpretion for table loading
Date: Mon, 20 Jun 2016 17:07:14 +0800
Message-ID: <cover.1466413497.git.lv.zheng@intel.com>
References: <0e65135af51d94db0410c7059f3bc3a2300fc3b5>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2215 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751235AbcFTJHV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Jun 2016 05:07:21 -0400
In-Reply-To: <0e65135af51d94db0410c7059f3bc3a2300fc3b5>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

MLC (module level code) is an ACPICA terminology describing the AML code
out of any control method, currently only Type1Opcode (If/Else/While)
wrapped MLC code blocks are executed by the AML interpreter after the table
loading. But the issue which is fixed by this patchset is:
   Not only Type1Opcode, but also Type2Opcode will be executed as MLC and
   MLC is not executed after loading the table, but is executed right in
   place.

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

Why ACPICA interpreter is acting so differently from this definition? This
is because, there are many software entropies preventing this from being
enabled, such entropies need to be cleaned up first in order not to trigger
regressions for specific platforms. These entropies include:
1. ECDT support is broken. In fact, the original EC driver was correct, but
   devlopers started to use the namespace EC instead of ECDT just because
   several broken ECDT tables were reported on the bugzilla. They trusted
   the namespace EC settings rather than the ECDT ones, this led to the
   evaluation of _REG/_GPE/_CRS and namespace walk before executing the
   module level AML opcodes. And the fixes in fact finally disable early EC
   usages (used during table loading and early device enumeration
   processes).
2. _REG evaluations are wrong. ACPICA provides APIs for OSPMs to register
   operation region handlers. But for the early operation region accesses,
   ACPI spec declares that the evaluations of _REG are not required, but
   the ACPICA APIs do not avoid running _REG to meet this early
   requirements. Code to fix this is partially upstreamed during previous
   ACPICA release cycle.
3. _REG associations are wrong. ACPICA associates _REG control method to
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
   process. Without this order strictly ensured, early operation region
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
   a. probe ECDT and install EmbeddedControl operation region handler
      without evaluating _REG;
   b. install SystemMemory, SystemIo, PciConfig operation region handlers
      without evaluating _REG;
   c. load namespace, in the meanshile, execute all module level AML
      opcodes;
   d. run _REG for SystemMemory, SystemIo, PciConfig operation regions;
   e. enable GPE and namespace EC which results in _REG evaluation for EC.

Until now we've upstreamed most of the entropy fixes into the Linux kernel,
tested the grammar switch in the ACPICA upstream using ASLTS and no
significant regressions can be seen while we need more tests before it is
merged:
  https://github.com/acpica/acpica/pull/134
This is the ASLTS running result after applying the grammar switch, the
test cases include new "module" case for which ACPICA interpreter cannot
pass without this grammar switch applied:
  ============================================================
  Test cases specified for running:
       arithmetic
       bfield
       constant
       control
       descriptor
       logic
       manipulation
       name
       reference
       region
       synchronization
       table
       misc
       provoke
       oarg
       oconst
       olocal
       onamedloc
       onamedglob
       opackageel
       oreftonamed
       oreftopackageel
       oreturn
       rstore
       roptional
       rcopyobject
       rindecrement
       rexplicitconv
       badasl
       namespace
       exc
       exc_ref
       exc_operand2
       exc_result2
       exc_tbl
       mt_mutex
       extra
       extra_aslts
       bdemo
       bdemof
       condbranches
  TOTAL: (32-bit norm mode)
    PASS       :  0
    FAIL       :  0
    BLOCKED    :  0
    SKIPPED    :  0
    Tests      :   0
    Test Cases       : 40 (of 47)
    Test Collections : 7 (of 8)
    Outstanding allocations after execution : 0
    Outstanding allocations (ACPI Error)    : 0
    Large Reference Count   (ACPI Error)    : 0
    Memory consumption total                : 0 Kb
  TOTAL: (64-bit norm mode)
    PASS       :  0
    FAIL       :  0
    BLOCKED    :  0
    SKIPPED    :  0
    Tests      :   0
    Test Cases       : 40 (of 47)
    Test Collections : 7 (of 8)
    Outstanding allocations after execution : 0
    Outstanding allocations (ACPI Error)    : 0
    Large Reference Count   (ACPI Error)    : 0
    Memory consumption total                : 0 Kb
  TOTAL: (32-bit slack mode)
    PASS       :  0
    FAIL       :  0
    BLOCKED    :  0
    SKIPPED    :  0
    Tests      :   0
    Test Cases       : 40 (of 47)
    Test Collections : 7 (of 8)
    Outstanding allocations after execution : 0
    Outstanding allocations (ACPI Error)    : 0
    Large Reference Count   (ACPI Error)    : 0
    Memory consumption total                : 0 Kb
  TOTAL: (64-bit slack mode)
    PASS       :  0
    FAIL       :  0
    BLOCKED    :  0
    SKIPPED    :  0
    Tests      :   0
    Test Cases       : 40 (of 47)
    Test Collections : 7 (of 8)
    Outstanding allocations after execution : 0
    Outstanding allocations (ACPI Error)    : 0
    Large Reference Count   (ACPI Error)    : 0
    Memory consumption total                : 0 Kb
  ============================================================

Since we need more tests from the real users, we could make the grammar
switch released from the Linux upstream. It's safe to do so because we have
implemented regression protection (acpi_gbl_parse_table_as_term_list) in
the fixes. The earlier the fix is tested by more real users, the better
quality can be achieved by knowing the unknown cases (if any).

Lv Zheng (5):
  ACPICA: Namespace: Fix a regression that MLC support triggers dead
    lock in dynamic table loading
  ACPICA: Dispatcher: Fix an issue that the opregions created by the
    linked MLC were not tracked
  ACPICA: ACPI 2.0, Interpreter: Fix MLC issues by switching to new
    TermList grammar for table loading
  ACPI 2.0 / AML: Enable correct ACPI subsystem initialization order
    for new table loading mode
  ACPI 2.0 / AML: Fix module level execution by correctly parsing table
    as TermList

 drivers/acpi/acpica/acnamesp.h |    3 +
 drivers/acpi/acpica/acparser.h |    2 +
 drivers/acpi/acpica/dsopcode.c |    6 ++
 drivers/acpi/acpica/evrgnini.c |    3 +-
 drivers/acpi/acpica/exconfig.c |    5 +-
 drivers/acpi/acpica/nsload.c   |    3 +-
 drivers/acpi/acpica/nsparse.c  |  169 ++++++++++++++++++++++++++++++++--------
 drivers/acpi/acpica/psparse.c  |    4 +-
 drivers/acpi/acpica/psxface.c  |   71 +++++++++++++++++
 drivers/acpi/acpica/tbxfload.c |    3 +-
 drivers/acpi/acpica/utxfinit.c |    3 +-
 drivers/acpi/bus.c             |    6 +-
 include/acpi/acpixf.h          |    6 ++
 13 files changed, 245 insertions(+), 39 deletions(-)

-- 
1.7.10

